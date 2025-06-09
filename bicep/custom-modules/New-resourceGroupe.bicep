/*
2024-11-15 : SH : First verison

https://learn.microsoft.com/en-us/azure/templates/microsoft.resources/resourcegroups?pivots=deployment-language-bicep
*/

targetScope = 'subscription'

param resourceGroupName string
param resourceGroupLocation string
param tags object

resource newRG 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
  tags: tags  // Apply the tags
}
