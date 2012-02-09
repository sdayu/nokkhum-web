from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

from nokkhum.common import models

@view_config(route_name='admin_command_queue_list', permission='admin', renderer='/admin/command_queue/list.mako')
def list_command(request):
    return dict(
                camera_command_queue=models.CameraCommandQueue.objects().order_by("+id").all()
                )
    
    
@view_config(route_name='admin_command_queue_show', permission='admin', renderer='/admin/command_queue/show.mako')
def show(request):
    matchdict = request.matchdict
    command_id = matchdict['id']
    command = models.CameraCommandQueue.objects().with_id(command_id)
    return dict(
                command=command
                )