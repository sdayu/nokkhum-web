'''
Created on Jul 11, 2012

@author: boatkrap
'''
from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response

@view_config(route_name='admin.processor_running_fail.list',
             permission='role:admin',
             renderer='/admin/processor_running_fail/list.jinja2')
def list_camera(request):
    return dict(
                run_fail_status=request.nokkhum_client.admin.processor_running_fail.list()
                )

