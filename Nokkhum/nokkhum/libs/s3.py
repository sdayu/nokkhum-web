
import os, sys

import threading

import boto.s3.connection
import boto.s3.key

import logging
logger = logging.getLogger(__name__)

class S3Storage:
    def __init__(self, access_key_id, secret_access_key, host, port, secure=False, bucket_name=None):
        self.connection = boto.s3.connection.S3Connection(
                        aws_access_key_id=access_key_id,
                        aws_secret_access_key=secret_access_key,
                        port=port,
                        host=host,
                        is_secure=secure,
                        calling_format=boto.s3.connection.OrdinaryCallingFormat()
                    )
        
        self.bucket_name = None
        self.set_buckket_name(bucket_name)
        
    def set_buckket_name(self, name):
        if type(name) is int:
            self.bucket_name = str(name)
        elif type(name) is str:
            self.bucket_name = name
            
    def list_file(self, prefix=""):
        bucket = self.connection.get_bucket(self.bucket_name)
        results = []
            
        for key in bucket.list(prefix, delimiter="/"):
            if key.name[-1:] == '/':
                results.append(key.name[:-1])
            else:
                results.append(key.name)
                
        return results
    
    def get_file(self, key_name, file_name):
        bucket = self.connection.get_bucket(self.bucket_name)
    
        if bucket is None:
            return False
        
        key = bucket.get_key(key_name)
        if key is None:
            return False
        
        key.get_contents_to_filename(file_name)
        return True
        
    def delete(self, key_name):
        bucket = self.connection.get_bucket(self.bucket_name)
    
        if bucket is None:
            return False
        
        keys = bucket.get_all_keys(prefix=key_name)
#        print "keys: ", keys

        for key in keys:
            key.delete()

#        bucket.delete_keys(keys)
            
        return True