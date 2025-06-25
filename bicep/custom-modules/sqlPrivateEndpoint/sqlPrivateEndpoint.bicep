@description('The name of the virtual network resource group')
param virtualNetworkResourceGroup string

@description('The location for the resources')
param location string = resourceGroup().location

@description('The name of the Azure SQL Server')
param sqlServerName string

@description('The name of the subnet to place the private endpoint')
param subnetId string

@description('The name of the private endpoint')
param privateEndpointName string

@description('The name of the private DNS zone group')
param privateDnsZoneGroupName // Typically left as "default" unless managing multiple DNS configurations

@description('The private DNS zone ID for SQL Server')
param privateDnsZoneId string //replace with your subscription ID and resource group name

param tags object 

resource sqlPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-05-01' = {
  name: privateEndpointName
  location: location
  tags: tags 
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
  dependsOn: [
    sqlPrivateEndpoint // Ensure this resource is deployed after the private endpoint
  ]
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
}

output privateEndpointId string = sqlPrivateEndpoint.id
output privateDnsZoneGroupId string = privateDnsZoneGroup.id
