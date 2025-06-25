//param for tags
param resourceTags object = {
  EnvironmentName: 'Test'
  CostCenter: '1000100'
  Team: 'Human Resources'
}

//usage example
resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: appServicePlanName
  location: location
  tags: resourceTags

//location with a default value set to the location of the current resource group
param location string = resourceGroup().location

//param object for the app service plan name
param appServicePlanSku object = {
  name: 'F1'
  tier: 'Free'
  capacity: 1

//usage example
  resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSku.name
    tier: appServicePlanSku.tier
    capacity: appServicePlanSku.capacity
  }
}

// ARRAY
param cosmosDBAccountLocations array = [
  {
    locationName: 'australiaeast'
  }
  {
    locationName: 'southcentralus'
  }
  {
    locationName: 'westeurope'
  }
]

//Here's how a string parameter named appServicePlanSkuName can be restricted so that only a few specific values can be assigned:
@allowed([
  'P1v3'
  'P2v3'
  'P3v3'
])
param appServicePlanSkuName string


//Here's an example that declares a string parameter named storageAccountName, whose length can only be between 5 and 24 characters:
@minLength(5)
@maxLength(24)
param storageAccountName string

//The following example declares the integer parameter appServicePlanInstanceCount whose value can only be between 1 and 10 (inclusive):
@minValue(1)
@maxValue(10)
param appServicePlanInstanceCount int


//Bicep provides the @description decorator so that you can document your parameters' purpose in a human-readable way.
@description('The locations into which this Cosmos DB account should be configured. This parameter needs to be a list of objects, each of which has a locationName property.')
param cosmosDBAccountLocations array



//The uniqueString() function is useful for creating globally unique resource names. It returns a string that's the same on every deployment to the same resource group, but different when you deploy to different resource groups or subscriptions.
param solutionName string = 'toyhr${uniqueString(resourceGroup().id)}'


//Parameter values can be overridden by the user who executes the deployment, but the values of the variables can't be overridden.
var appServicePlanName = '${environmentName}-${solutionName}-plan'
var appServiceAppName = '${environmentName}-${solutionName}-app'


@description('The name of the environment. This must be dev, test, or prod.')
@allowed([
  'dev'
  'test'
  'prod'
])
param environmentName string = 'dev'


@description('The unique name of the solution. This is used to ensure that resource names are unique.')
@minLength(5)
@maxLength(30)
param solutionName string = 'toyhr${uniqueString(resourceGroup().id)}'


//The @secure decorator can be applied to string and object parameters that might contain secret values. 
//When you define a parameter as @secure, Azure won't make the parameter values available in the deployment logs. 
//Also, if you create the deployment interactively by using the Azure CLI or Azure PowerShell and you need to enter the values during the deployment, the terminal won't display the text on your screen.
@secure()
param sqlServerAdministratorLogin string

@secure()
param sqlServerAdministratorPassword string


//Make sure you don't create outputs for sensitive data. 
//Output values can be accessed by anyone who has access to the deployment history. 
//They're not appropriate for handling secrets.

//Avoid using parameters files for secrets, as they saved in git many people can access them.
//Instead, use Azure Key Vault to store secrets and reference them in your Bicep files.


//existing keyword: Tells Bicep this is not a new resource, but a reference to an already-deployed Key Vault.
resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: keyVaultName
}

//dynamically fetches the ApiKey secret from the referenced Key Vault.
module applicationModule 'application.bicep' = {
  name: 'application-module'
  params: {
    apiKey: keyVault.getSecret('ApiKey')
  }
}

//Define Child Resources
//Method 1: nested child resource

resource vm 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: vmName
  location: location
  properties: {
    // ...
  }

  resource installCustomScriptExtension 'extensions' = { //the nested resource automatically inherits the parent's resource type, so you need to specify only the child resource type, extensions.
    name: 'InstallCustomScript'
    location: location
    properties: {
      // ...
    }
  }
}

output childResourceId string = vm::installCustomScriptExtension.id

//Method 2: use the parent property to inform Bicep about the parent-child relationship
resource vm 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: vmName
  location: location
  properties: {
    // ...
  }
}

resource installCustomScriptExtension 'Microsoft.Compute/virtualMachines/extensions@2024-07-01' = {
  parent: vm //specify the parent resource
  name: 'InstallCustomScript'
  location: location
  properties: {
    // ...
  }
}

// Metod 3: depends on 
resource vm 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: vmName
  location: location
  properties: {
    // ...
  }
}

resource installCustomScriptExtension 'Microsoft.Compute/virtualMachines/extensions@2024-07-01' = {
  name: '${vmName}/InstallCustomScript'
  dependsOn: [
    vm
  ]
  //...
}


// refer to child resource
resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: 'toy-design-vnet'

  resource managementSubnet 'subnets' existing = {
    name: 'management'
  }
}

//You can then refer to the subnet by using the same :: operator that you use for other nested child resources:
output managementSubnetResourceId string = vnet::managementSubnet.id

//you can refer to a virtual network named toy-design-vnet in the networking-rg resource group:
resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  scope: resourceGroup('networking-rg')
  name: 'toy-design-vnet'
}

//You can also refer to a virtual network in a different subscription by using the subscription() function:
resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  scope: resourceGroup('aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e', 'networking-rg')
  name: 'toy-design-vnet'
}

//The following example template creates an Azure SQL database in a server that already exists:
resource server 'Microsoft.Sql/servers@2024-05-01-preview' existing = {
  name: serverName
}

resource database 'Microsoft.Sql/servers/databases@2024-05-01-preview' = {
  parent: server
  name: databaseName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}

/*It's a best practice to look up keys from other resources 
in this way instead of passing them around through outputs.
You'll always get the most up-to-date data. 
Also, it's important to note that outputs aren't designed 
to handle secure data like keys.*/

// The following example template deploys an Azure Functions application and uses the access details (instrumentation key) for an existing Application Insights instance:

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' existing = {
  name: applicationInsightsName
}

resource functionApp 'Microsoft.Web/sites@2024-04-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  properties: {
    siteConfig: {
      appSettings: [
        // ...
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: applicationInsights.properties.InstrumentationKey
        }
      ]
    }
  }
}

//When you need to access secure data, such as the credentials to use to access a resource, use the listKeys() function, as shown in the following code:
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
  name: storageAccountName
}

resource functionApp 'Microsoft.Web/sites@2024-04-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  properties: {
    siteConfig: {
      appSettings: [
        // ...
        {
          name: 'StorageAccountKey'
          value: storageAccount.listKeys().keys[0].value
        }
      ]
    }
  }
}

//CONDITIONS AND LOOPS

param deployStorageAccount bool
//deploys a storage account only when the deployStorageAccount parameter is set to true
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = if (deployStorageAccount) {
  name: 'teddybearstorage'
  location: resourceGroup().location
  kind: 'StorageV2'
  // ...
}

@allowed([
  'Development'
  'Production'
])
param environmentName string

resource auditingSettings 'Microsoft.Sql/servers/auditingSettings@2024-05-01-preview' = if (environmentName == 'Production') {
  parent: server
  name: 'default'
  properties: {
  }
}


//It's usually a good idea to create a variable for the expression that you're using as a condition. That way, your template is easier to understand and read
@allowed([
  'Development'
  'Production'
])
param environmentName string

var auditingEnabled = environmentName == 'Production'

resource auditingSettings 'Microsoft.Sql/servers/auditingSettings@2024-05-01-preview' = if (auditingEnabled) {
  parent: server
  name: 'default'
  properties: {
  }
}
