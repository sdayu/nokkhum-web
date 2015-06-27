from pyramid.httpexceptions import HTTPFound

from pyramid.view import view_config
from pyramid.response import Response, FileResponse
from pyramid.security import authenticated_userid

from nokkhumweb.forms import camera_form

import os
import urllib

@view_config(route_name='storage.list', permission='authenticated', renderer='/storage/list_file.mako')
def storage_list(request):

    file_list = []
    matchdict = request.matchdict
    extension = matchdict['extension']
    
#    print ("extension: '%s'" % extension)
#    for cam_id in s3_client.list_file():
#        camera = models.Camera.objects(id=int(cam_id)).first()
#        print "cam id: ", cam_id
#        if camera is not None:
#            result.append(camera.name)
#            print "name: ", camera.name
    if len(extension) == 0 or extension == "/":
        processors = request.nokkhum_client.processors.list()
        for processor in processors:
            file_list.append((processors.name, request.route_path('storage.list', extension="/%s"%processors.name)))
    else:
        uri = extension[1:]
        end_pos = uri.find("/")
        if end_pos > 0:
            processor_id = uri[:end_pos]
        else:
            processor_id = uri
#        print ("camera name:", processor_id)
        processor = request.nokkhum_client.processors.get(processor_id)
    
        prefix = ""
        if len(uri[end_pos+1:]) > 0 and uri[end_pos+1:] != processor_id:
            prefix = uri[end_pos:]

#        print ("storage prefix: ", prefix)
        items = None
        if len(prefix) > 0:
            items = request.nokkhum_client.storage.list(prefix)
        else:
            items = processor.storage
            
        for item in items:
#            print("item: ", item.__dict__)
            
            path = item.url
            
            download_url = None
            if item.file:
                view_link = request.route_path('storage.view', extension="/%s%s"%(processor.id, path))
                download_url = item.download
            else:
                view_link = request.route_path('storage.list', extension="/%s%s"%(processor.id, path))
                
            delete_link = request.route_path('storage.delete', extension="/%s%s"%(processor.id, path))
            
            file_list.append((item.name, urllib.parse.unquote(view_link), urllib.parse.unquote(delete_link), download_url))
    return dict(
                project_id=processor.project.id,
                file_list=file_list,
                )

@view_config(route_name='storage.delete', permission='authenticated')
def delete(request):
    matchdict = request.matchdict
    extension = matchdict['extension']
    
    uri = extension[1:]
    end_pos = uri.find("/")
    if end_pos > 0:
        processor_id = uri[:end_pos]
    else:
        processor_id = uri
    
    key = "/storage"
    identify = extension[extension.find(key):]
    # print("identify: ", identify)
   
    dot_count = identify.rfind(".")
    item = None
    items = None
    if dot_count >= 0:
        item = request.nokkhum_client.storage.get(identify)
    else:
        items = request.nokkhum_client.storage.list(identify)
    
    if item:
        request.nokkhum_client.storage.delete(item)
    if items:
        request.nokkhum_client.storage.delete_identify(identify)
    
    url = request.referer
    if not url:
        url = extension

    dot_count = url.rfind(".")
    file_extension=None
    if dot_count >= 0:
        file_extension = url[url.rfind("."):]

    if file_extension:
        extension = extension[:extension.rfind("/")]
        url = request.route_path("storage.list", extension=extension)

    return HTTPFound(url)

@view_config(route_name='storage.view', permission='authenticated', renderer='/storage/view.mako')
def view(request):
    matchdict = request.matchdict
    extension = matchdict['extension']
    
#    print ("extension:", extension)
    file_type="unknow"
    file_extension = extension[extension.rfind("."):]
    if file_extension in [".png", ".jpg", ".jpeg"]:
        file_type="image"
    elif file_extension in [".avi", ".ogg", ".ogv", ".mpg", ".webm", ".mp4"]:
        file_type="video"
    
    key = "/storage"
    identify = extension[extension.find(key):]
    # print("identify: ", identify)
   
    item = request.nokkhum_client.storage.get(identify)
    
    key = extension[extension.rfind('/'):]
    
    url         = item.download
    delete_url  = request.route_path("storage.delete", extension=extension)
    

    return dict (
                 file_type=file_type,
                 url=urllib.request.url2pathname(url),
                 delete_url=urllib.request.url2pathname(delete_url),
                 )