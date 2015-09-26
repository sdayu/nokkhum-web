from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

import datetime

@view_config(route_name='admin.command_queue.list', permission='role:admin', renderer='/admin/command_queue/list.jinja2')
def list_command(request):
    camera_command_queue=request.nokkhum_client.admin.processor_command_queue.list()
    return dict(
                camera_command_queue=camera_command_queue,
                datetime=datetime
                )


@view_config(route_name='admin.command_queue.view', permission='role:admin', renderer='/admin/command_queue/show.jinja2')
def view(request):
    matchdict = request.matchdict
    command_id = matchdict['command_queue_id']
    command = request.nokkhum_client.admin.processor_command_queue.get(command_id)
    return dict(
                command=command,
                datetime=datetime
                )
