from wtforms import validators

from pyramid.threadlocal import get_current_request
import re


def unique_camera_name(form, field):
        
    request = get_current_request()
    matchdict = request.matchdict
    
    camera_id = matchdict.get('camera_id')
    camera = None
    if camera_id:
        camera = request.nokkhum_client.cameras.get(camera_id)
    cameras = request.nokkhum_client.cameras.list_cameras_by_project(matchdict.get('project_id'))
    
    for cam in cameras:
        if cam.name == field.data:
            
            if camera is not None and camera.id == cam.id:
                break
            
            raise validators.ValidationError(
                        'Your camera name %s exist'% field.data)
            
def valid_name(form, field):
    letter_regex = re.compile(r'[a-zA-Z0-9_ -]')
    symbol = letter_regex.sub('', field.data)
    
    if len(symbol) > 0:
        raise validators.ValidationError('This symbol "%s" not permit' % field.data)