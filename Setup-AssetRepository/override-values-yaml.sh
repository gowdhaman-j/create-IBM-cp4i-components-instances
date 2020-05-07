#!/bin/sh



export MY_pullSecret=$PULL_SECRET_NAME
export MY_redis_ha_replica_servers=1
export MY_redis_ha_replica_sentinels=1
export MY_assetSync_storageClassName=ibmc-file-silver
export MY_assetSync_replicas=1
export MY_assetUI_replicas=1
export MY_couchdb_replicas=1
export MY_couchdb_storageClass=ibmc-block-silver


############ Let us find & Replace the $RELEASE_NAME-values.yaml

sed -i -e 's, MY_pullSecret, '$MY_pullSecret',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_redis_ha_replica_servers, '$MY_redis_ha_replica_servers',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_redis_ha_replica_sentinels, '$MY_redis_ha_replica_sentinels',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_assetSync_storageClassName, '$MY_assetSync_storageClassName',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_assetSync_replicas, '$MY_assetSync_replicas',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_assetUI_replicas, '$MY_assetUI_replicas',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_couchdb_replicas, '$MY_couchdb_replicas',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_couchdb_storageClass, '$MY_couchdb_storageClass',g' $RELEASE_NAME-values.yaml



