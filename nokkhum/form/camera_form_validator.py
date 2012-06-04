import colander
from nokkhum import models
from pyramid.threadlocal import get_current_request
import re


def unique_camera_name(node, value):
    
    if not get_current_request():
        raise  colander.Invalid(node,
                      'Bad request')
    
    request = get_current_request()
        
    camera = models.Camera.objects(name=value, owner=request.user)\
            .first()
    
    if camera is not None:
        matchdict = request.matchdict
        camera_name = matchdict.get('name', None)
        
        if camera_name is not None and camera.name == camera_name:
            return value
         
        raise colander.Invalid(node,
                      'Your camera name %s exist', value)
            
def valid_name(node, value):
    letter_regex = re.compile(r'[a-zA-Z0-9_ -]')
    symbol = letter_regex.sub('', value)
    
    if len(symbol) > 0:
        raise colander.Invalid(node,
                      'This symbol "%s" not permit' % value)