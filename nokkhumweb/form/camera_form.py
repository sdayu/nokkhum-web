from wtforms import fields
from wtforms import validators

from . import AbstactForm

from nokkhum.form import camera_form_validator as c_validators
from nokkhum.form import image_processor_form_validators

class AddCameraForm(AbstactForm):
    name        = fields.TextField('Name', validators=[validators.required(), c_validators.valid_name, c_validators.unique_camera_name])
    username    = fields.TextField('Username')
    password    = fields.TextField('Password')
    host        = fields.TextField('Host', validators=[validators.InputRequired(), validators.IPAddress()])
    port        = fields.IntegerField('Port')
    fps         = fields.SelectField('FPS', coerce=int, validators=[validators.required()])
    image_size  = fields.SelectField('Image Size', validators=[validators.required()])
    camera_model= fields.SelectField('Camera Model', validators=[validators.required()])
    camera_man  = fields.SelectField('Camera manufactory', validators=[validators.required()])
    uri         = fields.TextField('URI')

class EditCameraForm(AddCameraForm):
    pass
    