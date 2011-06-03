from nokkhum.models import DBSession
#from nokkhum.models import MyModel

def my_view(request):
#    dbsession = DBSession()
#    root = dbsession.query(MyModel).filter(MyModel.name==u'root').first()
    return {'project':'Nokkhum'}
