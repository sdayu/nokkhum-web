

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
    
    # camera operating
    config.add_route('camera_operating', '/manager/cameras/{name}/{operating}')
    
    config.add_view('nokkhum.view.accounts.login',
                    context='pyramid.exceptions.Forbidden',
                    renderer='nokkhum:templates/account/login.mako')
    
    # static view
    config.add_static_view('public', 'nokkhum:public')
    config.add_static_view('js', 'nokkhum:public/js')
    
