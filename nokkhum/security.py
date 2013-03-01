
from pyramid.decorator import reify
from pyramid.request import Request
from pyramid.security import unauthenticated_userid

from nokkhumclient import client, users, roles

from pyramid.threadlocal import get_current_registry, get_current_request

def groupfinder(userid, request):
    #if userid in USERS:
    #    return GROUPS.get(userid, [])
    # user = DBSession.query(model.User).filter(model.User.username == userid).first()
    request = get_current_request()
    user = request.user
    
    if user:
        # return [group.name for group in user.group]
        
        return ["r:%s"%role.name for role in user.roles]

class RequestWithUserAttribute(Request):
    @reify
    def user(self):
        # <your database connection, however you get it, the below line
        # is just an example>
        # dbconn = self.registry.settings['dbconn']
        userid = unauthenticated_userid(self)
        if userid is not None:
            
            request = get_current_request()
            # this should return None if the user doesn't exist
            # in the database
            # return dbconn['users'].query({'id':userid})
            user_dict = request.session[self.userid]['access']['user']
            user = users.User(request.nokkhum_client, 
                              user_dict)
            user.roles = [roles.Role(request.nokkhum_client, 
                                     role)
                                     for role in user_dict['roles']]
            return user
        
    @reify
    def userid(self):
        return unauthenticated_userid(self)
    
    @reify
    def s3_client(self):
        userid = unauthenticated_userid(self)
        if userid is None:
            return userid
        
        user = models.User.objects(email=userid).first()
        from .cloud.storage import s3
        from pyramid.threadlocal import get_current_registry
        settings = get_current_registry().settings

        access_key_id = settings.get('nokkhum.s3.access_key_id')
        secret_access_key = settings.get('nokkhum.s3.secret_access_key')
        host = settings.get('nokkhum.s3.host') 
        port = int(settings.get('nokkhum.s3.port'))
        
        secure = False
        if settings.get('nokkhum.s3.secure_connection') in ['true', 'True']:
            secure = True

        s3_storage = s3.S3Client(access_key_id, secret_access_key, host, port, secure)
        
        return s3_storage
    
    @reify
    def nokkhum_client(self):
        settings = get_current_registry().settings
        request = get_current_request()
        session = request.session
        
        host = settings.get('nokkhum.api.host') 
        port = int(settings.get('nokkhum.api.port'))
        username = session['email']
        password = session['password']
        
        secure_connection = False
        if settings.get('nokkhum.api.secure_connection') in ['true', 'True']:
            secure_connection = True
        
        token = None
        if request.userid in request.session:
            token = request.session[self.userid]['access']['token']['id']
            
        nk_client = client.Client(username, 
                                  password, 
                                  host, 
                                  port, 
                                  secure_connection, 
                                  token)
        return nk_client
    
    @reify
    def secret_manager(self):
        from pyramid.threadlocal import get_current_registry
        settings = get_current_registry().settings
        
        secret_manager = SecretManager(settings.get('nokkhum.auth.secret'))
        
        return secret_manager
    
import hashlib
from Crypto.Cipher import AES

class SecretManager:
    def __init__(self, secret):
        self.password_secret = secret
        self.key = ''
        
        if len(self.password_secret)%32 != 0:
            if len(self.password_secret) > 32:
                self.key = self.password_secret[:32]
                
            elif len(self.password_secret) < 32:
                self.key = self.password_secret + (' '*(32-len(self.password_secret)))
            
        
        Initial16bytes='0123456789ABCDEF' 
        self.crypt = AES.new(self.key, \
                        AES.MODE_CBC, Initial16bytes) 

#    def setPasswordSecret(self, secret):
#        self.password_secret = secret
    
    def get_password_secret(self):
        return self.password_secret

        
    def get_hash_password(self, password):
        salt = hashlib.sha1(self.get_password_secret().encode('utf-8'))
        hashPass = hashlib.sha1(password.encode('utf-8'))
        
        hashPass.update((self.get_password_secret() + salt.hexdigest()).encode('utf-8'))
        return hashPass.hexdigest()
    
    def get_encrypt_password(self, text):

        cypher = self.crypt.encrypt(text) 
        return cypher 
    
    
    def get_decrypt_password(self, cypher):

        plain_text = self.crypt.decrypt(cypher) 
        return plain_text
