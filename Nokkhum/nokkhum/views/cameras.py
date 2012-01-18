from pyramid.httpexceptions import HTTPFound

from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

from pyramid_simpleform import Form
from pyramid_simpleform.renderers import FormRenderer

from nokkhum.form import camera_form
from nokkhum.common import models

import datetime

@view_config(route_name='camera_add', permission='login', renderer='/camera/add.mako')
def add(request):
    
    def form_renderer(form):
        camera_models = models.CameraModel.objects().all()
        manufactories = models.Manufactory.objects().all()
    
        return dict(
                renderer=FormRenderer(form),
                camera_models=camera_models,
                manufactories=manufactories
                )
    
    form = Form(request,
#                defaults={"name" : "..."},
                schema=camera_form.AddCameraForm)
    
    camera_man = None
    camera_model = None
    if form.validate():
        camera_man = models.Manufactory.objects(name=form.data['camera_man']).first()
        camera_model = models.CameraModel.objects(name=form.data['camera_model'],
                                                 manufactory=camera_man)\
                                                 .first()
        
        name =  form.data['name']
        username =  form.data['username']
        password =  form.data['password']
        url =  form.data['url']
        fps = form.data['fps']
        image_size = form.data['image_size']
    else:
        return form_renderer(form)
    
    if not camera_model:
        return form_renderer(form)
      
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
    
    camera.camera_model = camera_model
    
    camera.operating = models.CameraOperating()
    camera.operating.status = "Stop"
    camera.operating.update_date = datetime.datetime.now()
    
    try:
        camera.save()
    except Exception as e:
        return Response("Exception in add camera: %s"%e)

    return HTTPFound(location = '/home')

@view_config(route_name='camera_edit', permission='login', renderer='/camera/edit.mako')
def edit(request):
    
    matchdict = request.matchdict
    camera_name = matchdict['name']
    
    camera = models.Camera.objects(name=camera_name, owner=request.user).first()

    def form_renderer(form):
        camera_models = models.CameraModel.objects().all()
        manufactories = models.Manufactory.objects().all()
    
        return dict(
                renderer=FormRenderer(form),
                camera_models=camera_models,
                manufactories=manufactories,
                camera=camera
                )
    
    form = Form(request,
#                defaults={"name" : "..."},
                schema=camera_form.EditCameraForm)
    
    camera_man = None
    camera_model = None
    if form.validate():
        camera_man = models.Manufactory.objects(name=form.data['camera_man']).first()
        camera_model = models.CameraModel.objects(name=form.data['camera_model'],
                                                 manufactory=camera_man)\
                                                 .first()
        
        name        = form.data['name']
        username    = form.data['username']
        password    = form.data['password']
        url         = form.data['url']
        fps         = form.data['fps']
        image_size  = form.data['image_size']
        camera_status = form.data['camera_status']
    else:
        return form_renderer(form)
    
    if not camera_model:
        return form_renderer(form)
      
    camera.name =  name
    camera.username =  username
    camera.password =  password
    camera.url =  url
    camera.fps = fps
    camera.image_size = image_size
    camera.status = camera_status
    camera.ip_address =  request.environ['REMOTE_ADDR']
    camera.update_date = datetime.datetime.now()
    
    camera.camera_model = camera_model
    
    try:
        camera.save()
    except Exception as e:
        return Response("Exception in edit camera: %s"%e)

    return HTTPFound(location = request.route_path('camera_view', name=camera.name))
    

@view_config(route_name='camera_delete', permission='login')
def delete(request):
    matchdict = request.matchdict
    camera_name = matchdict['name']

    camera = models.Camera.objects(owner=request.user, name=camera_name).first()
    
    if camera:
        camera.delete()
    else:
        return Response('Can not delete camera')
    
    return HTTPFound(location='/home')

@view_config(route_name='camera_setting', permission='login', renderer='/camera/setting.mako')
def setting(request):
    matchdict = request.matchdict
    camera_name = matchdict['name']

    camera = models.Camera.objects(owner=request.user, name=camera_name).first()
    
    if not camera:
        return Response('Camera not found')
    
    return dict(
               camera=camera 
                )
    
@view_config(route_name='camera_processor', permission='login', renderer='/camera/processor.mako')
def processor(request):
    matchdict = request.matchdict
    camera_name = matchdict['name']

    camera = models.Camera.objects(owner=request.user, name=camera_name).first()
    
    if not camera:
        return Response('Camera not found')
    
    import json
    form = Form(request,
                defaults={"processors" : json.dumps(camera.processors, indent=4)},
                schema=camera_form.CameraProcessorForm)
    
    if form.validate():
        import json
        processors = json.loads(form.data['processors'])
    else:
        image_processors = models.ImageProcessor.objects().all()
        return dict(
                image_processors=image_processors,
                renderer=FormRenderer(form),
                camera=camera 
                    )
        
    default_path = "%s/%d/%d" % (request.registry.settings['nokkhum.default.record_path'], request.user.id, camera.id)
        
    def change_default_record(processors):
        for processor in processors:
            if 'Recorder' in processor["name"]:
                processor["directory"] = default_path
                
            if "processors" in processor and len(processor["processors"]) > 0:
                change_default_record(processor["processors"])
            
    change_default_record(processors)
    
    camera.processors = processors
    camera.save()
    
    return HTTPFound(location=request.route_path('camera_view', name=camera.name))
    
@view_config(route_name='camera_view', permission='login', renderer='/camera/view.mako')
def view(request):
    matchdict = request.matchdict
    camera_name = matchdict['name']

    camera = models.Camera.objects(owner=request.user, name=camera_name).first()
    
    if not camera:
        return Response('Camera not found')
    return dict(
               camera=camera,
                )
    
@view_config(route_name='camera_operating', permission='login')
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
    ccq.action  = command_action
    ccq.status  = 'Waiting'
    ccq.camera  = camera
    ccq.owner   = request.user
    ccq.save()

    return HTTPFound(location='/home')


@view_config(route_name='camera_test_view', permission='login', renderer='/camera/test_view.mako')
def test_view(request):
    matchdict = request.matchdict
    camera_name = matchdict['name']

    camera = models.Camera.objects(owner=request.user, name=camera_name).first()
    
    if not camera:
        return Response('Camera not found')
    return dict(
               camera=camera,
                )
    