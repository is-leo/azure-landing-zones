/*
  SYNOPSIS: Module for provisioning a Cosmos DB Account.
  DESCRIPTION: This module deploys an Azure Cosmos DB Account with configurable settings. Customize the parameters to fit your environment and workload requirements.
  VERSION: 1.0.0
  OWNER TEAM: Cegal CloudOps 
*/

param cosmosDBAccountName string 
                             
param location string = resourceGroup().location 

param cosmosDBDatabaseThroughput int 

param cosmosDBDatabaseName string

param cosmosDBContainerName string

param cosmosDBContainerPartitionKey string // ex. '/droneId'

var cosmosDBAccountNameUnique = toLower('${cosmosDBAccountName}-${uniqueString(resourceGroup().id)}')

resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2024-11-15' = {
  name: cosmosDBAccountNameUnique
  location: location
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
      }
    ]
  }
}

//Optional lock 
/*
resource lockResource 'Microsoft.Authorization/locks@2020-05-01' = {
  scope: cosmosDBAccount
  name: 'DontDelete'
  properties: {
    level: 'CanNotDelete'
    notes: 'Prevents deletion of the toy data Cosmos DB account.'
  }
}
*/

resource cosmosDBDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2024-11-15' = {
  parent: cosmosDBAccount
  name: cosmosDBDatabaseName
  properties: {
    resource: {
      id: cosmosDBDatabaseName
    }
    options: {
      throughput: cosmosDBDatabaseThroughput
    }
  }

  resource container 'containers' = {
  name: cosmosDBContainerName
  properties: {
    resource: {
      id: cosmosDBContainerName
      partitionKey: {
        kind: 'Hash'
        paths: [
          cosmosDBContainerPartitionKey
        ]
      }
    }
    options: {}
  }
 }
}
