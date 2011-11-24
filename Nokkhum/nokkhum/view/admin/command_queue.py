from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

from nokkhum import model

@view_config(route_name='admin_command_queue_list', permission='admin', renderer='/admin/command_queue/list.mako')
def list(request):
    return dict(
                camera_command_queue=model.CameraCommandQueue.objects().all()
                )
    
    
@view_config(route_name='admin_command_queue_show', permission='admin', renderer='/admin/command_queue/show.mako')
def show(request):
    matchdict = request.matchdict
    command_id = matchdict['id']
    command = model.CameraCommandQueue.objects().with_id(command_id)
    return dict(
                command=command
                )