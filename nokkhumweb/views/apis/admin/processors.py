'''
Created on Aug 5, 2014

@author: boatkrap
'''
from pyramid.view import view_config


@view_config(route_name='apis.admin.processors.resources',
             permission='authenticated',
             renderer='json')
def resources(request):
    processor_id = request.matchdict.get('processor_id')

    print('xxx:', processor_id)
    results = request.nokkhum_client.admin\
        .processors.get_resources(processor_id)

    return dict(
        resources=[r._info for r in results]
        )
