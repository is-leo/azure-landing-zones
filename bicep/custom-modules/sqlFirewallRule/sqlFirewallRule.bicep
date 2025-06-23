//2024-11-25 : SH : First Version
/*

https://learn.microsoft.com/en-us/azure/templates/microsoft.sql/servers/firewallrules?pivots=deployment-language-bicep
*/

param sqlServerName string // SQL Server name
param firewallRuleName string
param startIpAddress string
param endIpAddress string

// Reference the existing SQL Server
resource sqlServer 'Microsoft.Sql/servers@2023-05-01-preview' existing = {
  name: sqlServerName  // Specify the name of the existing SQL Server 
}


// Resource: SQL Server Firewall Rule
resource sqlFirewallRule 'Microsoft.Sql/servers/firewallRules@2023-05-01-preview' = {
  parent: sqlServer
  name: firewallRuleName
  properties: {
    startIpAddress: startIpAddress
    endIpAddress: endIpAddress  
  }
}
