from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

from nokkhum import models

@view_config(route_name='admin_compute_node_list', permission='r:admin', renderer='/admin/compute_node/list.mako')
def list_compute_node(request):
    return dict(
                compute_nodes = models.ComputeNode.objects().all()
                )
    
@view_config(route_name='admin_compute_node_show', permission='r:admin', renderer='/admin/compute_node/show.mako')
def show(request):
    matchdict = request.matchdict
    compute_node_id = matchdict['id']
    compute_node = models.ComputeNode.objects().with_id(compute_node_id)
    return dict(
               compute_node=compute_node
                )
    
