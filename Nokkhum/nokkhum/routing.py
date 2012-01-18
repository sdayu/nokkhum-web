

def add_routes(config):
    config.add_route('index', '/')
    config.add_route('home', '/home')
    
    config.add_route('login', '/login')
    config.add_route('logout', '/logout')
    
    # manager part
    # camera manager
    config.add_route('camera_add', '/manager/cameras/add')
    config.add_route('camera_edit', '/manager/cameras/{name}/edit')
    config.add_route('camera_delete', '/manager/cameras/{name}/delete')
    config.add_route('camera_setting', '/manager/cameras/{name}/setting')
    config.add_route('camera_processor', '/manager/cameras/{name}/processor')
    config.add_route('camera_view', '/manager/cameras/{name}/view')
    config.add_route('camera_test_view', '/manager/cameras/{name}/test_view')
    
    # camera operating
    config.add_route('camera_operating', '/manager/cameras/{name}/{operating}')
    
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
    
    config.add_view('nokkhum.views.accounts.login',
                    context='pyramid.exceptions.Forbidden',
                    renderer='nokkhum:templates/account/login.mako')
    
    # static view
    config.add_static_view('public', 'nokkhum:public')
    config.add_static_view('js', 'nokkhum:public/js')
    config.add_static_view('theme', 'nokkhum:public/theme')
    
