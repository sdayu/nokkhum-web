from pyramid.config import Configurator

from pyramid.authentication import SessionAuthenticationPolicy
from pyramid.authorization import ACLAuthorizationPolicy

from pyramid.events import subscriber
from pyramid.events import NewRequest

from pyramid_beaker import session_factory_from_settings

from nokkhumweb.routing import add_routes
from nokkhumweb.security import groupfinder

def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """

    authn_policy = SessionAuthenticationPolicy(callback=groupfinder)
    authz_policy = ACLAuthorizationPolicy()
    session_factory = session_factory_from_settings(settings)
    
    config = Configurator(settings=settings, root_factory='nokkhumweb.acl.RootFactory',
                          authentication_policy=authn_policy, authorization_policy=authz_policy)
    config.set_session_factory(session_factory)
    
    add_routes(config)
    config.scan('nokkhumweb.views')
    
    from .security import SecretManager, RequestWithUserAttribute
    
    config.set_request_factory(RequestWithUserAttribute)
    
    return config.make_wsgi_app()


    
