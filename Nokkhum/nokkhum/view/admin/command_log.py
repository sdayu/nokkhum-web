from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

from nokkhum import model

@view_config(route_name='admin_command_log_list', permission='admin', renderer='/admin/command_log/list.mako')
def list(request):
    return dict(
                command_log = model.CommandLog.objects().order_by("-id").all()
                )