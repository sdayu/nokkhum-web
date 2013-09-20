from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

@view_config(route_name='admin.command_log.list', permission='role:admin', renderer='/admin/command_log/list.mako')
def list(request):
    return dict(
                processor_commands = request.nokkhum_client.admin.processor_commands.list()
                )