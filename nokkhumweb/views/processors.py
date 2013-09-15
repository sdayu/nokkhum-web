from pyramid.httpexceptions import HTTPFound

from pyramid.view import view_config
from pyramid.response import Response

from nokkhum import form

@view_config(route_name='processors.index', permission='login', renderer='/processors/index.mako')
def index(request):
    matchdict = request.matchdict
    project_id = matchdict['project_id']
    
    project = request.nokkhum_client.projects.get(project_id)
    processors = None
    if project is not None:
        processors = project.processors

    print("processors:", processors)
    return dict(
                project=project,
                processors=processors
                )

@view_config(route_name='processors.add', permission='login', renderer='/processors/add.mako')
def add(request):
    matchdict = request.matchdict
    project_id = matchdict['project_id']
    project = request.nokkhum_client.projects.get(project_id)
    
    
    
    return dict(project=project)

@view_config(route_name='processors.edit', permission='login', renderer='/processors/edit.mako')
def edit(request):
    return dict()

@view_config(route_name='processors.setting', permission='login', renderer='/processors/setting.mako')
def setting(request):
    return dict()

@view_config(route_name='processors.operating', permission='login', renderer='/processors/operating.mako')
def operating(request):
    return dict()