'''
Created on Jun 21, 2012

@author: boatkrap
'''


from pyramid.httpexceptions import HTTPFound

from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

from nokkhumweb.forms import project_form

import datetime

@view_config(route_name='projects.index', permission='authenticated', renderer='/projects/index.mako')
def index(request):
    session = request.session[request.userid]
    projects = request.nokkhum_client.projects.list_user_projects(session['access']['user']['id'])

    return dict(projects=projects)


@view_config(route_name='projects.add', permission='authenticated', renderer='/projects/add.mako')
def add(request):
    form = project_form.Project(request.POST)
    if request.POST and form.validate():
        name = form.data.get("name")
        description = form.data.get("description")
    
    else:
        return dict(form=form)
    
    request.nokkhum_client.projects.create(name=name, description=description)
    
    return HTTPFound('/home')

@view_config(route_name='projects.view', permission='authenticated', renderer='/projects/view.mako')
def view(request):
    project_id = request.matchdict['project_id']
    project = request.nokkhum_client.projects.get(project_id)
    return dict(project=project)

@view_config(route_name='projects.edit', permission='authenticated', renderer='/projects/edir.mako')
def edit(request):
    return dict()