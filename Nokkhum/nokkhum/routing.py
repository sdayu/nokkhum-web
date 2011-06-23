

def add_routes(config):
    config.add_route('index', '/')
    config.add_route('home', '/home')
    
    config.add_route('signin', '/signin')
    config.add_route('signout', '/signout')
    
    config.add_route('camera_add', '/cameras/add')
    config.add_route('camera_delete', '/cameras/{name}/delete')
    config.add_route('camera_setting', '/cameras/{name}/setting')
    config.add_route('camera_processor', '/cameras/{name}/processor')
    
    config.add_view('nokkhum.view.accounts.signin',
                    context='pyramid.exceptions.Forbidden',
                    renderer='nokkhum:templates/account/signin.mako')
