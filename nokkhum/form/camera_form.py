# -*- coding:utf-8 -*-
from nokkhum.form import camera_form_validator as c_validators
from nokkhum.form import image_processor_form_validators

import colander
from .deform_wrapper import validators

class AddCameraForm(colander.MappingSchema):


    name        = colander.SchemaNode(colander.String(), 
                        validator=colander.All(c_validators.valid_name, c_validators.unique_camera_name))
    url         = colander.SchemaNode(colander.String(), validator=validators.URL())
    username    = colander.SchemaNode(colander.String(), missing='')
    password    = colander.SchemaNode(colander.String(), missing='')
    fps         = colander.SchemaNode(colander.Integer())
    image_size  = colander.SchemaNode(colander.String())
    camera_model = colander.SchemaNode(colander.String())
    camera_man  = colander.SchemaNode(colander.String())
    storage_periods = colander.SchemaNode(colander.Integer(), validator=colander.Range(min=0), missing=0)
    
class EditCameraForm(AddCameraForm):
    name        = colander.SchemaNode(colander.String(), 
                        validator=colander.All(c_validators.valid_name, c_validators.unique_camera_name))
    url         = colander.SchemaNode(colander.String(), validator=validators.URL())
    username    = colander.SchemaNode(colander.String(), missing='')
    password    = colander.SchemaNode(colander.String(), missing='')
    fps         = colander.SchemaNode(colander.Integer())
    image_size  = colander.SchemaNode(colander.String())
    camera_model = colander.SchemaNode(colander.String())
    camera_man  = colander.SchemaNode(colander.String())
    storage_periods = colander.SchemaNode(colander.Integer(), validator=colander.Range(min=0), missing=0)
    
    camera_status = colander.SchemaNode(colander.String())
    
class CameraProcessorForm(colander.MappingSchema):
    allow_extra_fields = True
    filter_extra_fields = True
    
    processors=colander.SchemaNode(colander.String(), validator= image_processor_form_validators.image_processor)
