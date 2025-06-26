/*
2025-01-22 : SH : first version

https://learn.microsoft.com/en-us/azure/templates/microsoft.network/networkinterfaces
*/

@description('The name of the Virtual Network')
param virtualNetworkName string

@description('The name of the subnet in the virtual network')
param subnetName string

@description('The location for resources')
param location string = resourceGroup().location

@description('The name of the network interface (NIC)')
param nicName string

@description('Boolean to specify whether to create a public IP address for the NIC')
param createPublicIP bool

@description('Optional public IP name, if applicable')
param publicIPName string = '${nicName}-publicIP'

@description('Optional public IP SKU')
param publicIPSKU string 

@description('Optional public IP allocation method (Static or Dynamic)')
param publicIPAllocationMethod string 

@description('Private IP allocation method (Static or Dynamic)')
param privateIPAllocationMethod string 

@description('The ID of the Virtual Network')
param infraResourceGroup string

@description('The IP configuration name')
param ipConfigName string 

param tags object

resource nic 'Microsoft.Network/networkInterfaces@2021-08-01' = {
  name: nicName
  location: location
  tags: tags  // Apply the tags
  properties: {
    ipConfigurations: [
      {
        name: ipConfigName
        properties: {
          privateIPAllocationMethod: privateIPAllocationMethod
          subnet: {
            id: resourceId(infraResourceGroup, 'Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, subnetName)
          }
          publicIPAddress: createPublicIP ? {
            id: publicIP.id
          } : null
        }
      }
    ]
  }
}

resource publicIP 'Microsoft.Network/publicIPAddresses@2021-08-01' = if (createPublicIP) {
  name: publicIPName
  location: location
  properties: {
    publicIPAllocationMethod: publicIPAllocationMethod
  }
  sku: {
    name: publicIPSKU
  }
}
