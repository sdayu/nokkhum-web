from pyramid.config import Configurator

from pyramid.authentication import AuthTktAuthenticationPolicy
from pyramid.authorization import ACLAuthorizationPolicy

from pyramid.events import subscriber
from pyramid.events import NewRequest

from gridfs import GridFS
from mongoengine import connect
import pymongo

from nokkhum.routing import add_routes
from nokkhum.security import groupfinder

def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    
    authn_policy = AuthTktAuthenticationPolicy(settings.get('auth.secret'), callback=groupfinder)
    authz_policy = ACLAuthorizationPolicy()
    
    config = Configurator(settings=settings, root_factory='nokkhum.model.RootFactory',
                          authentication_policy=authn_policy, authorization_policy=authz_policy)

    db_url = settings['mongodb.url']
    conn = pymongo.Connection(db_url)
    config.registry.settings['db_conn'] = conn
    
    add_routes(config)
    config.scan('nokkhum.view')
    
    from security import SecretManager, RequestWithUserAttribute
    
    config.set_request_factory(RequestWithUserAttribute)
    secret_manager = SecretManager(settings.get('auth.secret'))
    config.registry.settings['secret_manager'] = secret_manager
    
    config.add_subscriber(add_secret_manager, NewRequest)
    config.add_subscriber(add_mongo_db, NewRequest)
    
    return config.make_wsgi_app()

def add_mongo_db(event):
    settings = event.request.registry.settings
    db = settings['db_conn'][settings['mongodb.name']]
    event.request.db = db
    event.request.fs = GridFS(db)
    
    connect(settings['mongodb.name'], host=settings['mongodb.url'])
    
    from nokkhum.model import User, Group, CameraModel, Manufactory, ImageProcessor
    group = Group.objects(name='admin').first()
    if not group:
        group = Group()
        group.name = 'admin'
        group.save()
        
    user = User.objects(username='admin').first()
    if not user:
        user = User()
        user.username = 'admin'
        user.password = event.request.secret_manager.getHashPassword('password')
        user.email = 'admin@localhost'
        user.group = group
        user.save()
        
    man_count = Manufactory.objects().count()
    if man_count == 0:
        man = Manufactory()
        man.name = 'Generic'
        man.save()
        
        model = CameraModel()
        model.name = 'OpenCV'
        model.manufactory = man
        model.save()
        
    processor_count = ImageProcessor.objects().count()
    if processor_count == 0:
        processor_name = ['Motion Detection', 'Face Detection', 
                     'Video Record', 'Image Record']
        
        for name in processor_name:
            pro = ImageProcessor()
            pro.name = name
            pro.save()
    
def add_secret_manager(event):
    settings = event.request.registry.settings
    secret_manager = settings['secret_manager']
    event.request.secret_manager = secret_manager
