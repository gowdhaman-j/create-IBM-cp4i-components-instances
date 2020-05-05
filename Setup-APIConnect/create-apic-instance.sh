#!/bin/sh

# Ensure you login to IBM Cloud
source ../IBM-Cloud-Access-Details/ibm_cloud_login_using_api_key.sh


#Set the Some Common global Env 
source ../Common/setup_global_env.sh



# Name of the namespace you want to create an APIC instance.Avoid using OOB 'apic' namesapce.
export NEW_NAMESPACE=z-apic
# Required Security contet constraints to create APIC
export SCC=ibm-anyuid-hostpath-scc
# Provide a meaning fullname for your release
export RELEASE_NAME=my-apic-01

export CHART_FOLDER_NAME=ibm-apiconnect-icp4i-prod


#Set the Some Common functions
source ../common/common_functions.sh




if [ $? -eq 0 ]; then
	Check_OC_Login $IBMCLOUD_API_KEY
else
	exit 1
fi	


if [ $status -eq 0 ]; then
	Check_NameSpace_existence $NEW_NAMESPACE
else
	exit 1
fi	


if [ $status -eq 1 ]; then
	Create_NameSpace $NEW_NAMESPACE
fi	


if [ $status -eq 0 ]; then
	Set_SCC_for_Namespace $NEW_NAMESPACE $SCC
else
	exit 1
fi	


if [ $status -eq 0 ]; then
	Create_PullSecret $NEW_NAMESPACE $PULL_SECRET_NAME
else
	exit 1
fi	

if [ $status -eq 0 ]; then
	Execute_Cloudctl_Login $NEW_NAMESPACE $ICP_CONSOLE_HOSTNAME $CP4Integration_USERNAME $CP4Integration_PASSWORD
else
	exit 1
fi	


if [ $status -eq 0 ]; then
	Check_OC_Login $IBMCLOUD_API_KEY
else
	exit 1
fi	



if [ $status -eq 0 ]; then
	Create_HELM_TLS_Secret $NEW_NAMESPACE $HELM_TLS_SECRET_NAME
else
	exit 1
fi	


if [ $status -eq 0 ]; then
	Find_HELM_Release $NEW_NAMESPACE $RELEASE_NAME
else
	status=1
	exit 1
fi	

if [ $status -eq 0 ]; then
	echo "$RED Please Delete the Helm release by yourself before you proceed !!!!!! $NC \n\n\n"
	status=1
	exit 1
else
	 echo "$GREEN Let's go and create the Helm release !!!!!! $NC \n\n\n"
	 status=0
	 #exit 0
fi	

if [ $status -eq 0 ]; then
	Create_Your_Release_Specific_Values $RELEASE_NAME

else
	status=1
	exit 1
fi	



if [ $status -eq 0 ]; then
	echo " Preparing for creating helm release $RELEASE_NAME !!!!!! $NC \n\n\n"
	# Remove the temproty file created by sed
	rm $RELEASE_NAME-values.yaml-e
	ls $RELEASE_NAME-values.yaml

	if [ $? -eq 0 ]; then
		helm install --name $RELEASE_NAME -f $RELEASE_NAME-values.yaml ./$CHART_FOLDER_NAME/ --tls --debug  --dry-run &
		status=0
		exit 0
	else
		echo "$RED $RELEASE_NAME-values.yaml not found !!!!!! $NC \n\n\n"
		status=1
		exit 1
	fi
			
fi