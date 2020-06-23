#!/bin/bash

# This will help you to display the output of the script in an appropriate color based on Success & Faulure
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'


# Pls follow this link to get your account API Key
#https://cloud.ibm.com/docs/iam?topic=iam-manapikey
export IBMCLOUD_API_KEY=PROVIDE_YOUR_IBM_Cloud_API_Key

export CLOUD_ACCOUNT_ID=PROVIDE_YOUR_IBM_Cloud_Account_Id

export CLUSTER_NAME=PROVIDE_YOUR_OpenShift_Cluster_Name


# My target Cluster is xjskfkksksjsmsjsksks. But let us find it using the script
export CLUSTER_ID=''


Check_IBM_Cloud_Login(){
	CLOUD_ACCOUNT_ID=$1
	status=0

	echo  "$YELLOW START: *************************************************** IBM Cloud Login ***************************************************$NC \n"
		ibmcloud login \
		-apikey $IBMCLOUD_API_KEY \
		-c $CLOUD_ACCOUNT_ID 
		
			
		if [ $? -eq 0 ]; then
  			echo "$GREEN IBM Cloud login is successful!!!! $NC \n "
  			status=0
  		else
  			echo "$RED IBM Cloud login FAILED . $NC \n"	
  			status=1
		fi

	echo "$YELLOW END: *************************************************** IBM Cloud Login *************************************************** $NC \n\n\n"
	return $status
}


Get_Cluster_Id(){
	CLUSTER_NAME=$1
	status=0
	echo  "$YELLOW START: *************************************************** Fetch the OCP Cluster ID ***************************************************$NC \n"
	ibmcloud oc cluster ls | grep $CLUSTER_NAME | awk '{print$1}' 

	if [ $? -eq 0 ]; then
		echo "$GREEN Found the cluster $CLUSTER_NAME "
		
		CLUSTER_ID=`ibmcloud oc cluster ls | grep $CLUSTER_NAME | awk '{print$2}'`
		if [ -z "$CLUSTER_ID"  ]; then
			echo "EMPTY cluster ID cluster id is $CLUSTER_ID"
			status=1
		else
			echo " cluster ID is $CLUSTER_ID"
			eval `export CLUSTER_ID=$CLUSTER_ID`
			status=0
		fi		
		status=0

	else
		echo "$RED Cluster Id not Found for Cluster Name:$CLUSTER_NAME"
		status=1
	fi

	echo  "$YELLOW START: *************************************************** Fetch the OCP Cluster ID ***************************************************$NC \n"
	return $status

}

Set_Kube_Config(){
	CLUSTER_ID=$1
	status=0
	echo  "$YELLOW START: *************************************************** Set KUBECONFIG ***************************************************$NC \n"
	# The below on will download the KUBECONFIG
	
	ibmcloud oc cluster config -c $CLUSTER_ID 
	#This Command will provide you the export command to set
	KUBE_CONFIG=`ibmcloud oc cluster config -c $CLUSTER_ID  | grep KUBECONFIG`

	
	if [ $? -eq 0 ]; then
		echo "$GREEN KUBECONFIG found for the Cluster Id $CLUSTER_ID  "
		eval $KUBE_CONFIG
		status=0
	else
		status=1
	fi	
	echo  "$YELLOW START: *************************************************** Set KUBECONFIG ***************************************************$NC \n"
	return $status
}


Check_IBM_Cloud_Login $CLOUD_ACCOUNT_ID


if [ $status -eq 0 ]; then
	Get_Cluster_Id $CLUSTER_NAME
else
	exit 1
fi	


if [ $status -eq 0 ]; then
	Set_Kube_Config $CLUSTER_ID
else
	exit 1
fi	



