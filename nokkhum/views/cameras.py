from pyramid.httpexceptions import HTTPFound

from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

from nokkhum.form import camera_form

import datetime

@view_config(route_name='cameras.add', permission='login', renderer='/cameras/add.mako')
def add(request):
    matchdict = request.matchdict
    project_id = matchdict['project_id']
    
    project = request.nokkhum_client.projects.get(project_id)
    
    form = camera_form.AddCameraForm(request.POST)

# build form
    
    manufactories = request.nokkhum_client.camera_manufactories.list()
    camera_models = request.nokkhum_client.camera_models.list(manufactories[0].id)

    model_options = []
    for model in camera_models:
        model_options.append((model.id, model.name))
    
    camera_man = []
    for man in manufactories:
        camera_man.append((man.id, man.name))
        
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
        camera_man = request.nokkhum_client.camera_manufactories.get(form.data.get('camera_man'))
        camera_model = request.nokkhum_client.camera_models.get(form.data.get('camera_model'))
        
        name        = form.data.get('name')
        host        = form.data.get('host')
        port        = form.data.get('port')
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
    
      
#    camera = models.Camera()
#    camera.owner = request.user
#    camera.name =  name
#    camera.username =  username
#    camera.password =  password
#    camera.video_url =  url
#    camera.fps = fps
#    camera.image_size = image_size
#    camera.status = 'active'
#    camera.ip_address =  request.environ['REMOTE_ADDR']
#    
#    camera.create_date = datetime.datetime.now()
#    camera.update_date = datetime.datetime.now()
#
#    camera.storage_periods = int(storage_periods)

#    camera.camera_model = camera_model
#    camera.project = project
#    
#    camera.operating = models.CameraOperating()
#    camera.operating.status = "stop"
#    camera.operating.update_date = datetime.datetime.now()
    
#    try:
    request.nokkhum_client.cameras.create(
           owner=dict(id=request.user.id),
           name=name,
           host=host,
           port=port,
           username=username,
           password=password,
           video_url=url,
           fps=fps,
           image_size=image_size,
           ip_address=request.environ['REMOTE_ADDR'],
           storage_periods=int(storage_periods),
           model=dict(id=camera_model.id),
           project=dict(id=project.id)                               
        )
#    except Exception as e:
#        return Response("Exception in add camera: %s"%e)

    return HTTPFound(location=request.route_path('projects.index', project_id=project_id))

@view_config(route_name='cameras.edit', permission='login', renderer='/cameras/edit.mako')
def edit(request):
    
    matchdict = request.matchdict
    camera_id = matchdict['camera_id']
    
    #camera = models.Camera.objects(name=camera_name, owner=request.user).first()
    camera = request.nokkhum_client.cameras.get(camera_id)

    form = camera_form.EditCameraForm(request.POST)
    
    # build fromKeyError: 'camera_id'

    # camera_models = models.CameraModel.objects().all()
    # manufactories = models.Manufactory.objects().all()
    manufactories = request.nokkhum_client.camera_manufactories.list()
    camera_models = request.nokkhum_client.camera_models.list(camera.camera_model.manufactory.id)
    
    model_options = []
    for model in camera_models:
        model_options.append((model.id, model.name))
    
    camera_man = []
    for man in manufactories:
        camera_man.append((man.id, man.name))
        
    image_size = ['320x240', '640x480']
    
    fps = [
        1, 2, 4, 5, 6, 8, 10,
        12, 14, 15, 16, 18, 20, 22,
        24, 26, 28, 30
        ]
    
    camera_status = ["active", "suspend"]

    form.fps.choices = [(i, i) for i in fps]
    form.image_size.choices = [(i, i) for i in image_size]
    form.camera_man.choices = camera_man
    form.camera_model.choices = model_options
    form.camera_status.choices = [(i, i) for i in camera_status]
    
        
    if len(request.POST) > 0 and form.validate():
        name        = form.data.get('name')
        username    = form.data.get('username')
        password    = form.data.get('password')
        url         = form.data.get('url')
        fps         = form.data.get('fps')
        image_size  = form.data.get('image_size')
        camera_status = form.data.get('camera_status')
        storage_periods = form.data.get('storage_periods')
        camera_man_id = form.data.get('camera_man')
        camera_model_id = form.data.get('camera_model')
    else:        
        form.fps.data = camera.fps
        form.image_size.data = camera.image_size
        form.camera_man.data = camera.camera_model.manufactory.id
        form.camera_model.data = camera.camera_model.name
        form.camera_status.data = camera.status
        
        if len(request.POST) == 0:
            form.name.data = camera.name
            form.host.data = camera.host
            form.port.data = camera.port 
            form.username.data = camera.username
            form.password.data = camera.password
            form.url.data = camera.video_url
            form.storage_periods.data = camera.storage_periods
            form.camera_status.data = camera.status
            
        return dict(
                    form=form,
                    camera=camera
                    )

      
    camera.name =  name
    camera.username =  username
    camera.password =  password
    camera.video_url =  url
    camera.fps = fps
    camera.image_size = image_size
    camera.status = camera_status
    camera.ip_address =  request.environ['REMOTE_ADDR']
    camera.update_date = datetime.datetime.now()
    camera.storage_periods = storage_periods
    
    camera_model = request.nokkhum_client.camera_models.get(camera_model_id)

    camera.camera_model = camera_model

    try:
        request.nokkhum_client.cameras.update(camera)
    except Exception as e:
        return Response("Exception in edit camera: %s"%e)

    return HTTPFound(location=request.route_path('cameras.view', camera_id=camera.id))
    

@view_config(route_name='cameras.delete', permission='login')
def delete(request):
    matchdict = request.matchdict
    camera_id = matchdict['camera_id']

    camera = request.nokkhum_client.cameras.get(camera_id)
    project = camera.project
    
    if camera:
        request.nokkhum_client.cameras.delete(camera)
    else:
        return Response('Can not delete camera')
    
    return HTTPFound(location=request.route_path('projects.index', project_id=project.id))

@view_config(route_name='cameras.setting', permission='login', renderer='/cameras/setting.mako')
def setting(request):
    matchdict = request.matchdict
    camera_id = matchdict['camera_id']

    camera = request.nokkhum_client.cameras.get(camera_id)
    
    if not camera:
        return Response('Camera not found')
    
    return dict(
               camera=camera 
            )
    
@view_config(route_name='cameras.processor', permission='login', renderer='/cameras/processor.mako')
def processor(request):
    matchdict = request.matchdict
    camera_id = matchdict['camera_id']

    camera = request.nokkhum_client.cameras.get(camera_id)
    
    if not camera:
        return Response('Camera not found')
    
    import json
    form = camera_form.CameraProcessorForm(request.POST)
    
    if request.POST and form.validate():
        processors = json.loads(form.data['processors'])
    else:
        image_processors = request.nokkhum_client.image_processors.list()
        form.processors.data = json.dumps(camera.image_processors, indent=4)
        return dict(
                image_processors=image_processors,
                camera=camera, 
                form=form
                )
    print("\n\n\n\nprocessor in view:", processors)
        
    camera.image_processors = processors
    camera.update_date = datetime.datetime.now()
    request.nokkhum_client.cameras.update(camera)

    return HTTPFound(location=request.route_path('cameras.view', camera_id=camera.id))
    
@view_config(route_name='cameras.view', permission='login', renderer='/cameras/view.mako')
def view(request):
    matchdict = request.matchdict
    camera_id = matchdict['camera_id']

    camera = request.nokkhum_client.cameras.get(camera_id)
    
    if not camera:
        return Response('Camera not found')
    return dict(
               camera=camera,
            )
    
@view_config(route_name='cameras.operating', permission='login')
def operating(request):
    matchdict   = request.matchdict
    camera_id   = matchdict['camera_id']
    operating   = matchdict['operating']

#    camera = models.Camera.objects(owner=request.user, id=camera_id).first()
    camera = request.nokkhum_client.cameras.get(camera_id)
    
    if not camera:
        return Response('Camera not found')
    
    request.nokkhum_client.camera_operating.update(camera, operating)

    return HTTPFound(location=request.route_path('projects.index', project_id=camera.project.id))

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
    