'''
Created on Aug 5, 2014

@author: boatkrap
'''
from pyramid.view import view_config


@view_config(route_name='apis.admin.compute_nodes.resources',
             permission='authenticated',
             renderer='json')
def resources(request):
    compute_node_id = request.matchdict.get('compute_node_id')

    results = request.nokkhum_client.admin\
        .compute_nodes.get_resources(compute_node_id)

    return dict(
        resources=[r._info for r in results]
        )
