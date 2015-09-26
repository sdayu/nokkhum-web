from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

import datetime
import json

from nokkhumweb.forms import processor_form

@view_config(route_name='admin.processors.list', permission='role:admin', renderer='/admin/processors/list.jinja2')
def list_camera(request):
    return dict(
                processors= request.nokkhum_client.admin.processors.list(),
                datetime=datetime
                )

@view_config(route_name='admin.processors.view', permission='role:admin', renderer='/admin/processors/show.jinja2')
def view(request):
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
    try:
        request.nokkhum_client.admin.processor_operating.update(processor, action)
    except:
        pass
    return HTTPFound(
            location=request.route_path('admin.processors.view',
                                        processor_id=processor_id))

@view_config(route_name='admin.processors.edit', permission='role:admin', renderer='/processors/edit.jinja2')
def edit(request):

    matchdict = request.matchdict
    processor_id = matchdict['processor_id']
    processor = request.nokkhum_client.admin.processors.get(processor_id)
    project = processor.project
    cameras = request.nokkhum_client.cameras.list_cameras_by_project(project.id)

    form = processor_form.ProcessorForm(request.POST)

    form.camera.choices = [(camera.id, camera.name) for camera in cameras]


    if len(request.POST) > 0 and form.validate():
        name = form.data['name']
        camera_id = form.data['camera']
        storage_period = form.data['storage_period']
        image_processors = form.data['image_processors']
    else:
        if 'image_processors' in request.POST:
            form.image_processors.data = form.data['image_processors']
        else:

            form.image_processors.data = json.dumps(processor.image_processors, indent=4)

        form.camera.data = processor.cameras[0].id
        form.storage_period.data = processor.storage_period
        form.name.data = processor.name
        return dict(project=project,
                    processor=processor,
                    form=form)

    new_camera = None
    for camera in cameras:
        if camera.id == camera_id:
            new_camera = camera
            break

    processor.name = name
    processor.image_processors = json.loads(image_processors)
    processor.storage_period = int(storage_period)
    processor.cameras = [new_camera]

    request.nokkhum_client.processors.update(
            processor
            )

    return HTTPFound(
            location=request.route_path('admin.processors.view',
                                        processor_id=processor_id))


