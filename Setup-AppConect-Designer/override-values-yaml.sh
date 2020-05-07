#!/bin/sh


# License to set
export MY_license=accept

#DO NOT need to change this value
export MY_global_replicaCount=1


export MY_pullSecret=$PULL_SECRET_NAME

# For development mode. Set the Storage class for couchDB
export MY_couchdb_storageClass=ibmc-block-gold


############ Let us find & Replace the $RELEASE_NAME-values.yaml

sed -i -e 's, MY_license, '$MY_license',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_global_replicaCount, '$MY_global_replicaCount',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_pullSecret, '$MY_pullSecret',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_couchdb_storageClass, '$MY_couchdb_storageClass',g' $RELEASE_NAME-values.yaml



