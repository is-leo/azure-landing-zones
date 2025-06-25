1. Az cli command:


2. Usage ex.

module lockCosmosDb 'custom-modules/lockResource/lockResource.bicep' = {
  name: 'lockCosmosDb'
  params: {
    resourceId: resourceId('Microsoft.DocumentDB/databaseAccounts', cosmosDBAccountName)
    lockName: 'DontDelete'
    lockLevel: 'CanNotDelete'
    lockNotes: 'Prevents deletion of the toy data Cosmos DB account.'
  }
}