
//# Wrapper for ALZ with some customization
param location string = 'East US'
param environment string = 'customerA'
param tags object = {}

var mainTemplate = 'bicep/alz-main/modules/main.bicep'

resource main 'Microsoft.Resources/deployments@2021-04-01' = {
  name: 'mainDeployment'
  properties: {
    mode: 'Incremental'
    templateLink: {
      uri: mainTemplate
      contentVersion: '1.0.0.0'
    }
    parameters: {
      location: location
      environment: environment
      tags: tags
    }
  }
}

output deploymentId string = main.id
output deploymentName string = main.name
