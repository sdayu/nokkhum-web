import os
import sys
import pymongo

from pyramid.paster import (
    get_appsettings,
    setup_logging,
    )

from .. import models

def usage(argv):
    cmd = os.path.basename(argv[0])
    print('usage: %s <config_uri>\n'
          '(example: "%s development.ini")' % (cmd, cmd)) 
    sys.exit(1)

def main(argv=sys.argv):
    if len(argv) != 2:
        usage(argv)
    config_uri = argv[1]
    setup_logging(config_uri)
    settings = get_appsettings(config_uri)

    models.initial(settings)
    
    from ..security import SecretManager
    secret_manager = SecretManager(settings.get('nokkhum.auth.secret'))
    
    db_host = settings['mongodb.host']
    conn = pymongo.Connection(db_host)

    default_groups = ['admin', 'user']
    
    print ("begin to initial database")
    
    for gname in default_groups:
        group = models.Group.objects(name=gname).first()
        if not group:
            group = models.Group()
            group.name = gname
            group.save()
        
    user = models.User.objects(email='admin@nokkhum.local').first()
    if not user:
        user = models.User()
        user.first_name = 'admin'
        user.last_name = ''
        user.password = secret_manager.getHashPassword('password')
        user.email = 'admin@nokkhum.com'
        user.group = models.Group.objects(name='admin').first()
        user.save()
        
    man_count = models.Manufactory.objects().count()
    if man_count == 0:
        man = models.Manufactory()
        man.name = 'Generic'
        man.save()
        
        camera_model = models.CameraModel()
        camera_model.name = 'OpenCV'
        camera_model.manufactory = man
        camera_model.save()
        
    processor_count = models.ImageProcessor.objects().count()
    if processor_count == 0:
        processor_name = ['Motion Detector', 'Face Detector', 
                     'Video Recorder', 'Image Recorder']
        
        for name in processor_name:
            pro = models.ImageProcessor()
            pro.name = name
            pro.save()
            
    print ("end initial database")