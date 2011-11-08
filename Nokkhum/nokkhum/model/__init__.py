from users import User, Group
from cameras import Camera, CameraModel, Manufactory
from image_processors import ImageProcessor
from compute_node import CPUInfomation, MemoryInfomation, ComputeNode

from mongoengine import connect

def initial(setting):
    connect(setting.get('mongodb.name'), host=setting.get('mongodb.url'))