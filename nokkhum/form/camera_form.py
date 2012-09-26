# -*- coding:utf-8 -*-

from wtforms import fields
from wtforms import validators

from . import AbstactForm

from nokkhum.form import camera_form_validator as c_validators
from nokkhum.form import image_processor_form_validators

class AddCameraForm(AbstactForm):


    name        = fields.TextField('Name', validators=[validators.required(), c_validators.valid_name, c_validators.unique_camera_name])
    url         = fields.TextField('URL', validators=[validators.required()])
    username    = fields.TextField('Username')
    password    = fields.TextField('Password')
    fps         = fields.SelectField('FPS', coerce=int, validators=[validators.required()])
    image_size  = fields.SelectField('Image Size', validators=[validators.required()])
    camera_model= fields.SelectField('Camera Model', validators=[validators.required()])
    camera_man  = fields.SelectField('Camera manufactory', validators=[validators.required()])
    storage_periods = fields.IntegerField('Storage Periods', validators=[validators.required(), validators.NumberRange(min=0, max=360)])
    
class EditCameraForm(AddCameraForm):

    camera_status = fields.SelectField('Camera Status', validators=[validators.required()])
    
class CameraProcessorForm(AbstactForm):
    processors = fields.TextAreaField('Processors', validators=[validators.required(), image_processor_form_validators.image_processor])
