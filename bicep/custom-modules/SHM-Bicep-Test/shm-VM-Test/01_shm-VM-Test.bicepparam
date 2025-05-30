/*
az deployment sub create --name "SHM-VM-test-deploy" --location swedencentral --parameters 01_shm-VM-Test.bicepparam

Remove-AzResourceGroup -Name "SHM-VM-Test" -Force
*/

using '../Modules/New-resourceGroupe.bicep'

param resourceGroupName = 'shm-VM-Test'
param resourceGroupLocation = 'swedencentral'
param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
