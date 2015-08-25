from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid
import datetime

@view_config(route_name='admin.processors.list', permission='role:admin', renderer='/admin/processors/list.jinja2')
def list_camera(request):
    return dict(
                processors= request.nokkhum_client.admin.processors.list(),
                datetime=datetime
                )

@view_config(route_name='admin.processors.show', permission='role:admin', renderer='/admin/processors/show.jinja2')
def show(request):
    matchdict = request.matchdict
    processor_id = matchdict['processor_id']
    processor= request.nokkhum_client.admin.processors.get(processor_id)

    return dict(
                processor=processor,
                datetime=datetime
                )

@view_config(route_name='admin.processors.operating', permission='role:admin')
def operating(request):
    matchdict = request.matchdict
    processor_id = matchdict['processor_id']
    action = matchdict['action']

    processor = request.nokkhum_client.admin.processors.get(processor_id)
    request.nokkhum_client.admin.processor_operating.update(processor, action)
    return HTTPFound(
            location=request.route_path('admin.processors.show',
                                        processor_id=processor_id))

