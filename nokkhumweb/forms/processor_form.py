'''
Created on Sep 14, 2013

@author: boatkrap
'''
from wtforms.form import Form
from wtforms import fields
from wtforms import validators
from wtforms.fields import html5

from nokkhumweb.forms import image_processor_form_validators

from . import widgets

class ProcessorForm(Form):
    name = fields.TextField('Name',
            validators=[validators.required()],
            widget=widgets.MdlInput())
    camera = fields.SelectField('Camera')
    storage_period = html5.IntegerField('Storage Period',
            widget=widgets.MdlInput())
    image_processors = fields.TextAreaField('Processors',
            validators=[validators.required(),
                image_processor_form_validators.image_processor],
            widget=widgets.MdlTextArea()
            )

class ImageProcessorForm(Form):
    processors = fields.TextAreaField('Processors',
            validators=[validators.required(),
                image_processor_form_validators.image_processor])
