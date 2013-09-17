'''
Created on Sep 14, 2013

@author: boatkrap
'''
from wtforms import fields
from wtforms import validators
from wtforms.fields import html5

from nokkhumweb.forms import image_processor_form_validators

from . import AbstactForm

class ProcessorForm(AbstactForm):
    name = fields.TextField('Name', validators=[validators.required()])
    camera = fields.SelectField('Camera')
    storage_period = html5.IntegerField('Storage Period')
    image_processors = fields.TextAreaField('Processors', validators=[validators.required(), image_processor_form_validators.image_processor])
    
class ImageProcessorForm(AbstactForm):
    processors = fields.TextAreaField('Processors', validators=[validators.required(), image_processor_form_validators.image_processor])
