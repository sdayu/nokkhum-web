# -*- coding:utf-8 -*-

from wtforms import fields
from wtforms import validators

from . import AbstactForm

from nokkhum.form import camera_form_validator as c_validators
from nokkhum.form import image_processor_form_validators

class AddCameraForm(AbstactForm):


    name        = fields.TextField(u'Name', validators=[validators.required(), c_validators.valid_name, c_validators.unique_camera_name])
    url         = fields.TextField(u'URL', validators=[validators.required()])
    username    = fields.TextField(u'Username')
    password    = fields.TextField(u'Password')
    fps         = fields.SelectField(u'FPS', coerce=int, validators=[validators.required()])
    image_size  = fields.SelectField(u'Image Size', validators=[validators.required()])
    camera_model= fields.SelectField(u'Camera Model', validators=[validators.required()])
    camera_man  = fields.SelectField(u'Camera manufactory', validators=[validators.required()])
    storage_periods = fields.IntegerField(u'Storage Periods', validators=[validators.required(), validators.NumberRange(min=0, max=360)])
    
class EditCameraForm(AddCameraForm):

    camera_status = fields.SelectField(u'Camera Status', validators=[validators.required()])
    
class CameraProcessorForm(AbstactForm):
    processors = fields.TextAreaField(u'Processors', validators=[validators.required(), image_processor_form_validators.image_processor])
