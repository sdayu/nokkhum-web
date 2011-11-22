from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

from nokkhum import model

@view_config(route_name='admin_home', permission='admin', renderer='/admin/home.mako')
def home(request):
    return dict()

@view_config(route_name='admin_list_command_queue', permission='admin', renderer='/admin/list_command_queue.mako')
def list_command_queue(request):
    return dict(
                camera_command_queue = model.CameraCommandQueue.objects().all()
                )
    
@view_config(route_name='admin_list_command_log', permission='admin', renderer='/admin/list_command_log.mako')
def list_command_log(request):
    return dict(
                command_log = model.CommandLog.objects().all()
                )