from wtforms import Form
from wtforms import fields
from wtforms import validators

from . import AbstactForm
from . import widgets

from nokkhumweb.forms import camera_form_validator as c_validators
from nokkhumweb.forms import image_processor_form_validators

class AddCameraForm(Form):
    name = fields.TextField('Name',
        validators=[validators.required(),
                    c_validators.valid_name,
                    c_validators.unique_camera_name],
        widget=widgets.MdlInput())
    username = fields.TextField('Username', widget=widgets.MdlInput())
    password = fields.TextField('Password', widget=widgets.MdlInput())
    host = fields.TextField('Host',
            validators=[validators.InputRequired(),
                        validators.IPAddress()],
            widget=widgets.MdlInput())
    port = fields.IntegerField('Port', widget=widgets.MdlInput())
    fps = fields.SelectField('FPS', coerce=int,
            validators=[validators.required()],
            )
    image_size = fields.SelectField('Image Size',
            validators=[validators.required()],
            )
    camera_model = fields.SelectField('Camera Model',
            validators=[validators.required()],
            )
    camera_man = fields.SelectField('Camera manufactory',
            validators=[validators.required()],
            )
    uri = fields.TextField('URI',
            widget=widgets.MdlInput())
    location = fields.TextField('Location',
            widget=widgets.MdlInput())

class EditCameraForm(AddCameraForm):
    pass

