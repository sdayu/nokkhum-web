'''
Created on Jul 11, 2012

@author: boatkrap
'''
from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response

from nokkhum import models

@view_config(route_name='admin.camera_running_fail.list_camera', permission='admin', renderer='/admin/camera_running_fail/list.mako')
def list_camera(request):
    return dict(
                run_fail_status= models.CameraFailStatus.objects().all()
                )
    