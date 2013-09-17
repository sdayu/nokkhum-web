from pyramid.httpexceptions import HTTPFound

from pyramid.view import view_config
from pyramid.response import Response

from nokkhumweb.forms import processor_form

import json

@view_config(route_name='processors.index', permission='authenticated', renderer='/processors/index.mako')
def index(request):
    matchdict = request.matchdict
    project_id = matchdict['project_id']
    
    project = request.nokkhum_client.projects.get(project_id)
    processors = None
    if project is not None:
        processors = project.processors

    return dict(
                project=project,
                processors=processors
                )

@view_config(route_name='processors.add', permission='authenticated', renderer='/processors/add.mako')
def add(request):
    matchdict = request.matchdict
    project_id = matchdict['project_id']
    project = request.nokkhum_client.projects.get(project_id)
    cameras = request.nokkhum_client.cameras.list_cameras_by_project(project_id)
    
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
            
            form.image_processors.data = '[]'
             
        return dict(project=project,
                    form=form)
    
    request.nokkhum_client.processors.create(
            name=name,
            image_processors=json.loads(image_processors),
            cameras=[dict(id=camera_id)],
            owner=dict(id=request.user.id),
            storage_period=int(storage_period),
            project=dict(id=project.id)                                 
            )
    
    return HTTPFound(location=request.route_path('processors.index', project_id=project_id))
    

@view_config(route_name='processors.edit', permission='authenticated', renderer='/processors/edit.mako')
def edit(request):
    matchdict = request.matchdict
    project_id = matchdict['project_id']
    processor_id = matchdict['processor_id']
    project = request.nokkhum_client.projects.get(project_id)
    cameras = request.nokkhum_client.cameras.list_cameras_by_project(project_id)
    processor = request.nokkhum_client.processors.get(processor_id)
    
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
    
    print("\n\n\n\nstorage_period:", storage_period, ":", processor.storage_period)
    print("processor:", processor._info,"\n\n\n\n")
    request.nokkhum_client.processors.update(
            processor
            )
    
    return HTTPFound(location=request.route_path('processors.index', project_id=project_id))
    

@view_config(route_name='processors.delete', permission='authenticated')
def delete(request):
    matchdict = request.matchdict
    project_id = matchdict['project_id']
    processor_id = matchdict['processor_id']
    request.nokkhum_client.processors.delete(processor_id)
    return HTTPFound(location=request.route_path('processors.index', project_id=project_id))

@view_config(route_name='processors.setting', permission='authenticated', renderer='/processors/setting.mako')
def setting(request):
    return dict()

@view_config(route_name='processors.operating', permission='authenticated', renderer='/processors/operating.mako')
def operating(request):
    return dict()