

def add_routes(config):
    config.add_route('index', '/')
    config.add_route('home', '/home')
    
    config.add_route('login', '/login')
    config.add_route('logout', '/logout')
    
    # manager part
    # project manager
    config.add_route('project_add', '/manager/projects/add')
    config.add_route('project_edit', '/manager/projects/{name}/edit')
    config.add_route('project_delete', '/manager/projects/{name}/delete')
    
    # camera manager
    config.add_route('camera_add', '/manager/cameras/add')
    config.add_route('camera_edit', '/manager/cameras/{name}/edit')
    config.add_route('camera_delete', '/manager/cameras/{name}/delete')
    config.add_route('camera_setting', '/manager/cameras/{name}/setting')
    config.add_route('camera_processor', '/manager/cameras/{name}/processor')
    config.add_route('camera_view', '/manager/cameras/{name}/view')
    config.add_route('camera_test_view', '/manager/cameras/{name}/test_view')
    config.add_route('camera_live_view', '/manager/cameras/{name}/live_view')
    
    # camera operating
    config.add_route('camera_operating', '/manager/cameras/{name}/{operating}')
    
    # storage
    config.add_route('storage_list', '/home/storage/list{fizzle:.*}')
    config.add_route('storage_download', '/home/storage/download{fizzle:.*}')
    config.add_route('storage_view', '/home/storage/view{fizzle:.*}')
    config.add_route('storage_delete', '/home/storage/delete{fizzle:.*}')
    
    # administration part
    config.add_route('admin_home', '/admin')
    
    config.add_route('admin_command_queue_list', '/admin/command_queue/list')
    config.add_route('admin_command_queue_show', '/admin/command_queue/show/{id}')
    
    config.add_route('admin_user_list', '/admin/user/list')
    config.add_route('admin_user_show', '/admin/user/show/{id}')
    
    config.add_route('admin_command_log_list', '/admin/command_log/list')
    config.add_route('admin_command_log_show', '/admin/command_log/show/{id}')
    
    config.add_route('admin_compute_node_list', '/admin/compute_node/list')
    config.add_route('admin_compute_node_show', '/admin/compute_node/show/{id}')
    
    config.add_route('admin_camera_list', '/admin/camera/list')
    config.add_route('admin_camera_show', '/admin/camera/show/{id}')
    
    # administration cache manager
    config.add_route('admin_cache_stat', '/admin/cache/stat')
    config.add_route('admin_cache_clear', '/admin/cache/clear')
    
    config.add_view('nokkhum.views.accounts.login',
                    context='pyramid.exceptions.Forbidden',
                    renderer='nokkhum:templates/account/login.mako')
    
    # static view
    config.add_static_view('public', 'nokkhum:public')
    config.add_static_view('js', 'nokkhum:public/js')
    config.add_static_view('theme', 'nokkhum:public/theme')
    config.add_static_view('libs', 'nokkhum:public/libs')
    
