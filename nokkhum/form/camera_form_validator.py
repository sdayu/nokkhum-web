from wtforms import validators

from pyramid.threadlocal import get_current_request
import re


def unique_camera_name(form, field):
        
    request = get_current_request()
    matchdict = request.matchdict
    
    project = models.Project.objects(name=matchdict.get('project_name')).first()
    
    camera = models.Camera.objects(name=field.data, project=project)\
            .first()
    
    if camera is not None:
        camera_name = matchdict.get('name', None)
        
        if camera_name is not None and camera.name == camera_name:
            return 
         
        raise validators.ValidationError(
                      'Your camera name %s exist'% field.data)
            
def valid_name(form, field):
    letter_regex = re.compile(r'[a-zA-Z0-9_ -]')
    symbol = letter_regex.sub('', field.data)
    
    if len(symbol) > 0:
        raise validators.ValidationError('This symbol "%s" not permit' % field.data)