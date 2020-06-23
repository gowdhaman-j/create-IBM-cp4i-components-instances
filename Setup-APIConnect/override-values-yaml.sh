#!/bin/bash


# For Dev env set this to false.
export MY_productionDeployment=false

#DO NOT need to change this value
export MY_registrySecret=$PULL_SECRET_NAME


export MY_storageClass="ibmc-block-gold"

# For development mode. The value is dev
export MY_mode="dev"

#DO NOT need to change this value
export MY_helmTlsSecret=$HELM_TLS_SECRET_NAME

# For Management Component

export MY_platformApiEndpoint=platform-api.$RELEASE_NAME.$OCP_CLUSTER_SUBDOMAIN
export MY_consumerApiEndpoint=consumer-api.$RELEASE_NAME.$OCP_CLUSTER_SUBDOMAIN
export MY_cloudAdminUiEndpoint=cloudadmin.$RELEASE_NAME.$OCP_CLUSTER_SUBDOMAIN
export MY_apiManagerUiEndpoint=apimanager.$RELEASE_NAME.$OCP_CLUSTER_SUBDOMAIN

# Considering the Dev environment setup. Set the value to 1.
export MY_cassandraClusterSize=1


# For Portal Component
export MY_portalDirectorEndpoint=portaldirector.$RELEASE_NAME.$OCP_CLUSTER_SUBDOMAIN
export MY_portalWebEndpoint=portal.$RELEASE_NAME.$OCP_CLUSTER_SUBDOMAIN

#For Analytics Component
export MY_analyticsIngestionEndpoint=analytics-ing.$RELEASE_NAME.$OCP_CLUSTER_SUBDOMAIN
export MY_analyticsClientEndpoint=analytics-clnt.$RELEASE_NAME.$OCP_CLUSTER_SUBDOMAIN

#For Gateway Component
export MY_apiGatewayEndpoint=api.$RELEASE_NAME.$OCP_CLUSTER_SUBDOMAIN
export MY_gatewayServiceEndpoint=gwsvc-mgmt.$RELEASE_NAME.$OCP_CLUSTER_SUBDOMAIN
export MY_gateway_replicaCount=1
export MY_gateway_highPerformancePeering=off

# If you have created an instance of "tracing" then 
#set MY_odTracing_enabled to true & 
# set MY_odTracing_odManagerNamespace to the namespace in which you have created the 'tracing' instance
export MY_odTracing_enabled=false
export MY_odTracing_odManagerNamespace=z-tracing

############ Let us find & Replace the $RELEASE_NAME-values.yaml



sed -i -e 's, MY_productionDeployment, '$MY_productionDeployment',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_registrySecret, '$MY_registrySecret',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_storageClass, '$MY_storageClass',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_mode, '$MY_mode',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_helmTlsSecret, '$MY_helmTlsSecret',g' $RELEASE_NAME-values.yaml


sed -i -e 's, MY_platformApiEndpoint, '$MY_platformApiEndpoint',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_consumerApiEndpoint, '$MY_consumerApiEndpoint',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_cloudAdminUiEndpoint, '$MY_cloudAdminUiEndpoint',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_apiManagerUiEndpoint, '$MY_apiManagerUiEndpoint',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_cassandraClusterSize, '$MY_cassandraClusterSize',g' $RELEASE_NAME-values.yaml

sed -i -e 's, MY_portalDirectorEndpoint, '$MY_portalDirectorEndpoint',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_portalWebEndpoint, '$MY_portalWebEndpoint',g' $RELEASE_NAME-values.yaml

sed -i -e 's, MY_analyticsIngestionEndpoint, '$MY_analyticsIngestionEndpoint',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_analyticsClientEndpoint, '$MY_analyticsClientEndpoint',g' $RELEASE_NAME-values.yaml

sed -i -e 's, MY_apiGatewayEndpoint, '$MY_apiGatewayEndpoint',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_gatewayServiceEndpoint, '$MY_gatewayServiceEndpoint',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_gateway_replicaCount, '$MY_gateway_replicaCount',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_gateway_highPerformancePeering, '$MY_gateway_highPerformancePeering',g' $RELEASE_NAME-values.yaml


sed -i -e 's, MY_odTracing_enabled, '$MY_odTracing_enabled',g' $RELEASE_NAME-values.yaml
sed -i -e 's, MY_odTracing_odManagerNamespace, '$MY_odTracing_odManagerNamespace',g' $RELEASE_NAME-values.yaml


