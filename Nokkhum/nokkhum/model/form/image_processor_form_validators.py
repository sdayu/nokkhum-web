import formencode
from nokkhum import model
from nokkhum import view
import ast

class ImageProcessor(formencode.FancyValidator):
    messages = {
        'not_found': 'This image processor "%(processor)s" not fould',
        'syntax_error': 'Syntax Error',
    }
    processor = ''

    def _to_python(self, value, state):
        return value.strip()

    def validate_python(self, value, state):
#    	print 'value:\n ', value,'\n==='
        try:
            processors = ast.literal_eval(value)
        except:
            raise formencode.Invalid(self.message("syntax_error", state),
                value, state)
            
        check = self.check_avialable_processor(processors)
        if not check:
            raise formencode.Invalid(self.message("not_found", state,
                processor=self.processor),
                value, state)
        
    def check_avialable_processor(self, processors):
#        print 'processor: ', processors
        
        if isinstance(processors, basestring):
#            print 'processor->: ', processors
            pro = model.ImageProcessor.objects(name=processors).first()
            if not pro:
                self.processor = processors
                return False
            else:
                return True
                
        for processor in processors:
            if not processors[processor]:
#                print 'processor-->: ', processor
                return self.check_avialable_processor(processor)
            else:
#                print 'processor--x>: ', processor
                return self.check_avialable_processor(processors[processor])
            
            