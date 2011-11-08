from mongoengine import *
import datetime
from users import User

class CPUInfomation(EmbeddedDocument):
    count   = IntField(required=True, default=0)
    user        = FloatField(default=0)
    nice        = FloatField(default=0)
    system      = FloatField(default=0)
    idle        = FloatField(default=0)
    
class MemoryInfomation(EmbeddedDocument):
    total   = IntField(required=True, default=0)
    used    = IntField(default=0)
    free    = IntField(default=0)
    
class ComputeNode(Document):
    meta = {'collection': 'compute_node'}
    
    name    = StringField(max_length=100, required=True)
    system  = StringField(max_length=100, required=True)
    host    = StringField(max_length=100, required=True)
    machine = StringField(max_length=100, required=True)
    port    = IntField(required=True)
    cpu     = EmbeddedDocumentField("CPUInfomation", required=True)
    memory     = EmbeddedDocumentField("MemoryInfomation", required=True)
    
    create_date = DateTimeField(required=True, default=datetime.datetime.now())
    update_date = DateTimeField(required=True, default=datetime.datetime.now())


