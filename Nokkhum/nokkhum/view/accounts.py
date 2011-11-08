from pyramid.view import view_config
from pyramid.response import Response

from nokkhum import model

from pyramid.httpexceptions import HTTPFound
from pyramid.security import remember
from pyramid.security import forget
from pyramid.security import authenticated_userid
from pyramid.url import route_url

@view_config(route_name='signin', renderer='account/signin.mako')
def signin(request):
    
    signin_url = route_url('signin', request)
    referrer = request.url
    if referrer == signin_url:
        referrer = '/' # never use the login form itself as came_from
    came_from = request.params.get('came_from', referrer)
    message = ''
    username = ''
    password = ''
    
    if 'form.submitted' in request.params:
        username = request.params['username']
        password = request.secret_manager.getHashPassword(request.params['password'])

        user = model.User.objects(username=username, password=password).first()
        
        if user:
            headers = remember(request, username)
            if came_from == '/':
                came_from = '/home'
            return HTTPFound(location = came_from,
                             headers = headers)
        message = 'Failed login'

    return dict(
        message = message,
        url = request.application_url + '/signin',
        came_from = came_from,
        username = username,
        password = password,
        )
    
@view_config(route_name='signout')
def signout(request):
    headers = forget(request)
    return HTTPFound(location = route_url('index', request),
                     headers = headers)

@view_config(route_name='home', permission='signin', renderer="account/home.mako")
def home(request):
    cameras = model.Camera.objects(user=request.user).all()

    return dict(
              cameras = cameras  
                )
