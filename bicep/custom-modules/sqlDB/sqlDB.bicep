//2024-11-23 : SH : First version.
//az sql db list-editions -l swedencentral -o table

/*
https://learn.microsoft.com/en-us/azure/templates/microsoft.sql/servers/databases?pivots=deployment-language-bicep
*/

// Parameters for naming and access
param location string   // Set the same location as the SQL Server
param sqlServerName string   // SQL Server name
param sqlDatabaseName string   // Database name
param sqlSKU string //The SKU of the database.
param sqlTier string // The tier of the database, e.g., 'Standard', 'Premium', etc.
param tags object 


// Reference the existing SQL Server
resource sqlServer 'Microsoft.Sql/servers@2024-05-01-preview' existing = {
  name: sqlServerName  // Specify the name of the existing SQL Server 
}

// Resource: SQL Database (no scope needed, location explicitly set)
resource sqlDatabase 'Microsoft.Sql/servers/databases@2024-05-01-preview' = {
  parent: sqlServer
  name: sqlDatabaseName
  location: location  // Provide location directly
  tags: tags 
  sku: {
    name: sqlSKU  // S0 - S10  pricing tier
    tier: sqlTier // Standard
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'  // Collation (optional)
  }
}


