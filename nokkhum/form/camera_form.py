# -*- coding:utf-8 -*-
import formencode
from nokkhum.form import camera_form_validator
from nokkhum.form import image_processor_form_validators

class AddCameraForm(formencode.Schema):
    allow_extra_fields = True
    filter_extra_fields = True

    name        = formencode.All(camera_form_validator.ValidName(), 
                          camera_form_validator.UniqueCameraName())
    url         = formencode.validators.String(not_empty=True)
    username    = formencode.validators.String()
    password    = formencode.validators.String()
    fps         = formencode.validators.Int(not_empty=True)
    image_size  = formencode.validators.String(not_empty=True)
    camera_model = formencode.validators.String(not_empty=True)
    camera_man  = formencode.validators.String(not_empty=True)
    storage_periods = formencode.validators.Int(not_empty=False, min=0)
    
class EditCameraForm(AddCameraForm):
    camera_status = formencode.validators.String(not_empty=True)
    
class CameraProcessorForm(formencode.Schema):
    allow_extra_fields = True
    filter_extra_fields = True
    
    processors=formencode.All(formencode.validators.String(), 
                          image_processor_form_validators.ImageProcessor())