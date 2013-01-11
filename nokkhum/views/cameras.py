from pyramid.httpexceptions import HTTPFound

from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

from nokkhum.form import camera_form
from nokkhum import models

import datetime

@view_config(route_name='cameras.add', permission='login', renderer='/cameras/add.mako')
def add(request):
    matchdict = request.matchdict
    project_name = matchdict['project_name']
    
    project = models.Project.objects(name=project_name).first()
    
    form = camera_form.AddCameraForm(request.POST)

# build form
    camera_models = models.CameraModel.objects().all()
    manufactories = models.Manufactory.objects().all()

    model_options = []
    for model in camera_models:
        model_options.append((model.name, model.name))
    
    camera_man = []
    for man in manufactories:
        camera_man.append((man.name, man.name))
        
    image_size = ['320x240', '640x480']
    
    fps = [
        1, 2, 4, 5, 6, 8, 10,
        12, 14, 15, 16, 18, 20, 22,
        24, 26, 28, 30
        ]

    form.fps.choices = [(i, i) for i in fps]
    form.image_size.choices = [(i, i) for i in image_size]
    form.camera_man.choices = camera_man
    form.camera_model.choices = model_options
        
    if request.POST and form.validate():
        camera_man = models.Manufactory.objects(name=form.data.get('camera_man')).first()
        camera_model = models.CameraModel.objects(name=form.data.get('camera_model'),
                                                 manufactory=camera_man)\
                                                 .first()
        
        name        = form.data.get('name')
        username    = form.data.get('username')
        password    = form.data.get('password')
        url         = form.data.get('url')
        fps         = form.data.get('fps')
        image_size  = form.data.get('image_size')
        storage_periods = form.data.get('storage_periods')
    else:
        return dict(
                form=form,
                camera_models=camera_models,
                manufactories=manufactories,
                )
    
      
    camera = models.Camera()
    camera.owner = request.user
    camera.name =  name
    camera.username =  username
    camera.password =  password
    camera.url =  url
    camera.fps = fps
    camera.image_size = image_size
    camera.status = 'Active'
    camera.ip_address =  request.environ['REMOTE_ADDR']
    
    camera.create_date = datetime.datetime.now()
    camera.update_date = datetime.datetime.now()

    camera.storage_periods = int(storage_periods)

    camera.camera_model = camera_model
    camera.project = project
    
    camera.operating = models.CameraOperating()
    camera.operating.status = "Stop"
    camera.operating.update_date = datetime.datetime.now()
    
    try:
        camera.save()
    except Exception as e:
        return Response("Exception in add camera: %s"%e)

    return HTTPFound(location=request.route_path('projects.index', name=project_name))

@view_config(route_name='cameras.edit', permission='login', renderer='/cameras/edit.mako')
def edit(request):
    
    matchdict = request.matchdict
    camera_name = matchdict['name']
    
    camera = models.Camera.objects(name=camera_name, owner=request.user).first()

    form = camera_form.EditCameraForm(request.POST)
    
    # build from
    camera_models = models.CameraModel.objects().all()
    manufactories = models.Manufactory.objects().all()

    model_options = []
    for model in camera_models:
        model_options.append((model.name, model.name))
    
    camera_man = []
    for man in manufactories:
        camera_man.append((man.name, man.name))
        
    image_size = ['320x240', '640x480']
    
    fps = [
        1, 2, 4, 5, 6, 8, 10,
        12, 14, 15, 16, 18, 20, 22,
        24, 26, 28, 30
        ]
    
    camera_status = ["Active", "Suspend"]

    form.fps.choices = [(i, i) for i in fps]
    form.image_size.choices = [(i, i) for i in image_size]
    form.camera_man.choices = camera_man
    form.camera_model.choices = model_options
    form.camera_status.choices = [(i, i) for i in camera_status]
    
        
    if request.POST and form.validate():
        camera_man = models.Manufactory.objects(name=form.data.get('camera_man')).first()
        camera_model = models.CameraModel.objects(name=form.data.get('camera_model'),
                                                 manufactory=camera_man)\
                                                 .first()
        
        name        = form.data.get('name')
        username    = form.data.get('username')
        password    = form.data.get('password')
        url         = form.data.get('url')
        fps         = form.data.get('fps')
        image_size  = form.data.get('image_size')
        camera_status = form.data.get('camera_status')
        storage_periods = form.data.get('storage_periods')
    else:
        form.fps.data = camera.fps
        form.image_size.data = camera.image_size
        form.camera_man.data = camera.camera_model.manufactory.name
        form.camera_model.data = camera.camera_model.name
        form.camera_status.data = camera.status
            
        return dict(
                    form=form,
                    camera=camera
                    )

      
    camera.name =  name
    camera.username =  username
    camera.password =  password
    camera.url =  url
    camera.fps = fps
    camera.image_size = image_size
    camera.status = camera_status
    camera.ip_address =  request.environ['REMOTE_ADDR']
    camera.update_date = datetime.datetime.now()
    camera.storage_periods = storage_periods

    
    camera.camera_model = camera_model
    
    try:
        camera.save()
    except Exception as e:
        return Response("Exception in edit camera: %s"%e)

    return HTTPFound(location=request.route_path('cameras.view', name=camera.name))
    

@view_config(route_name='cameras.delete', permission='login')
def delete(request):
    matchdict = request.matchdict
    camera_name = matchdict['name']

    camera = models.Camera.objects(owner=request.user, name=camera_name).first()
    project_name = camera.project.name
    
    if camera:
        camera.delete()
    else:
        return Response('Can not delete camera')
    
    return HTTPFound(location=request.route_path('projects.index', name=project_name))

@view_config(route_name='cameras.setting', permission='login', renderer='/cameras/setting.mako')
def setting(request):
    matchdict = request.matchdict
    camera_name = matchdict['name']

    camera = models.Camera.objects(owner=request.user, name=camera_name).first()
    
    if not camera:
        return Response('Camera not found')
    
    return dict(
               camera=camera 
                )
    
@view_config(route_name='cameras.processor', permission='login', renderer='/cameras/processor.mako')
def processor(request):
    matchdict = request.matchdict
    camera_name = matchdict['name']

    camera = models.Camera.objects(owner=request.user, name=camera_name).first()
    
    if not camera:
        return Response('Camera not found')
    
    import json
    form = camera_form.CameraProcessorForm(request.POST)
    
    if request.POST and form.validate():
        processors = json.loads(form.data['processors'])
    else:
        image_processors = models.ImageProcessor.objects().all()
        form.processors.data = json.dumps(camera.processors, indent=4)
        return dict(
                image_processors=image_processors,
                camera=camera, 
                form=form
                )
        
    camera.processors = processors
    camera.update_date = datetime.datetime.now()
    camera.save()
    
    return HTTPFound(location=request.route_path('cameras.view', name=camera.name))
    
@view_config(route_name='cameras.view', permission='login', renderer='/camera/view.mako')
def view(request):
    matchdict = request.matchdict
    camera_name = matchdict['name']

    camera = models.Camera.objects(owner=request.user, name=camera_name).first()
    
    if not camera:
        return Response('Camera not found')
    return dict(
               camera=camera,
                )
    
@view_config(route_name='cameras.operating', permission='login')
def operating(request):
    matchdict   = request.matchdict
    camera_name = matchdict['name']
    operating   = matchdict['operating']

    camera = models.Camera.objects(owner=request.user, name=camera_name).first()
    
    if not camera:
        return Response('Camera not found')
    
    command_action  = 'No-command'
    user_command    = 'Undefine'
    if operating == 'start':
        command_action = 'Start'
        user_command = 'Run'
    elif operating == 'stop':
        command_action = 'Stop'
        user_command = 'Suspend'
    
    ccq = models.CameraCommandQueue.objects(owner=request.user, camera=camera, action=command_action).first()
    if ccq is not None:
        return Response('Camera name %s on operation' % camera.name)
    
    
    camera.operating.status = command_action
    camera.operating.user_command = user_command
    camera.update_date = datetime.datetime.now()
    camera.save()
    
    ccq         = models.CameraCommandQueue()
    ccq.command_date = datetime.datetime.now()
    ccq.update_date = datetime.datetime.now()
    ccq.action  = command_action
    ccq.status  = 'Waiting'
    ccq.camera  = camera
    ccq.owner   = request.user
    ccq.save()

    return HTTPFound(location=request.route_path('projects.index', name=camera.project.name))

@view_config(route_name='cameras.live_view', permission='login', renderer='/cameras/live_view.mako')
def live_view(request):
    matchdict = request.matchdict
    camera_name = matchdict['name']

    camera = models.Camera.objects(owner=request.user, name=camera_name).first()
    
    if not camera:
        return Response('Camera not found')
    return dict(
               camera=camera,
                )

@view_config(route_name='cameras.test_view', permission='login', renderer='/cameras/test_view.mako')
def test_view(request):
    matchdict = request.matchdict
    camera_name = matchdict['name']

    camera = models.Camera.objects(owner=request.user, name=camera_name).first()
    
    if not camera:
        return Response('Camera not found')
    return dict(
               camera=camera,
                )
    