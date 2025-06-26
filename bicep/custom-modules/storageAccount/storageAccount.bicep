/*
2024-11-18 : SH : First version.

2025-01-22 : SH : Added documentation
Standard : Standard storage account type for blobs, file shares, queues, and tables. Recommended for most scenarios using Azure Storage
Premium : Premium storage account type for block blobs and append blobs. Recommended for scenarios with high transaction rates or that use smaller objects or require consistently low storage latency.
MS Doc: https://learn.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts?pivots=deployment-language-bicep
*/

param storageAccountName string

param location string = resourceGroup().location

param tags object 

@description('What Sku for the storage? Standard: Standard_LRS')
@allowed([
  'Standard_LRS' //Locally redundant storage (LRS)
  'Premium_LRS'
  'Standard_GRS' //geo-redundant storage (GRS) 
  'Standard_ZRS' //Zone-redundant storage (ZRS)
  'Premium_ZRS'
])

param storageSku string
@description('Storage kind: Standard : StorageV2')
@allowed([
  'BlobStorage'
  'BlockBlobStorage'
  'FileStorage'
  'Storage'         
  'StorageV2'
])

param kind string

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  tags: tags  // Apply the tags
  sku: {
    name: storageSku
  }
  kind: kind
}
