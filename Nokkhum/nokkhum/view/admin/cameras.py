from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

from nokkhum import model

@view_config(route_name='admin_camera_list', permission='admin', renderer='/admin/camera/list.mako')
def list(request):
    return dict(
                cameras= model.Camera.objects().all()
                )
    
@view_config(route_name='admin_camera_show', permission='admin', renderer='/admin/camera/show.mako')
def show(request):
    matchdict = request.matchdict
    camera_id = int(matchdict['id'])
    camera= model.Camera.objects(id=camera_id).first()
    
    return dict(
                camera=camera
                )