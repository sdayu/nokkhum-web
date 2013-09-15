from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

@view_config(route_name='index', renderer='/welcome/index.mako')
def index(request):
    return {}