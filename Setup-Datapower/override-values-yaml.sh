#!/bin/sh


# In case of dev environement License to set Nonproduction
export MY_license=Nonproduction

export MY_pullSecret=$PULL_SECRET_NAME

export MY_webGuiManagementState=enabled

export MY_gatewaySshState=enabled

export MY_restManagementState=enabled

export MY_xmlManagementState=enabled


############ Let us find & Replace the $RELEASE_NAME-values.yaml

sed -i -e 's, MY_license, '$MY_license',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_pullSecret, '$MY_pullSecret',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_webGuiManagementState, '$MY_webGuiManagementState',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_gatewaySshState, '$MY_gatewaySshState',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_restManagementState, '$MY_restManagementState',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_xmlManagementState, '$MY_xmlManagementState',g' $RELEASE_NAME-values.yaml



