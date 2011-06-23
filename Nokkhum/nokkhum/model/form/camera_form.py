# -*- coding:utf-8 -*-
import formencode
from nokkhum.model.form import camera_form_validator
from nokkhum.model.form import image_processor_form_validators

class AddCameraForm(formencode.Schema):
    allow_extra_fields = True
    filter_extra_fields = True

    name = formencode.All(camera_form_validator.ValidName(), 
                          camera_form_validator.UniqueCameraName())
    url = formencode.validators.String(not_empty=True)
    username = formencode.validators.String()
    password = formencode.validators.String()
    fps = formencode.validators.Int(not_empty=True)
    image_size = formencode.validators.String(not_empty=True)
    camera_model = formencode.validators.String(not_empty=True)
    camera_man = formencode.validators.String(not_empty=True)
    
class CameraProcessorForm(formencode.Schema):
    allow_extra_fields = True
    filter_extra_fields = True
    
    processors=formencode.All(formencode.validators.String(), 
                          image_processor_form_validators.ImageProcessor())