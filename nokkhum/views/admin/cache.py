from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid
import os

@view_config(route_name='admin.cache.clear', permission='r:admin')
def clear(request):
    cache_dir = request.registry.settings.get('nokkhum.temp_dir', None)
    if os.path.exists(cache_dir):    
        import shutil
        for name in os.listdir(cache_dir):
            shutil.rmtree(cache_dir+"/"+name)
                
    
    return HTTPFound(request.route_path('admin_cache_stat'))

@view_config(route_name='admin.cache.stat', permission='r:admin', renderer='/admin/cache/stat.mako')
def stat(request):
    
    cache_dir = request.registry.settings.get('nokkhum.temp_dir', None)
    if cache_dir is None or not os.path.exists(cache_dir):
        return dict(
                    cache_dir=False
                    )
        
    file_count  = 0
    for root, dirs, files in os.walk(cache_dir):
        for f in files:
            file_count += 1
    

    return dict(
                cache_dir=True,
                file_count=file_count
                )