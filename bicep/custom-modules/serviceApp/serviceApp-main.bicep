//set default subscription and resource group
az account set --subscription {your subscription ID}
az configure --defaults group="[sandbox resource group name]"

@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

@description('The name of the App Service app.')
param appServiceAppName string = 'cegal-${uniqueString(resourceGroup().id)}'

@description('The name of the App Service plan SKU.')
param appServicePlanSkuName string = 'F1'

@description('Indicates whether a CDN should be deployed.')
param deployCdn bool = true

var appServicePlanName = 'cegal-product-launch-plan'

module app'serviceApp-module.bicep' = {
  name: 'cegal-app'// Unique name for the deployment
  params: {
    location: location
    appServiceAppName: appServiceAppName
    appServicePlanName: appServicePlanName
    appServicePlanSkuName: appServicePlanSkuName
  }
}

module cdn '../CDN/cdnProfileEndpoint.bicep' = if (deployCdn) {
  name: 'cegal-app-cdn'
  params: {
    httpsOnly: true
    originHostName: app.outputs.appServiceAppHostName
  }
}

@description('The host name to use to access the website.')
output websiteHostName string = deployCdn ? cdn.outputs.endpointHostName : app.outputs.appServiceAppHostName

//when deployCdn is false, the websiteHostName will be the appServiceAppHostName
//output websiteHostName string = app.outputs.appServiceAppHostName 

