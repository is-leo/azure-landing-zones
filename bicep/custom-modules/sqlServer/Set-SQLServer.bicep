//2024-11-15 : SH : First version
/*
https://learn.microsoft.com/en-us/azure/templates/microsoft.sql/servers?pivots=deployment-language-bicep
*/
@description('Resource group name for the SQL Server.')
param location string   

@description('The name of the SQL Server to be created.')
param sqlServerName string   

@description('Tags to be applied to the SQL Server.')
param tags object 

@secure()
@description('The administrator login username for the SQL server.')
param sqlServerAdministratorLogin string 

@secure()
@description('The administrator login password for the SQL server.')
param sqlServerAdministratorPassword string  

// Resource: SQL Server (no scope needed, location explicitly set)
resource sqlServer 'Microsoft.Sql/servers@2024-05-01-preview' = {
  name: sqlServerName
  location: location  
  tags: tags  
  properties: {
    administratorLogin: sqlServerAdministratorLogin
    administratorLoginPassword: sqlServerAdministratorPassword
    version: '12.0'  // SQL Server version According to Chat GPT, this has been the version for a long time.
  }
}
