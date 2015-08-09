from pyramid.view import view_config
from pyramid.response import Response

from nokkhumweb.forms import user_form

from pyramid.httpexceptions import HTTPFound
from pyramid.security import remember
from pyramid.security import forget
from pyramid.security import authenticated_userid
from pyramid.url import route_url

@view_config(route_name='index', renderer='/accounts/login.jinja2')
@view_config(route_name='login', renderer='/accounts/login.jinja2')
def login(request):
    if request.user:
        return HTTPFound(location=request.route_path('home'))
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
        password = request.params['password']

        session = request.session
        session['email'] = email
        session['password'] = password
#        user = models.User.objects(email=email, password=password).first()
        user = request.nokkhum_client.authenticate()

        if user:
            headers = remember(request, email)
            session =  request.session
            session[email] = user
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
    email = request.userid
    headers = forget(request)
    
    if email in request.session:
        del request.session[email]
    
    return HTTPFound(location = route_url('index', request),
                     headers = headers)

@view_config(route_name='home', permission='authenticated', renderer="/accounts/home.jinja2")
def home(request):
    return dict()
    
@view_config(route_name='register', renderer="/accounts/register.jinja2")
def register(request):
    form = user_form.Register(request.POST)
    
    if len(request.POST) and form.validate():
        email     = form.data.get('email')
        password = form.data.get('password')
        
        first_name = form.data.get('first_name')
        last_name = form.data.get('last_name')
    else:
        return dict(
                    form=form
                    )
    
    request.nokkhum_client.accounts.register(**form.data)

    
    return HTTPFound(location = request.route_url('index'))
    
