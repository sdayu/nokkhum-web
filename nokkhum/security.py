from nokkhum import models

from pyramid.decorator import reify
from pyramid.request import Request
from pyramid.security import unauthenticated_userid

def groupfinder(userid, request):
    #if userid in USERS:
    #    return GROUPS.get(userid, [])
    # user = DBSession.query(model.User).filter(model.User.username == userid).first()
    user = models.User.objects(email=userid).first()
    
    if user:
        # return [group.name for group in user.group]
        return [user.group.name]

class RequestWithUserAttribute(Request):
    @reify
    def user(self):
        # <your database connection, however you get it, the below line
        # is just an example>
        # dbconn = self.registry.settings['dbconn']
        userid = unauthenticated_userid(self)
        if userid is not None:
            # this should return None if the user doesn't exist
            # in the database
            # return dbconn['users'].query({'id':userid})
            
            return models.User.objects(email=userid).first()
        
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
        setting = get_current_registry().settings

        access_key_id = setting.get('nokkhum.s3.access_key_id')
        secret_access_key = setting.get('nokkhum.s3.secret_access_key')
        host = setting.get('nokkhum.s3.host') 
        port = int(setting.get('nokkhum.s3.port'))
        secure = bool(setting.get('nokkhum.s3.secure_connection'))
        s3_storage = s3.S3Client(access_key_id, secret_access_key, host, port, secure)
        
        return s3_storage

import hashlib
from Crypto.Cipher import AES

class SecretManager:
    def __init__(self, secret):
        self.passwordSecret = secret
        self.key = ''
        
        if len(self.passwordSecret)%32 != 0:
            if len(self.passwordSecret) > 32:
                self.key = self.passwordSecret[:32]
                
            elif len(self.passwordSecret) < 32:
                self.key = self.passwordSecret + (' '*(32-len(self.passwordSecret)))
            
        
        Initial16bytes='0123456789ABCDEF' 
        self.crypt = AES.new(self.key, \
                        AES.MODE_CBC, Initial16bytes) 

#    def setPasswordSecret(self, secret):
#        self.passwordSecret = secret
    
    def getPasswordSecret(self):
        return self.passwordSecret

        
    def getHashPassword(self, password):
        salt = hashlib.sha1(self.getPasswordSecret())
        hashPass = hashlib.sha1(password)
        
        hashPass.update(self.getPasswordSecret() + salt.hexdigest())
        return hashPass.hexdigest()
    
    def getEncryptPassword(self, text):

        cypher = self.crypt.encrypt(text) 
        return cypher 
    
    
    def getDecryptPassword(self, cypher):

        plain_text = self.crypt.decrypt(cypher) 
        return plain_text
