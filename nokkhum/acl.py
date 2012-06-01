'''
Created on Nov 7, 2011

@author: boatkrap
'''
from pyramid.security import Allow
from pyramid.security import Everyone
from pyramid.security import Authenticated
from pyramid.security import ALL_PERMISSIONS


class RootFactory(object):

    @property
    def __acl__(self):
        # acls = [(Allow, 'u:%d' % o.id, 'view') for o in self.owners]
        acls = [(Allow, Authenticated, 'login'),
               (Allow, 'admin', ALL_PERMISSIONS) ]
        
        return acls

#    __acl__ = [(Allow, Authenticated, 'signin'),
#               (Allow, 'admin', ALL_PERMISSIONS) ]

    
    def __init__(self, request):
        pass