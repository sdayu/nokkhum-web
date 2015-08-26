from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

import datetime

@view_config(route_name='admin.processor_commands.show', permission='role:admin', renderer='/admin/processor_commands/show.jinja2')
def show(request):
    matchdict = request.matchdict
    processor_command_id = matchdict['processor_command_id']
    command= request.nokkhum_client.admin.processor_commands.get(processor_command_id)

    return dict(
                datetime=datetime,
                command=command
                )
