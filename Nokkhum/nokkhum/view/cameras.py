from pyramid.httpexceptions import HTTPFound

from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

from pyramid_simpleform import Form
from pyramid_simpleform.renderers import FormRenderer

from nokkhum.model.form import camera_form
from nokkhum import model
from nokkhum.model.cameras import Manufactory

@view_config(route_name='camera_add', permission='signin', renderer='/camera/add.mako')
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

    if form.validate():
        camera_man = model.Manufactory.objects(name=form.data['camera_man']).first()
        camera_model = model.CameraModel.objects(name=form.data['camera_model'],
                                                 manufactory=camera_man)\
                                                 .first()

        
        if not camera_model:
            return form_renderer(form)
        
        camera = model.Camera()
        camera.user = request.user
        camera.name =  form.data['name']
        camera.username =  form.data['username']
        camera.password =  form.data['password']
        camera.url =  form.data['url']
        camera.fps = form.data['fps']
        camera.image_size = form.data['image_size']
        camera.status = 'Active'
        camera.ip_address =  request.environ['REMOTE_ADDR']
        try:
            camera.save()
        except Exception as e:
            return form_renderer(form)

        return HTTPFound(location = '/home')
    
    return form_renderer(form)

@view_config(route_name='camera_delete', permission='signin')
def delete(request):
    matchdict = request.matchdict
    camera_name = matchdict['name']

    camera = model.Camera.objects(user=request.user, name=camera_name).first()
    
    if camera:
        camera.delete()
    else:
        return Response('Can not delete camera')
    
    return HTTPFound(location='/home')

@view_config(route_name='camera_setting', permission='signin', renderer='/camera/setting.mako')
def setting(request):
    matchdict = request.matchdict
    camera_name = matchdict['name']

    camera = model.Camera.objects(user=request.user, name=camera_name).first()
    
    if not camera:
        return Response('Camera not found')
    
    return dict(
               camera=camera 
                )
    
@view_config(route_name='camera_processor', permission='signin', renderer='/camera/processor.mako')
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
        camera.processors = ast.literal_eval(form.data['processors'])
        camera.save()
        
        return HTTPFound(location='/cameras/'+camera.name+'/setting')
    
    image_processors = model.ImageProcessor.objects().all()
    return dict(
            image_processors=image_processors,
            renderer=FormRenderer(form),
            camera=camera 
                )
    
@view_config(route_name='camera_view', permission='signin', renderer='/camera/view.mako')
def view(request):
    matchdict = request.matchdict
    camera_name = matchdict['name']

    camera = model.Camera.objects(user=request.user, name=camera_name).first()
    
    if not camera:
        return Response('Camera not found')
    
    return dict(
               camera=camera 
                )
