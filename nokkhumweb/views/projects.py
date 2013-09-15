'''
Created on Jun 21, 2012

@author: boatkrap
'''


from pyramid.httpexceptions import HTTPFound

from pyramid.view import view_config
from pyramid.response import Response
from pyramid.security import authenticated_userid

from nokkhum.form import project_form

import datetime

@view_config(route_name='projects.index', permission='login', renderer='/projects/index.mako')
def index(request):
    matchdict = request.matchdict
    project_id = matchdict['project_id']
    
    #project = models.Project.objects(name=name).first()
    #cameras = models.Camera.objects(project=project).order_by('name').all()
    project = request.nokkhum_client.projects.get(project_id)
    cameras = None
    if project is not None:
        cameras = project.cameras

    return dict(
                project=project,
                cameras=cameras
                )

@view_config(route_name='projects.add', permission='login', renderer='/projects/add.mako')
def add(request):
    form = project_form.Project(request.POST)
    if request.POST and form.validate():
        name = form.data.get("name")
        description = form.data.get("description")
    
    else:
        return dict(form=form)
    
    request.nokkhum_client.projects.create(name=name, description=description)
    
    return HTTPFound('/home')