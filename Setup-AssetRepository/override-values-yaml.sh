#!/bin/sh


# License to set
export MY_license=accept

export MY_pullSecret=$PULL_SECRET_NAME

export MY_helmTlsSecret=$HELM_TLS_SECRET_NAME

export MY_productionDeployment=false

#DO NOT need to change this value if it is for Dev env
export MY_global_replicaCount=1

# For development mode. Set the Storage class
export MY_storageClassName=ibmc-file-silver


############ Let us find & Replace the $RELEASE_NAME-values.yaml

sed -i -e 's, MY_license, '$MY_license',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_pullSecret, '$MY_pullSecret',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_helmTlsSecret, '$MY_helmTlsSecret',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_productionDeployment, '$MY_productionDeployment',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_global_replicaCount, '$MY_global_replicaCount',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_storageClassName, '$MY_storageClassName',g' $RELEASE_NAME-values.yaml



