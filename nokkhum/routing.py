

def add_routes(config):
    config.add_route('index', '/')
    config.add_route('home', '/home')
    
    config.add_route('login', '/login')
    config.add_route('logout', '/logout')
    config.add_route('register', '/register')
    
    # manager part
    # project manager
    config.add_route('projects.add', '/manager/projects/add')
    config.add_route('projects.index', '/manager/projects/{project_id}')
    config.add_route('projects.edit', '/manager/projects/{project_id}/edit')
    config.add_route('projects.delete', '/manager/projects/{project_id}/delete')
    
    # camera manager
    config.add_route('cameras.add', '/manager/{project_id}/cameras/add')
    config.add_route('cameras.edit', '/manager/{project_id}/cameras/{camera_id}/edit')
    config.add_route('cameras.delete', '/manager/cameras/{camera_id}/delete')
    config.add_route('cameras.setting', '/manager/cameras/{camera_id}/setting')
    config.add_route('cameras.processor', '/manager/cameras/{camera_id}/processor')
    config.add_route('cameras.view', '/manager/cameras/{camera_id}/view')
    config.add_route('cameras.test_view', '/manager/cameras/{camera_id}/test_view')
    config.add_route('cameras.live_view', '/manager/cameras/{camera_id}/live_view')
    
    # camera operating
    config.add_route('cameras.operating', '/manager/cameras/{camera_id}/{operating}')
    
    # storage
    config.add_route('storage.list', '/home/storage/list{fizzle:.*}')
    config.add_route('storage.download', '/home/storage/download{fizzle:.*}')
    config.add_route('storage.view', '/home/storage/view{fizzle:.*}')
    config.add_route('storage.delete', '/home/storage/delete{fizzle:.*}')
    
    # administration part
    config.add_route('admin.home', '/admin')
    
    config.add_route('admin.command_queue.list', '/admin/command_queue/list')
    config.add_route('admin.command_queue.show', '/admin/command_queue/show/{id}')
    
    config.add_route('admin.users.list', '/admin/user/list')
    config.add_route('admin.users.show', '/admin/user/show/{id}')
    
    config.add_route('admin.command_log.list', '/admin/command_log/list')
    config.add_route('admin.command_log.show', '/admin/command_log/show/{id}')
    
    config.add_route('admin.compute_nodes.list', '/admin/compute_node/list')
    config.add_route('admin.compute_nodes.show', '/admin/compute_node/show/{id}')
    config.add_route('admin.compute_nodes.delete', '/admin/compute_node/delete/{id}')
    
    config.add_route('admin.cameras.list', '/admin/camera/list')
    config.add_route('admin.cameras.show', '/admin/camera/show/{id}')
    
    config.add_route('admin.camera_running_fail.list_camera', '/admin/camera/fail/list')
    
    # administration cache manager
    config.add_route('admin.cache.stat', '/admin/cache/stat')
    config.add_route('admin.cache.clear', '/admin/cache/clear')
    
    
    
    config.add_view('nokkhum.views.accounts.login',
                    context='pyramid.exceptions.Forbidden',
                    renderer='nokkhum:templates/accounts/login.mako')
    
    # static view
    config.add_static_view('public', 'nokkhum:public')
    config.add_static_view('js', 'nokkhum:public/js')
    config.add_static_view('theme', 'nokkhum:public/theme')
    config.add_static_view('libs', 'nokkhum:public/libs')
    
