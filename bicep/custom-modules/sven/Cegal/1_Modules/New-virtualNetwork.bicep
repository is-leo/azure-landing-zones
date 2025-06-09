/*
2024-11-24 : SH : First verison
2024-11-28 : SH : Did rework to just create the virtual network, subnets need to be created later.

2025-01-22 : SH : Added MS Docs
MS Doc : https://learn.microsoft.com/en-us/azure/templates/microsoft.network/virtualnetworks?pivots=deployment-language-bicep
*/
param virtualNetworkName string
@description('Location for all resources. ie : swedencentral')
param location string 
param addressPrefix string
param tags object 


resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: virtualNetworkName
  location: location
  tags: tags  // Apply the tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    //subnets: []
  }
}

/*
[
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
          networkSecurityGroup: {
            id: networkSecurityGroup.id
          }
        }
      }
    ]

*/
