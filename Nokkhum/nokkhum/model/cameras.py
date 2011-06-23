from mongoengine import *
import datetime
from users import User

class Camera(Document):
    meta = {'collection': 'cameras'}
    
    username = StringField(max_length=100, required=True)
    password = StringField()
    name = StringField(required=True)
    url = StringField(required=True)
    image_size = StringField(required=True)
    fps = IntField(required=True)
    status = StringField(required=True, default='Active')
    user =  ReferenceField(User)
    camera_model = ReferenceField('CameraModel')
    
    processors = DictField()
    
    create_date = DateTimeField(required=True, default=datetime.datetime.now())
    update_date = DateTimeField(required=True, default=datetime.datetime.now())
    
    ip_address = StringField(max_length=100, required=True, default='0.0.0.0')

class Manufactory(Document):
    meta = {'collection': 'camera_manufactories'}
    
    name = StringField(max_length=100, required=True)
    create_date = DateTimeField(required=True, default=datetime.datetime.now())
    
class CameraModel(Document):
    meta = {'collection': 'camera_models'}
    
    name = StringField(max_length=100, required=True)
    manufactory =  ReferenceField(Manufactory)
    create_date = DateTimeField(required=True, default=datetime.datetime.now())    
    