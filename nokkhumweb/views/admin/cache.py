from pyramid.httpexceptions import HTTPFound
from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid
import os

@view_config(route_name='admin.cache.clear', permission='role:admin')
def clear(request):
    cache_dir = request.registry.settings.get('nokkhum.temp_dir', None)
    if os.path.exists(cache_dir):    
        import shutil
        for name in os.listdir(cache_dir):
            shutil.rmtree(cache_dir+"/"+name)
                
    
    return HTTPFound(request.route_path('admin_cache_stat'))

@view_config(route_name='admin.cache.stat', permission='role:admin', renderer='/admin/cache/stat.mako')
def stat(request):
    
    cache = request.nokkhum_client.admin.cache.get()

    return dict(
                cache=cache
                )