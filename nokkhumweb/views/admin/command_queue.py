from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

@view_config(route_name='admin.command_queue.list', permission='role:admin', renderer='/admin/command_queue/list.mako')
def list_command(request):
    return dict(
                camera_command_queue=request.nokkhum_client.admin.camera_command_queue.list()
                )
    
    
@view_config(route_name='admin.command_queue.show', permission='role:admin', renderer='/admin/command_queue/show.mako')
def show(request):
    matchdict = request.matchdict
    command_id = matchdict['id']
    command = request.nokkhum_client.admin.camera_command_queue.get(command_id)
    return dict(
                command=command
                )