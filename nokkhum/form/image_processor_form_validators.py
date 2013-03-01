from wtforms import validators

import json
            
def image_processor(form, field):
    processor_name = []
    processor_name_not_found = ""
    
    def check_avialable_processor(processors):
        
        check = True
        for processor in processors:
#            print "\npricessor:", processor
            if "processors" in processor:
                check = check_avialable_processor(processor["processors"])
                if not check:
                    return check

#            print "check name: ", processor["name"], "check status:",check
            
            if not processor["name"] in processor_name:
                processor_name_not_found = processor["name"] 
                return False
            
        return True
            
    def get_available_processors():
        processors = models.ImageProcessor.objects().all()
        
        for processor in processors:
            processor_name.append(processor.name)
    
    try:
        processors = json.loads(field.data)
    except Exception as e:
        raise validators.ValidationError(
                      '%s' % e)
    
    get_available_processors()
#        print "available name:", self.processor_name
    check = check_avialable_processor(processors)
    if not check:
        raise validators.ValidationError(
                'This image processor "%s" not fould' % processor_name_not_found)
