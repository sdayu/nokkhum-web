from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

@view_config(route_name='admin.users.list', permission='role:admin', renderer='/admin/users/list.jinja2')
def list(request):
    return dict(
                users=request.nokkhum_client.admin.users.list()
                )


@view_config(route_name='admin.users.show', permission='role:admin', renderer='/admin/users/show.jinja2')
def show(request):
    matchdict = request.matchdict
    user_id = matchdict['user_id']
    user = request.nokkhum_client.admin.users.get(user_id)
    return dict(
                user=user
                )
