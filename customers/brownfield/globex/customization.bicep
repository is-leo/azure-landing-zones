param location string = resourceGroup().location
param environment string = 'Globex'
param customSetting string = 'default'

var resourceNamePrefix = 'globex'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: '${resourceNamePrefix}storage'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {}
}

output storageAccountId string = storageAccount.id

resource appService 'Microsoft.Web/sites@2021-02-01' = {
  name: '${resourceNamePrefix}appservice'
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: '${resourceNamePrefix}appserviceplan'
  location: location
  sku: {
    name: 'S1'
    tier: 'Standard'
    capacity: 1
  }
  properties: {}
}

output appServiceId string = appService.id

// Additional customization logic can be added here based on Globex requirements.