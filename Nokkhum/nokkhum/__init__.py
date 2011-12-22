from pyramid.config import Configurator

from pyramid.authentication import AuthTktAuthenticationPolicy
from pyramid.authorization import ACLAuthorizationPolicy

from pyramid.events import subscriber
from pyramid.events import NewRequest

from gridfs import GridFS
from mongoengine import connect
import pymongo

from nokkhum.common import models

from nokkhum.routing import add_routes
from nokkhum.security import groupfinder

def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """

    authn_policy = AuthTktAuthenticationPolicy(settings.get('nokkhum.auth.secret'), callback=groupfinder)
    authz_policy = ACLAuthorizationPolicy()
    
    config = Configurator(settings=settings, root_factory='nokkhum.acl.RootFactory',
                          authentication_policy=authn_policy, authorization_policy=authz_policy)

    models.initial(settings)
    
    db_url = settings['mongodb.url']
    conn = pymongo.Connection(db_url)
    config.registry.settings['db_conn'] = conn
    
    add_routes(config)
    config.scan('nokkhum.views')
    
    from security import SecretManager, RequestWithUserAttribute
    
    config.set_request_factory(RequestWithUserAttribute)
    secret_manager = SecretManager(settings.get('nokkhum.auth.secret'))
    config.registry.settings['secret_manager'] = secret_manager
    
    config.add_subscriber(add_secret_manager, NewRequest)
    config.add_subscriber(add_mongo_db, NewRequest)
    
    return config.make_wsgi_app()

def add_mongo_db(event):

    settings = event.request.registry.settings
    db = settings['db_conn'][settings['mongodb.name']]
    event.request.db = db
    event.request.fs = GridFS(db)
    
    default_groups = ['admin', 'user']
    
    for gname in default_groups:
        group = models.Group.objects(name=gname).first()
        if not group:
            group = model.Group()
            group.name = gname
            group.save()
        
    user = models.User.objects(email='admin@nokkhum.com').first()
    if not user:
        user = model.User()
        user.first_name = 'admin'
        user.last_name = ''
        user.password = event.request.secret_manager.getHashPassword('password')
        user.email = 'admin@nokkhum.com'
        user.group = model.Group.objects(name='admin').first()
        user.save()
        
    man_count = models.Manufactory.objects().count()
    if man_count == 0:
        man = models.Manufactory()
        man.name = 'Generic'
        man.save()
        
        camera_model = models.CameraModel()
        camera_model.name = 'OpenCV'
        camera_model.manufactory = man
        camera_model.save()
        
    processor_count = models.ImageProcessor.objects().count()
    if processor_count == 0:
        processor_name = ['Motion Detector', 'Face Detector', 
                     'Video Recorder', 'Image Recorder']
        
        for name in processor_name:
            pro = models.ImageProcessor()
            pro.name = name
            pro.save()
    
def add_secret_manager(event):
    settings = event.request.registry.settings
    secret_manager = settings['secret_manager']
    event.request.secret_manager = secret_manager
