//2024-11-24 : SH : First version
/*

https://learn.microsoft.com/en-us/azure/templates/microsoft.network/networksecuritygroups/securityrules?pivots=deployment-language-bicep
*/

param networkSecurityGroupName string
param SecurityRuleName string
param description string
param priority int
param access string
param direction string
param destinationPortRange string
param protocol string
param sourcePortRange string
param sourceAddressPrefix string
param destinationAddressPrefix string

resource NSG 'Microsoft.Network/networkSecurityGroups@2024-05-01' existing = {
  name: networkSecurityGroupName
}

resource networkSecurityRules 'Microsoft.Network/networkSecurityGroups/securityRules@2024-05-01' = {
  parent: NSG
  name: SecurityRuleName //'shm-rule-xxx'
  properties: {
          description: description 
          priority: priority //1000
          access: access //'Allow'
          direction: direction //'Inbound'
          destinationPortRange: destinationPortRange //'3389'
          protocol: protocol //'Tcp'
          sourcePortRange: sourcePortRange //'*'
          sourceAddressPrefix: sourceAddressPrefix //'*'
          destinationAddressPrefix: destinationAddressPrefix // '*'
      }
}
