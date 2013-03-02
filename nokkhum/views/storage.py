from pyramid.httpexceptions import HTTPFound

from pyramid.view import view_config
from pyramid.response import Response, FileResponse
from pyramid.security import authenticated_userid

from nokkhum.form import camera_form

import os
import urllib

@view_config(route_name='storage.list', permission="login", renderer='/storage/list_file.mako')
def storage_list(request):

    file_list = []
    matchdict = request.matchdict
    fizzle = matchdict['fizzle']
#    print ("fizzle: '%s'" % fizzle)
#    for cam_id in s3_client.list_file():
#        camera = models.Camera.objects(id=int(cam_id)).first()
#        print "cam id: ", cam_id
#        if camera is not None:
#            result.append(camera.name)
#            print "name: ", camera.name
    if len(fizzle) == 0 or fizzle == "/":
        cameras = models.Camera.objects(owner=request.user).all()
        for camera in cameras:
            file_list.append((camera.name, request.route_path('storage.list', fizzle="/%s"%camera.name)))
    else:
        uri = fizzle[1:]
        end_pos = uri.find("/")
        if end_pos > 0:
            camera_name = uri[:end_pos]
        else:
            camera_name = uri
#        print "camera name: ", camera_name
        camera = request.nokkhum_client.cameras.get(camera_name)
    
        
    
#        s3_client.set_buckket_name(int(camera.id))
#
        prefix = ""
        if len(uri[end_pos+1:]) > 0 and uri[end_pos+1:] != camera_name:
            prefix = "%s/" % (uri[end_pos+1:])

        print ("storage prefix: ", prefix)
        items = None
        if len(prefix) > 0:
            items = request.nokkhum_client.storage.list('/'+prefix)
        else:
            items = camera.storage
            
        for item in items:
            print("item: ", item.name)
            
            path = item.url
                
#            extension = ""
#            pos = path.rfind(".")
#            if pos > 0:
#                extension = path[pos:]
#                if extension not in [".jpg", ".png", ".avi", ".webm", ".webp", ".ogg", ".ogv"]:
#                    extension = ""
            if item.file:
                view_link = request.route_path('storage.view', fizzle="/%s%s"%(camera.name, path))
            else:
                view_link = request.route_path('storage.list', fizzle="/%s%s"%(camera.name, path))
                
            delete_link = request.route_path('storage.delete', fizzle="/%s%s"%(camera.name, path))
            
            file_list.append((item.name, urllib.parse.unquote(view_link), urllib.parse.unquote(delete_link)))
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
    
    key_name = "%s"%(uri[end_pos+1:])
    container_dir = "%s/%d/%s"%(cache_dir, user.id, key_name[:key_name.rfind("/")])
    file_name = "%s/%d/%s"%(cache_dir, user.id, key_name)
    
    s3_client = request.s3_client
    s3_client.set_buckket_name(int(camera.id))

    if not s3_client.is_avialabel(key_name):
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
    s3_client.get_file(key_name, file_name)
    
    return file_name
                        

@view_config(route_name='storage.download', permission="login")
def download(request):

    file_name = cache_file(request)

    if file_name is None:
        request.response.status = '404 Not Found'
        return request.response
    
    #matchdict = request.matchdict
    #fizzle = matchdict['fizzle']
    
    response = FileResponse(file_name, request=request, content_encoding=None)
    
    response.content_encoding = None
    
    return response

@view_config(route_name='storage.delete', permission="login")
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
    
    key_name = "%s"%(uri[end_pos+1:])
    
    s3_client = request.s3_client
    s3_client.set_buckket_name(int(camera.id))
    s3_client.delete(key_name)
    
    url = request.referer
    extension = url[url.rfind("."):]
    if len(extension) < 5:
        fizzle = fizzle[:fizzle.rfind("/")]
        url = request.route_path("storage.list", fizzle=fizzle)

    return HTTPFound(url)

@view_config(route_name='storage.view', permission="login", renderer='/storage/view.mako')
def view(request):
    matchdict = request.matchdict
    fizzle = matchdict['fizzle']
    
    
    print ("fizzle:", fizzle)
    file_type="unknow"
    extension = fizzle[fizzle.rfind("."):]
    if extension in [".png", ".jpg", ".jpeg"]:
        file_type="image"
    elif extension in [".avi", ".ogg", ".ogv", ".mpg", ".webm"]:
        file_type="video"
    
    key = "/storage"
    identify = fizzle[fizzle.find(key):fizzle.rfind('/')]
    print("identify: ", identify)
   
    items = request.nokkhum_client.storage.list(identify)
    
    key = fizzle[fizzle.rfind('/'):]

    item = None
    for tmp in items:
        if key in tmp.url:
            item = tmp
            break
    

    url         = item.download
    delete_url  = request.route_path("storage.delete", fizzle=fizzle)
    

    return dict (
                 file_type=file_type,
                 url=urllib.request.url2pathname(url),
                 delete_url=urllib.request.url2pathname(delete_url),
                 )