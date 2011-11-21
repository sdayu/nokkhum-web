from pyramid.httpexceptions import HTTPFound

from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

from pyramid_simpleform import Form
from pyramid_simpleform.renderers import FormRenderer

from nokkhum.form import camera_form
from nokkhum import model
from nokkhum.model.cameras import Manufactory

import datetime

@view_config(route_name='camera_add', permission='login', renderer='/camera/add.mako')
def add(request):
    
    def form_renderer(form):
        camera_models = model.CameraModel.objects().all()
        manufactories = model.Manufactory.objects().all()
    
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
        camera_man = model.Manufactory.objects(name=form.data['camera_man']).first()
        camera_model = model.CameraModel.objects(name=form.data['camera_model'],
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
      
    camera = model.Camera()
    camera.user = request.user
    camera.name =  name
    camera.username =  username
    camera.password =  password
    camera.url =  url
    camera.fps = fps
    camera.image_size = image_size
    camera.status = 'Active'
    camera.ip_address =  request.environ['REMOTE_ADDR']
    
    camera.operating = model.CameraOperating()
    camera.operating.status = "Stop"
    camera.operating.update_date = datetime.datetime.now()
    
    try:
        camera.save()
    except Exception as e:
        return Response("Exception in add camera: %s"%e)

    return HTTPFound(location = '/home')
    

@view_config(route_name='camera_delete', permission='login')
def delete(request):
    matchdict = request.matchdict
    camera_name = matchdict['name']

    camera = model.Camera.objects(user=request.user, name=camera_name).first()
    
    if camera:
        camera.delete()
    else:
        return Response('Can not delete camera')
    
    return HTTPFound(location='/home')

@view_config(route_name='camera_setting', permission='login', renderer='/camera/setting.mako')
def setting(request):
    matchdict = request.matchdict
    camera_name = matchdict['name']

    camera = model.Camera.objects(user=request.user, name=camera_name).first()
    
    if not camera:
        return Response('Camera not found')
    
    return dict(
               camera=camera 
                )
    
@view_config(route_name='camera_processor', permission='login', renderer='/camera/processor.mako')
def processor(request):
    matchdict = request.matchdict
    camera_name = matchdict['name']

    camera = model.Camera.objects(user=request.user, name=camera_name).first()
    
    if not camera:
        return Response('Camera not found')
    
    form = Form(request,
                defaults={"processors" : camera.processors},
                schema=camera_form.CameraProcessorForm)
    
    if form.validate():
        import ast
        processors = ast.literal_eval(form.data['processors'])
    else:
        image_processors = model.ImageProcessor.objects().all()
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
    
    return HTTPFound(location='/cameras/'+camera.name+'/setting')
    
@view_config(route_name='camera_view', permission='login', renderer='/camera/view.mako')
def view(request):
    matchdict = request.matchdict
    camera_name = matchdict['name']

    camera = model.Camera.objects(user=request.user, name=camera_name).first()
    
    if not camera:
        return Response('Camera not found')
    return dict(
               camera=camera,
                )
