from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

@view_config(route_name='admin.cameras.list', permission='r:admin', renderer='/admin/cameras/list.mako')
def list_camera(request):
    return dict(
                cameras= request.nokkhum_client.admin.cameras.list()
                )
    
@view_config(route_name='admin.cameras.show', permission='r:admin', renderer='/admin/cameras/show.mako')
def show(request):
    matchdict = request.matchdict
    camera_id = matchdict['id']
    camera= request.nokkhum_client.admin.cameras.get(camera_id)
    
    return dict(
                camera=camera
                )