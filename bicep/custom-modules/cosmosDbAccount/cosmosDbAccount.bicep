param cosmosDBAccountName string 
var cosmosDBAccountNameUnique = toLower('${cosmosDBAccountName}-${uniqueString(resourceGroup().id)}')
                                
param location string = resourceGroup().location 

param cosmosDBDatabaseThroughput int 

param cosmosDBDatabaseName string

param cosmosDBContainerName string
param cosmosDBContainerPartitionKey string // ex. '/droneId'

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
