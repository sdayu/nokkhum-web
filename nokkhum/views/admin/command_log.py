from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

from nokkhum import models

@view_config(route_name='admin_command_log_list', permission='r:admin', renderer='/admin/command_log/list.mako')
def list(request):
    return dict(
                command_log = models.CommandLog.objects().order_by("-id").limit(30)
                )