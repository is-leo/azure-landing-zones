/*
New-AzResourceGroup -Name "SHM-SQL-Test" -Location "swedencentral"
az deployment group create --resource-group "SHM-SQL-Test" --parameters shm-SQL-privateEndpoints-Test.bicepparam

Remove-AzResourceGroup -Name "SHM-SQL-Test" -Force
*/
using '../../1_Modules/SQLPrivateEndpoint.bicep'

param location = 'swedencentral'  // Location for the Resource Group and all resources
param sqlServerName = 'shmtest'  // SQL Server name
param sqlDatabaseName  = 'shmdb'  // Database name
param privateEndpointName = 'shm-sql-test-nic'
param subnetId = '/subscriptions/9f5b58fe-04c4-472d-8ecd-f3634f9f7040/resourceGroups/SHM-VM-Test/providers/Microsoft.Network/virtualNetworks/MyVNET/subnets/Subnet'
param virtualNetworkResourceGroup = 'SHM-SQL-Test'
param privateDnsZoneGroupName = 'PrivateDns-20241114150856'
param privateDnsZoneId = '/subscriptions/9f5b58fe-04c4-472d-8ecd-f3634f9f7040/resourceGroups/SHM-VM-Test/providers/Microsoft.Network/privateDnsZones/privatelink.database.windows.net'
param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
