from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid
import datetime
import json

@view_config(route_name='admin.compute_nodes.list', permission='role:admin', renderer='/admin/compute_nodes/list.jinja2')
def list_compute_node(request):
    return dict(
                compute_nodes = request.nokkhum_client.admin.compute_nodes.list(),
                datetime=datetime,
                json=json
                )

@view_config(route_name='admin.compute_nodes.view', permission='role:admin', renderer='/admin/compute_nodes/show.jinja2')
def show(request):
    matchdict = request.matchdict
    compute_node_id = matchdict['compute_node_id']
    compute_node = request.nokkhum_client.admin.compute_nodes.get(compute_node_id)
    return dict(
               compute_node=compute_node,
               datetime=datetime,
               json=json
                )

@view_config(route_name='admin.compute_nodes.delete', permission='role:admin', renderer='/admin/compute_nodes/show.jinja2')
def delete(request):
    matchdict = request.matchdict
    compute_node_id = matchdict['compute_node_id']

    request.nokkhum_client.admin.compute_nodes.delete(compute_node_id)

    return HTTPFound(location=request.route_path('admin.compute_nodes.list'))
