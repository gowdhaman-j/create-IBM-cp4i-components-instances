#!/bin/bash


# In case of dev environement License to set accept
export MY_license=accept

export MY_pullSecret=$PULL_SECRET_NAME

export MY_icp4iPlatformNamespace=integration


############ Let us find & Replace the $RELEASE_NAME-values.yaml

sed -i -e 's, MY_license, '$MY_license',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_pullSecret, '$MY_pullSecret',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_icp4iPlatformNamespace, '$MY_icp4iPlatformNamespace',g' $RELEASE_NAME-values.yaml




