from pyramid.config import Configurator

from pyramid.authentication import AuthTktAuthenticationPolicy
from pyramid.authorization import ACLAuthorizationPolicy

from pyramid.events import subscriber
from pyramid.events import NewRequest

from gridfs import GridFS
from mongoengine import connect
import pymongo

from nokkhum import models

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
    
    db_host = settings['mongodb.host']
    conn = pymongo.Connection(db_host)
    config.registry.settings['db_conn'] = conn
    
    add_routes(config)
    config.scan('nokkhum.views')
    
    from .security import SecretManager, RequestWithUserAttribute
    
    config.set_request_factory(RequestWithUserAttribute)
    secret_manager = SecretManager(settings.get('nokkhum.auth.secret'))
    config.registry.settings['secret_manager'] = secret_manager
    
    config.add_subscriber(add_secret_manager, NewRequest)
    config.add_subscriber(add_mongo_db, NewRequest)
    
    return config.make_wsgi_app()

def add_mongo_db(event):

    settings = event.request.registry.settings
    db = settings['db_conn'][settings['mongodb.db_name']]
    event.request.db = db
    event.request.fs = GridFS(db)
    
    
def add_secret_manager(event):
    settings = event.request.registry.settings
    secret_manager = settings['secret_manager']
    event.request.secret_manager = secret_manager
