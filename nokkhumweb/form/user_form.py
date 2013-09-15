'''
Created on Jan 28, 2013

@author: boatkrap
'''
from wtforms import fields
from wtforms import validators

from . import AbstactForm

def validate_email(form, field):
    user = models.User.objects(email=form.data).first()
    
    if user is not None:
        raise validators.ValidationError(
            'This email: %s is available on system'% field.data)
    

class Register(AbstactForm):
    first_name      = fields.TextField('First name', validators=[validators.required()])
    last_name       = fields.TextField('Last name', validators=[validators.required()])
    
    email           = fields.TextField('Email', validators=[validators.required(), validators.Email(), validate_email])
    password        = fields.PasswordField('Password', validators=[validators.required(), validators.EqualTo('password_conf', message="password mismatch")])
    password_conf   = fields.PasswordField('Password Confirm', validators=[validators.required()])