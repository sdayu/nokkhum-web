import formencode
from nokkhum import model
from nokkhum import view
from pyramid.threadlocal import get_current_request
import re

class UniqueCameraName(formencode.FancyValidator):

    messages = {
        'found': 'Your camera name %(name)s exist ',
        'bad_request': 'Bad request'
    }

    def _to_python(self, value, state):
        return value.strip()

    def validate_python(self, value, state):
#        print '\n\n\n\nvalue: ',value
#        print '\n\n\n\nstate: ',view.request
        if not get_current_request():
            raise formencode.Invalid(
                self.message('bad_request', state),
                          value, state)
            
        camera = model.Camera.objects(name=value, user=get_current_request().user)\
                .first()
        
        if camera:
            raise formencode.Invalid(
                self.message("found", state, name=camera.name),
                          value, state)

class ValidName(formencode.FancyValidator):
    messages = {
        'symbol': 'This symbol "%(symbol)s" not permit',
    }
    
    letter_regex = re.compile(r'[a-zA-Z0-9_ -]')

    def _to_python(self, value, state):
        return value.strip()

    def validate_python(self, value, state):
        symbol = self.letter_regex.sub('', value)
        if len(symbol) > 0:
            raise formencode.Invalid(self.message("symbol", state,
                    symbol=symbol),
                    value, state)