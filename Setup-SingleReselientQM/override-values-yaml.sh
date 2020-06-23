#!/bin/bash

#accept the licesne
export MY_license=accept
#Set this as non production release
export MY_productionDeployment=false

export MY_pullSecret=$PULL_SECRET_NAME
#This icp-proxy name is set.
export MY_tls_hostname=$ICP_PROXY_HOSTNAME
# Name of the Storage Class name
export MY_dataPVC_storageClassName=ibmc-file-silver
# Name of the Storage Class name
export MY_logPVC_storageClassName=ibmc-file-silver
# Name of the Storage Class name
export MY_qmPVC_storageClassName=ibmc-file-silver
# Name of the Queue Manager you want to assign
export MY_queueManager_name=QM

# Tracing specific properties
#Disable the Tracing
export MY_odTracingConfig_enabled=false
# Namespace of the tracing component whete tracing release is running
export MY_odTracingNamespace=



############ Let us find & Replace the $RELEASE_NAME-values.yaml


sed -i -e 's, MY_pullSecret, '$MY_pullSecret',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_license, '$MY_license',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_productionDeployment, '$MY_productionDeployment',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_tls_hostname, '$MY_tls_hostname',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_dataPVC_storageClassName, '$MY_dataPVC_storageClassName',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_logPVC_storageClassName, '$MY_logPVC_storageClassName',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_qmPVC_storageClassName, '$MY_qmPVC_storageClassName',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_queueManager_name, '$MY_queueManager_name',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_odTracingConfig_enabled, '$MY_odTracingConfig_enabled',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_odTracingNamespace, '$MY_odTracingNamespace',g' $RELEASE_NAME-values.yaml

