from pyramid.view import view_config
from pyramid.response import Response

from nokkhum import models

from pyramid.httpexceptions import HTTPFound
from pyramid.security import remember
from pyramid.security import forget
from pyramid.security import authenticated_userid
from pyramid.url import route_url

@view_config(route_name='login', renderer='account/login.mako')
def login(request):
    
    signin_url = route_url('login', request)
    referrer = request.url
    if referrer == signin_url:
        referrer = '/' # never use the login form itself as came_from
    came_from = request.params.get('came_from', referrer)
    message = ''
    email = ''
    password = ''
    
    if 'form.submitted' in request.params:
        email = request.params['email']
        password = request.secret_manager.getHashPassword(request.params['password'])

        user = models.User.objects(email=email, password=password).first()
        
        if user:
            headers = remember(request, email)
            if came_from == '/':
                came_from = '/home'
            return HTTPFound(location = came_from,
                             headers = headers)
        message = 'Failed login'

    return dict(
        message = message,
        url = request.application_url + '/login',
        came_from = came_from,
        email = email,
        password = password,
        )
    
@view_config(route_name='logout')
def logout(request):
    headers = forget(request)
    return HTTPFound(location = route_url('index', request),
                     headers = headers)

@view_config(route_name='home', permission='login', renderer="account/home.mako")
def home(request):
    cameras = models.Camera.objects(owner=request.user).all()

    return dict(
              cameras = cameras  
                )
