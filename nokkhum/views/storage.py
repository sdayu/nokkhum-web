from pyramid.httpexceptions import HTTPFound

from pyramid.view import view_config
from pyramid.response import Response, FileResponse
from pyramid.security import authenticated_userid

from nokkhum.form import camera_form
from nokkhum import models

import os
import urllib

@view_config(route_name='storage_list', permission="login", renderer='/storage/list_file.mako')
def storage_list(request):
    s3_storage = request.s3_storage
    file_list = []
    matchdict = request.matchdict
    fizzle = matchdict['fizzle']
#    print ("fizzle: '%s'" % fizzle)
#    for cam_id in s3_storage.list_file():
#        camera = models.Camera.objects(id=int(cam_id)).first()
#        print "cam id: ", cam_id
#        if camera is not None:
#            result.append(camera.name)
#            print "name: ", camera.name
    if len(fizzle) == 0 or fizzle == "/":
        cameras = models.Camera.objects(owner=request.user).all()
        for camera in cameras:
            file_list.append((camera.name, request.route_path('storage_list', fizzle="/%s"%camera.name)))
    else:
        uri = fizzle[1:]
        end_pos = uri.find("/")
        if end_pos > 0:
            camera_name = uri[:end_pos]
        else:
            camera_name = uri
#        print "camera name: ", camera_name
        camera = models.Camera.objects(owner=request.user, name=camera_name).first()
#        print "ex --> : %s --> %s"%(fizzle, uri[end_pos+1:])
        prefix = "%d/"%camera.id
        
        if len(uri[end_pos+1:]) > 0 and uri[end_pos+1:] != camera_name:
            prefix = "%s%s/" % (prefix,uri[end_pos+1:])
#        print "prefix: ", prefix
        for item in s3_storage.list_file(prefix):
            start_pos = item.rfind("/")
            if uri[end_pos+1:] != camera_name:
                path = uri[end_pos:]+item[start_pos:]
            else:
                path = item[start_pos:]
            
            extension = ""
            pos = path.rfind(".")
            if pos > 0:
                extension = path[pos:]
                if extension not in [".jpg", ".png", ".avi", ".webm", ".webp", ".ogg", ".ogv"]:
                    extension = ""
            if len(extension) > 0:
                view_link = request.route_path('storage_view', fizzle="/%s%s"%(camera.name, path))
            else:
                view_link = request.route_path('storage_list', fizzle="/%s%s"%(camera.name, path))
                
            delete_link = request.route_path('storage_delete', fizzle="/%s%s"%(camera.name, path))
            
            
            file_list.append((item[start_pos+1:], urllib.unquote(view_link), delete_link))
    return dict(
                file_list=file_list,
                )
    
def cache_file(request):
    cache_dir = request.registry.settings['nokkhum.temp_dir']
    matchdict = request.matchdict
    fizzle = matchdict['fizzle']
    
    user = request.user
    
    camera_name = ""
    
    uri = fizzle[1:]
    end_pos = uri.find("/")
    if end_pos > 0:
        camera_name = uri[:end_pos]
    else:
        camera_name = uri
    
    camera = models.Camera.objects(owner=request.user, name=camera_name).first()
    if camera is None:
        return None
    
    key_name = "%d%s"%(camera.id, uri[end_pos:])
    container_dir = "%s/%d/%s"%(cache_dir, user.id, key_name[:key_name.rfind("/")])
    file_name = "%s/%d/%s"%(cache_dir, user.id, key_name)
    
    s3_storage = request.s3_storage

    if not s3_storage.is_avialabel(key_name):
        return None

    if os.path.exists(file_name):
        return file_name
    
    if not os.path.exists(container_dir):
        try:
            os.makedirs(container_dir)
        except:
            pass

#    print "key_name: ", key_name
#    print "file_name: ", file_name
    s3_storage.get_file(key_name, file_name)
    
    return file_name
                        

@view_config(route_name='storage_download', permission="login")
def download(request):

    file_name = cache_file(request)

    if file_name is None:
        request.response.status = '404 Not Found'
        return request.response
    
    matchdict = request.matchdict
    fizzle = matchdict['fizzle']
    
    response = FileResponse(file_name, request=request, content_encoding=None)
    extension = fizzle[fizzle.rfind("."):]
    if extension == ".png":
        response = Response(content_type='image/png')
    elif extension == ".jpg":
        response = Response(content_type='image/jpeg')
    elif extension in [".mpg", ".mpeg", ".avi"]:
        response = Response(content_type='video/mpeg')
    elif extension in [".mp4"]:
        response = Response(content_type='video/mp4')
    elif extension in ".avi":
        response = Response(content_type='video/msvideo')
    elif extension in [".ogv", ".ogg"]:
        response.content_type='video/ogg'
    
    response.content_encoding = None
    
    return response

@view_config(route_name='storage_delete', permission="login")
def delete(request):
    matchdict = request.matchdict
    fizzle = matchdict['fizzle']
    
    uri = fizzle[1:]
    end_pos = uri.find("/")
    if end_pos > 0:
        camera_name = uri[:end_pos]
    else:
        camera_name = uri
    
    camera = models.Camera.objects(owner=request.user, name=camera_name).first()
    if camera is None:
        return None
    
    key_name = "%d%s"%(camera.id, uri[end_pos:])
    
    s3_storage = request.s3_storage
    s3_storage.delete(key_name)
    
    url = request.referer
    extension = url[url.rfind("."):]
    if len(extension) < 5:
        fizzle = fizzle[:fizzle.rfind("/")]
        url = request.route_path("storage_list", fizzle=fizzle)

    return HTTPFound(url)

@view_config(route_name='storage_view', permission="login", renderer='/storage/view.mako')
def view(request):
    matchdict = request.matchdict
    fizzle = matchdict['fizzle']
    
    file_type="unknow"
    extension = fizzle[fizzle.rfind("."):]
    if extension in [".png", ".jpg", ".jpeg"]:
        file_type="image"
    elif extension in [".avi", ".ogg", ".ogv", ".mpg", ".webm"]:
        file_type="video"

    url         = request.route_path("storage_download", fizzle=fizzle)
    delete_url  = request.route_path("storage_delete", fizzle=fizzle)
    

    return dict (
                 file_type=file_type,
                 url=urllib.url2pathname(url),
                 delete_url=urllib.url2pathname(delete_url),
                 )