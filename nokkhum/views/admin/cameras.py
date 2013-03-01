from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

@view_config(route_name='admin.cameras.list', permission='r:admin', renderer='/admin/cameras/list.mako')
def list_camera(request):
    return dict(
                cameras= models.Camera.objects().all()
                )
    
@view_config(route_name='admin.cameras.show', permission='r:admin', renderer='/admin/cameras/show.mako')
def show(request):
    matchdict = request.matchdict
    camera_id = int(matchdict['id'])
    camera= models.Camera.objects(id=camera_id).first()
    
    return dict(
                camera=camera
                )