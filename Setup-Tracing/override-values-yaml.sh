#!/bin/bash



export MY_pullSecret=$PULL_SECRET_NAME

export MY_ingress_odUiHost=$ICP_PROXY_HOSTNAME

export MY_ingress_platformNavigatorHost=$CP4I_NAVIGATOR_HOSTNAME

export MY_configdb_storageClassName=ibmc-block-silver

export MY_elasticsearch_storageClassName=ibmc-block-silver



############ Let us find & Replace the $RELEASE_NAME-values.yaml


sed -i -e 's, MY_pullSecret, '$MY_pullSecret',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_ingress_odUiHost, '$MY_ingress_odUiHost',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_ingress_platformNavigatorHost, '$MY_ingress_platformNavigatorHost',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_configdb_storageClassName, '$MY_configdb_storageClassName',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_elasticsearch_storageClassName, '$MY_elasticsearch_storageClassName',g' $RELEASE_NAME-values.yaml




