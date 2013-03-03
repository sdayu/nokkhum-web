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
#        print ("camera name:", camera_name)
        camera = request.nokkhum_client.cameras.get(camera_name)
    
        prefix = ""
        if len(uri[end_pos+1:]) > 0 and uri[end_pos+1:] != camera_name:
            prefix = uri[end_pos:]

#        print ("storage prefix: ", prefix)
        items = None
        if len(prefix) > 0:
            items = request.nokkhum_client.storage.list(prefix)
        else:
            items = camera.storage
            
        for item in items:
#            print("item: ", item.name)
            
            path = item.url
                
            if item.file:
                view_link = request.route_path('storage.view', fizzle="/%s%s"%(camera.name, path))
            else:
                view_link = request.route_path('storage.list', fizzle="/%s%s"%(camera.name, path))
                
            delete_link = request.route_path('storage.delete', fizzle="/%s%s"%(camera.name, path))
            
            file_list.append((item.name, urllib.parse.unquote(view_link), urllib.parse.unquote(delete_link)))
    return dict(
                file_list=file_list,
                )

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
    
    key = "/storage"
    identify = fizzle[fizzle.find(key):]
    # print("identify: ", identify)
   
    item = request.nokkhum_client.storage.get(identify)

    if item:
        request.nokkhum_client.storage.delete(item)
    
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
    
#    print ("fizzle:", fizzle)
    file_type="unknow"
    extension = fizzle[fizzle.rfind("."):]
    if extension in [".png", ".jpg", ".jpeg"]:
        file_type="image"
    elif extension in [".avi", ".ogg", ".ogv", ".mpg", ".webm"]:
        file_type="video"
    
    key = "/storage"
    identify = fizzle[fizzle.find(key):]
    # print("identify: ", identify)
   
    item = request.nokkhum_client.storage.get(identify)
    
    key = fizzle[fizzle.rfind('/'):]
    
    url         = item.download
    delete_url  = request.route_path("storage.delete", fizzle=fizzle)
    

    return dict (
                 file_type=file_type,
                 url=urllib.request.url2pathname(url),
                 delete_url=urllib.request.url2pathname(delete_url),
                 )