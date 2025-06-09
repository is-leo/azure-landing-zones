//2024-11-15 : SH : First version
/*
https://learn.microsoft.com/en-us/azure/templates/microsoft.sql/servers?pivots=deployment-language-bicep
*/

param location string   // Location for the Resource Group and all resources
param sqlServerName string   // SQL Server name
param tags object 
param sqlAdminUsername string   // Administrator username
@secure()
param sqlAdminPassword string  // Secure parameter for the admin password

// Resource: SQL Server (no scope needed, location explicitly set)
resource sqlServer 'Microsoft.Sql/servers@2024-05-01-preview' = {
  name: sqlServerName
  location: location  // Provide location directly
  tags: tags  // Apply the tags
  properties: {
    administratorLogin: sqlAdminUsername
    administratorLoginPassword: sqlAdminPassword
    version: '12.0'  // SQL Server version According to Chat GPT, this has been the version for a long time.
  }
}
