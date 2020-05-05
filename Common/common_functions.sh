#!/bin/sh

Check_OC_Login(){
	IBMCLOUD_API_KEY=$1
	status=0

	echo  "$YELLOW START: *************************************************** oc login Validation Check ***************************************************$NC \n"
		echo $IBMCLOUD_API_KEY
		oc login -u apikey -p $IBMCLOUD_API_KEY --insecure-skip-tls-verify=true

		if [ $? -eq 0 ]; then
				echo "$GREEN...oc login is successful!!!! $NC \n "
				status=0
			else
				echo "$RED The Provided API Key is an invalid . $NC \n"	
				status=1
		fi

	echo "$YELLOW END: *************************************************** oc login Validation Check *************************************************** $NC \n\n\n"
	return $status
}


#Check the namespace you indent to use exist or not
Check_NameSpace_existence(){
	NEW_NAMESPACE=$1
	status=0
	echo "$YELLOW START: *************************************************** New namesapce" $NEW_NAMESPACE " Existence Check *************************************************** $NC \n"
			echo "Checking whether the chosen namesapce already exist or not...."

			oc project $NEW_NAMESPACE
			if [ $? -eq 0 ]; then
					echo "$GREEN" $NEW_NAMESPACE  "already exist"
					status=0
				else
					echo "$YELLOW The name space " $NEW_NAMESPACE " does not exist"						
					status=1
			fi

	echo "$YELLOW END: *************************************************** New namesapce" $NEW_NAMESPACE " Existence Check *************************************************** $NC \n\n\n"

	return $status
}

#Create the namespace you indent
Create_NameSpace(){
	NEW_NAMESPACE=$1
	status=0
	echo "$YELLOW START: *************************************************** New namesapce" $NEW_NAMESPACE " Creation *************************************************** $NC \n"
	oc new-project $NEW_NAMESPACE
		if [ $? -eq 0 ]; then
				echo "$GREEN Successfully created the $NEW_NAMESPACE namespace!!!!!!"
				status=0
			else
				echo "$RED" $NEW_NAMESPACE + "namespace creation failed"	
				status=1
		fi

	echo "$YELLOW END: *************************************************** New namesapce" $NEW_NAMESPACE " Creation *************************************************** $NC \n\n\n"

	return $status
}

Set_SCC_for_Namespace(){
	NEW_NAMESPACE=$1
	SCC=$2
	status=0
	echo "$YELLOW START: *************************************************** Associating" $SCC "to " $NEW_NAMESPACE " *************************************************** $NC \n"
	oc adm policy add-scc-to-group $SCC system:serviceaccounts:$NEW_NAMESPACE
		if [ $? -eq 0 ]; then
				echo "$GREEN Successfully associated the $SCC with namespace $NEW_NAMESPACE !!!!!!"
				status=0
			else
				echo "$RED Failed associating" $SCC "with namespace" $NEW_NAMESPACE 
				status=1
		fi

	echo "$YELLOW END  : *************************************************** Associating" $SCC "to " $NEW_NAMESPACE "*************************************************** $NC \n\n\n"

	return $status
}

Create_PullSecret(){
	NEW_NAMESPACE=$1
	PULL_SECRET_NAME=$2
	status=0
	echo "$YELLOW START: *************************************************** Creating Pull Secret in " $NEW_NAMESPACE " *************************************************** $NC \n"
	oc -n $NEW_NAMESPACE delete secret $PULL_SECRET_NAME

	oc -n $NEW_NAMESPACE create secret docker-registry $PULL_SECRET_NAME \
		--docker-server=$DOCKER_SERVER \
		--docker-username=$DOCKER_USERNAME \
		--docker-password=$DOCKER_PASSWORD \
		--docker-email=gjayasee@in.ibm.com
		if [ $? -eq 0 ]; then
				echo "$GREEN Successfully created the pull secret" $PULL_SECRET_NAME "in namespace" $NEW_NAMESPACE "!!!!!!"
				status=0
			else
				echo "$RED Failed creating pull secret " $PULL_SECRET_NAME "in  namespace" $NEW_NAMESPACE 
				status=1
		fi

	echo "$YELLOW END: *************************************************** Creating Pull Secret in " $NEW_NAMESPACE " *************************************************** $NC \n\n\n"

	return $status
}

Execute_Cloudctl_Login(){
	NEW_NAMESPACE=$1
	ICP_CONSOLE_HOSTNAME=$2
	CP4Integration_USERNAME=$3
	CP4Integration_PASSWORD=$4

	status=0
	echo "$YELLOW START: ***************************************************             Execute Cloudctl login     *************************************************** $NC \n"
	cloudctl login \
		-a https://$ICP_CONSOLE_HOSTNAME \
		-u $CP4Integration_USERNAME \
		-p $CP4Integration_USERNAME \
		-n $NEW_NAMESPACE

		if [ $? -eq 0 ]; then
				echo "$GREEN Successfully logged in using cloudctl !!!!!! "
				status=0
			else
				echo "$RED Cloudctl login failed !!!!!! "
				status=1
		fi

	echo "$YELLOW END: ***************************************************             Execute Cloudctl login     *************************************************** $NC \n"

	return $status
}

Create_HELM_TLS_Secret(){
	NEW_NAMESPACE=$1
	HELM_TLS_SECRET_NAME=$2
	status=0
	echo "$YELLOW START: *************************************************** Creating HELM TLS Secret in " $NEW_NAMESPACE " *************************************************** $NC \n"
	oc -n $NEW_NAMESPACE delete secret $HELM_TLS_SECRET_NAME
	oc -n $NEW_NAMESPACE create secret generic $HELM_TLS_SECRET_NAME \
 		--from-file=cert.pem=$HOME/.helm/cert.pem \
 		--from-file=ca.pem=$HOME/.helm/ca.pem \
 		--from-file=key.pem=$HOME/.helm/key.pem
		if [ $? -eq 0 ]; then
				echo "$GREEN Successfully created the HELM TLS  secret" $HELM_TLS_SECRET_NAME "in namespace" $NEW_NAMESPACE "!!!!!!"
				status=0
			else
				echo "$RED Failed creating HELM TLS secret " $HELM_TLS_SECRET_NAME "in  namespace" $NEW_NAMESPACE 
				status=1
		fi

	echo "$YELLOW END: *************************************************** Creating HELM TLS Secret in " $NEW_NAMESPACE " *************************************************** $NC \n"

	return $status
}

Find_HELM_Release(){
	NEW_NAMESPACE=$1
	RELEASE_NAME=$2
	status=0
	echo "$YELLOW START: *************************************************** Finding Helm release named " $RELEASE_NAME " *************************************************** $NC \n"
	helm list --tls | grep  $RELEASE_NAME
		if [ $? == 0 ]; then
			echo "$RED Found the helm release named " $RELEASE_NAME "in namespace" $NEW_NAMESPACE "!!!!!!"
			status=0
		else	
			echo "$GREEN helm release named  " $RELEASE_NAME " NOT FOUND in namespace" $NEW_NAMESPACE "!!!!!!"
			status=1
		fi	

	echo "$YELLOW END: *************************************************** Finding Helm release named" $RELEASE_NAME "########################################### $NC \n\n\n"

	return $status
}

Create_Your_Release_Specific_Values(){
	status=0
	RELEASE_NAME=$1
	echo "$YELLOW START: *************************************************** Overide values.yaml for HELM release " $RELEASE_NAME " *************************************************** $NC \n"
		rm $RELEASE_NAME-values.yaml
		cp TEMPLATE-values.yaml $RELEASE_NAME-values.yaml
		./override-values-yaml.sh
		if [ $? == 0 ]; then
			echo "$GREEN $RELEASE_NAME-values.yaml is created"
			status=0
		else	
			echo "$RED Error while overriding the $RELEASE_NAME-values.yaml "
			status=1
		fi	

	echo "$YELLOW END: *************************************************** Overide values.yaml for HELM release " $RELEASE_NAME " *************************************************** $NC \n"	

}