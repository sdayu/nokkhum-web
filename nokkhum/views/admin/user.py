from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

from nokkhum import models

@view_config(route_name='admin_user_list', permission='admin', renderer='/admin/user/list.mako')
def list(request):
    return dict(
                users=models.User.objects().all()
                )
    
    
@view_config(route_name='admin_user_show', permission='admin', renderer='/admin/user/show.mako')
def show(request):
    matchdict = request.matchdict
    user_id = matchdict['id']
    user = models.User.objects().with_id(user_id)
    return dict(
                user=user
                )