'''
Created on Jun 21, 2012

@author: boatkrap
'''

from wtforms import fields
from wtforms import validators

from . import AbstactForm

class Project(AbstactForm):
    name        = fields.TextField('Name', validators=[validators.required()])
    description = fields.TextAreaField('Description')