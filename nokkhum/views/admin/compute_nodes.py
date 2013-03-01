from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

@view_config(route_name='admin.compute_nodes.list', permission='r:admin', renderer='/admin/compute_nodes/list.mako')
def list_compute_node(request):
    return dict(
                compute_nodes = models.ComputeNode.objects().all()
                )
    
@view_config(route_name='admin.compute_nodes.show', permission='r:admin', renderer='/admin/compute_nodes/show.mako')
def show(request):
    matchdict = request.matchdict
    compute_node_id = matchdict['id']
    compute_node = models.ComputeNode.objects().with_id(compute_node_id)
    return dict(
               compute_node=compute_node
                )

@view_config(route_name='admin.compute_nodes.delete', permission='r:admin', renderer='/admin/compute_nodes/show.mako')
def delete(request):
    matchdict = request.matchdict
    compute_node_id = matchdict['id']
    
    compute_node = models.ComputeNode.objects().with_id(compute_node_id)
    compute_node.delete()
    
    return HTTPFound(location=request.route_path('admin.compute_nodes.list'))
