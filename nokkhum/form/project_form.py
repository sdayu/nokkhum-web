'''
Created on Jun 21, 2012

@author: boatkrap
'''

from wtforms.fields import *
from wtforms import validators

from . import AbstactForm

class Project(AbstactForm):
    name        = TextField(u'Name', validators=[validators.required()])
    description = TextAreaField(u'Description')