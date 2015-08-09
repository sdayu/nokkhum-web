from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

@view_config(route_name='about', renderer='/pages/about.jinja2')
def about(request):
    return {}
