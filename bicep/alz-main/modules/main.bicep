param location string = resourceGroup().location
param environment string = 'production'
param tags object = {}

module monitoring './custom-modules/monitoring.bicep' = {
  name: 'monitoringModule'
  params: {
    location: location
    environment: environment
    tags: tags
  }
}

module ambaPolicies './custom-modules/ambaPolicies.bicep' = {
  name: 'ambaPoliciesModule'
  params: {
    environment: environment
    tags: tags
  }
}

// Additional modules can be added here as needed.