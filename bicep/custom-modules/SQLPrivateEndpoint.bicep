@description('The name of the resource group containing the VM and SQL Server')
param virtualNetworkResourceGroup string

@description('The location for the resources')
param location string

@description('The name of the Azure SQL Server')
param sqlServerName string

@description('The name of the Azure SQL Database')
param sqlDatabaseName string

@description('The name of the subnet to place the private endpoint')
param subnetId string

@description('The name of the private endpoint')
param privateEndpointName string

@description('The name of the private DNS zone group')
param privateDnsZoneGroupName string = 'default'

@description('The private DNS zone ID for SQL Server')
param privateDnsZoneId string

param tags object 

resource sqlPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-05-01' = {
  name: privateEndpointName
  location: location
  tags: tags  // Apply the tags
  properties: {
    subnet: {
      id: subnetId
    }
    privateLinkServiceConnections: [
      {
        name: '${sqlServerName}-connection'
        properties: {
          privateLinkServiceId: resourceId(virtualNetworkResourceGroup, 'Microsoft.Sql/servers', sqlServerName)
          groupIds: [
            'sqlServer'
          ]
        }
      }
    ]
  }
}

resource privateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-05-01' = {
  name: '${sqlPrivateEndpoint.name}/${privateDnsZoneGroupName}' // Correctly formatted nested name
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'sqlDnsZoneConfig'
        properties: {
          privateDnsZoneId: privateDnsZoneId
        }
      }
    ]
  }
  dependsOn: [
    sqlPrivateEndpoint // Ensure this resource is deployed after the private endpoint
  ]
}

output privateEndpointId string = sqlPrivateEndpoint.id
output privateDnsZoneGroupId string = privateDnsZoneGroup.id
