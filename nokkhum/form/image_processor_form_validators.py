import formencode
from nokkhum import models
import json

class ImageProcessor(formencode.FancyValidator):
    messages = {
        'not_found': 'This image processor "%(processor)s" not fould',
        'syntax_error': '%(syntax_error)s',
    }
    processor_name = []
    processor_name_not_found = ""

    def _to_python(self, value, state):
        return value.strip()

    def validate_python(self, value, state):
#    	print 'value:\n ', value,'\n==='
        try:
            processors = json.loads(value)
        except Exception as e:
            raise formencode.Invalid(self.message("syntax_error", state, syntax_error=e),
                value, state)
        
        self.get_available_processors()
#        print "available name:", self.processor_name
        check = self.check_avialable_processor(processors)
        if not check:
            raise formencode.Invalid(self.message("not_found", state,
                processor=self.processor_name_not_found),
                value, state)
        
    def check_avialable_processor(self, processors):
        
        check = True
        for processor in processors:
#            print "\npricessor:", processor
            if "processors" in processor:
                check = self.check_avialable_processor(processor["processors"])
                if not check:
                    return check

#            print "check name: ", processor["name"], "check status:",check
            
            if not processor["name"] in self.processor_name:
                self.processor_name_not_found = processor["name"] 
                return False
            
        return True
            
    def get_available_processors(self):
        processors = models.ImageProcessor.objects().all()
        
        for processor in processors:
            self.processor_name.append(processor.name)