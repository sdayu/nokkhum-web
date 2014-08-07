
def apis_include(config):
    config.add_route('apis.admin.compute_nodes.resources',
                     '/admin/compute_nodes/{compute_node_id}/resources')
    config.add_route('apis.admin.processors.resources',
                     '/admin/processors/{processor_id}/resources')


def add_routes(config):
    config.add_route('index', '/')
    config.add_route('home', '/home')

    config.add_route('login', '/login')
    config.add_route('logout', '/logout')
    config.add_route('register', '/register')

    # manager part
    # project manager
    config.add_route('projects.add', '/manager/projects/add')
    config.add_route('projects.index', '/manager/projects')
    config.add_route('projects.view', '/manager/projects/{project_id}')
    config.add_route('projects.edit', '/manager/projects/{project_id}/edit')
    config.add_route('projects.delete', '/manager/projects/{project_id}/delete')

    # camera manager
    config.add_route('cameras.add', '/manager/{project_id}/cameras/add')
    config.add_route('cameras.edit', '/manager/{project_id}/cameras/{camera_id}/edit')
    config.add_route('cameras.delete', '/manager/{project_id}/cameras/{camera_id}/delete')
    config.add_route('cameras.processor', '/manager/{project_id}/cameras/{camera_id}/processor')
    config.add_route('cameras.view', '/manager/{project_id}/cameras/{camera_id}/view')
    config.add_route('cameras.test_view', '/manager/{project_id}/cameras/{camera_id}/test_view')
    config.add_route('cameras.live_view', '/manager/{project_id}/cameras/{camera_id}/live_view')
    config.add_route('cameras.index', '/manager/{project_id}/cameras')

    # processors
    config.add_route('processors.add', '/manager/{project_id}/processors/add')
    config.add_route('processors.edit', '/manager/{project_id}/processors/{processor_id}/edit')
    config.add_route('processors.delete', '/manager/{project_id}/processors/{processor_id}/delete')
    config.add_route('processors.setting', '/manager/{project_id}/processors/{processor_id}/setting')
    config.add_route('processors.view', '/manager/{project_id}/processors/{processor_id}/view')
    config.add_route('processors.operating', '/manager/{project_id}/processors/{processor_id}/operating/{action}')
    config.add_route('processors.index', '/manager/{project_id}/processors')

    # api
    config.add_route('apis.camera_models.list_by_manufactories', '/manufactories/{manufactory_id}/models')
    config.include(apis_include, route_prefix='/apis')

    # storage
    config.add_route('storage.list', '/home/storage/list{extension:.*}')
    config.add_route('storage.download', '/home/storage/download{extension:.*}')
    config.add_route('storage.view', '/home/storage/view{extension:.*}')
    config.add_route('storage.delete', '/home/storage/delete{extension:.*}')
    
    # administration part
    config.add_route('admin.home', '/admin')
    
    config.add_route('admin.command_queue.list', '/admin/command_queue/list')
    config.add_route('admin.command_queue.show', '/admin/command_queue/show/{command_queue_id}')
    
    config.add_route('admin.users.list', '/admin/users/list')
    config.add_route('admin.users.show', '/admin/users/show/{user_id}')
    
    config.add_route('admin.command_log.list', '/admin/command_log/list')
    config.add_route('admin.command_log.show', '/admin/command_log/show/{command_log_id}')
    
    config.add_route('admin.compute_nodes.list', '/admin/compute_nodes/list')
    config.add_route('admin.compute_nodes.show', '/admin/compute_nodes/show/{compute_node_id}')
    config.add_route('admin.compute_nodes.delete', '/admin/compute_nodes/delete/{compute_node_id}')
    
    config.add_route('admin.cameras.list', '/admin/cameras/list')
    config.add_route('admin.cameras.show', '/admin/cameras/show/{camera_id}')
    
    config.add_route('admin.processors.list', '/admin/processors/list')
    config.add_route('admin.processors.show', '/admin/processors/show/{processor_id}')
    
    config.add_route('admin.processor_commands.show', '/admin/processor_commands/{processor_command_id}')
    
    config.add_route('admin.processor_running_fail.list', '/admin/processors/fail/list')
    
    # administration cache manager
    config.add_route('admin.cache.stat', '/admin/cache/stat')
    config.add_route('admin.cache.clear', '/admin/cache/clear')
    
    
    
    config.add_view('nokkhumweb.views.accounts.login',
                    context='pyramid.exceptions.Forbidden',
                    renderer='nokkhumweb:templates/accounts/login.mako')
    
    # static view
    config.add_static_view('public', 'nokkhumweb:public')
    config.add_static_view('js', 'nokkhumweb:public/js')
    config.add_static_view('theme', 'nokkhumweb:public/theme')
    config.add_static_view('libs', 'nokkhumweb:public/libs')
    
