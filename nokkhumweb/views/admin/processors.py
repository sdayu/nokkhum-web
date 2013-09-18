from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

@view_config(route_name='admin.processors.list', permission='role:admin', renderer='/admin/processors/list.mako')
def list_camera(request):
    return dict(
                processors= request.nokkhum_client.admin.processors.list()
                )
    
@view_config(route_name='admin.processors.show', permission='role:admin', renderer='/admin/processors/show.mako')
def show(request):
    matchdict = request.matchdict
    processor_id = matchdict['processor_id']
    processor= request.nokkhum_client.admin.processors.get(processor_id)
    
    return dict(
                processor=processor
                )