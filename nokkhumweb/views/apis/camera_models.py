'''
Created on Sep 27, 2013

@author: boatkrap
'''

from pyramid.view import view_config


@view_config(route_name='apis.camera_models.list_by_manufactories', permission='authenticated', renderer='json')
def manufactories(request):
    matchdict = request.matchdict
    manufactory_id = matchdict['manufactory_id']

    # project = models.Project.objects(name=name).first()
    # cameras = models.Camera.objects(project=project).order_by('name').all()
    camera_models = request.nokkhum_client.camera_models.list(manufactory_id)

    return dict(
        camera_models=[
            dict(id=camera_model.id, name=camera_model.name)
            for camera_model in camera_models]
        )
