'''
Created on Mar 7, 2012

@author: boatkrap
'''

import deform
import colander

class Form:
    def __init__(self, request, schema, bind=None):
        self.schema = schema
        self.request = request
        self.form = deform.Form(schema)
        self.data = {}
        self.error_msg = {}
        
        self.bind = bind
        
    def validate(self):
        controls = self.request.params.items()
        if len(controls) == 0:
            if self.bind is not None:
                if type(self.bind) is dict:
                    self.data = self.bind
                else:
                    self.data = self.bind.__dict__
                    
                print "data: ", self.data
                
            return False
        
        try:
            self.data = self.form.validate(controls)
            return True
        except deform.ValidationFailure as e:
            self.data = e.cstruct
            for schema, msg in e.error.children:
                if '${val}' in msg:
                    self.error_msg[schema.name] = msg.replace('${val}', e.cstruct[schema.name])
                else:
                    self.error_msg[schema.name] = msg
            
            return False
        
    def is_error(self, name):
        if name in self.error_msg:
            return True
        else:
            return False
        
    def get_error(self, name):
        return self.error_msg.get(name, '')

        
    def get(self, name, default=''):
        if self.data.get(name) is colander.null:
            return default
        
        return self.data.get(name, default)
        
        
        
        
        