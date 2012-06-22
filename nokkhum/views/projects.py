'''
Created on Jun 21, 2012

@author: boatkrap
'''


from pyramid.httpexceptions import HTTPFound

from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

from nokkhum.form import project_form
from nokkhum import models

import datetime

@view_config(route_name='project_index', permission='login', renderer='/project/index.mako')
def index(request):
    matchdict = request.matchdict
    name = matchdict['name']
    
    project = models.Project.objects(name=name).first()
    cameras = models.Camera.objects(project=project).first()
    
    return dict(
                project=project,
                cameras=cameras
                )

@view_config(route_name='project_add', permission='login', renderer='/project/add.mako')
def add(request):
    form = project_form.Project(request.POST)
    if request.POST and form.validate():
        name = form.data.get("name")
        description = form.data.get("description")
    
    else:
        return dict(form=form)
    
    project = models.Project()
    project.name = name
    project.description = description
    project.ip_address = request.environ['REMOTE_ADDR']
    project.status = "Active"
    project.owner = request.user
    
    project.save()
    
    return HTTPFound('/home')