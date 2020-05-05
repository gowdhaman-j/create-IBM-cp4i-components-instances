#!/bin/sh

# OpenShift Cluster Server URL.
export OC_SERVER=PROVIDE_YOUR_OpenShift_Cluster_API_Server_URL

# sub-domain of your OCP cluster
export OCP_CLUSTER_SUBDOMAIN=PROVIDE_YOUR_OpenShift_Cluster_SubDomain

#ICP Console Hostname
export ICP_CONSOLE_HOSTNAME=icp-console.$OCP_CLUSTER_SUBDOMAIN

#ICP Proxy Hostname
export ICP_PROXY_HOSTNAME=icp-proxy.$OCP_CLUSTER_SUBDOMAIN

#CP4I Navigator Hostname
export CP4I_NAVIGATOR_HOSTNAME=ibm-icp4i-prod-integration.$OCP_CLUSTER_SUBDOMAIN


#Image Pull Secret to be used in all helm releases
export PULL_SECRET_NAME=ibm-entitlement-key

#HELM TLS Secret. This is required for APIConnect & ACEDashBoard. 
export HELM_TLS_SECRET_NAME=helm-tls-secret


# CP4Integration Platform Username.
export CP4Integration_USERNAME=admin

# CP4Integration Platform Passw0rd. The one you have provided during the installation of CP4Integration
export CP4Integration_PASSWORD=PROVIDE_YOUR_CP4I_Navigator_Password

#The IBM Entitled Registry contains images for the Platform Navigator, Asset Repository and all of the component 
# capabilities in IBM Cloud Pak for Integration. To use the IBM Entitled Registry, you must first obtain an Entitlement key. Take the following steps.
#   Obtain an Entitlement key from https://myibm.ibm.com/products-services/containerlibrary (IBM Container Library). Click Get an entitlement key if you are not on the entitlement page.
#    Click IBM Cloud Pak for Integration.
#    Copy the entitlement key presented to a safe place for use later.

# Set entitlement key as Docker password
export DOCKER_PASSWORD=PROVIDE_YOUR_Entitlement_Key

#No need to chenge the Docker username 
export DOCKER_USERNAME=cp

# No need to change the Docker Server
export DOCKER_SERVER=cp.icr.io



