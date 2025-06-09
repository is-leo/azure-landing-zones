//2024-11-24 : SH : First version
/*
https://learn.microsoft.com/en-us/azure/templates/microsoft.network/networksecuritygroups?pivots=deployment-language-bicep
*/

param networkSecurityGroupName string
param location string
param tags object

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2024-03-01' = {
  name: networkSecurityGroupName
  location: location
  tags: tags  // Apply the tags
  properties: {

  }
}
