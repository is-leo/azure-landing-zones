param monitoringEnabled bool = true
param logAnalyticsWorkspaceId string
param logAnalyticsWorkspaceKey string

var monitoringConfig = {
  enabled: monitoringEnabled
  workspaceId: logAnalyticsWorkspaceId
  workspaceKey: logAnalyticsWorkspaceKey
}

resource monitoring 'Microsoft.Insights/monitoring' = if (monitoringEnabled) {
  name: 'monitoringResource'
  location: resourceGroup().location
  properties: monitoringConfig
}

output monitoringResourceId string = monitoring.id
output monitoringResourceName string = monitoring.name