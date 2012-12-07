from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

from nokkhum import models

@view_config(route_name='admin_home', permission='r:admin', renderer='/admin/home.mako')
def home(request):
    return dict()
    

