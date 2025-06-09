/*
az deployment sub create --name "SHM-VM-test-deploy" --location swedencentral --parameters 01_shm-VM-Module-Test.bicepparam

//--name "SHM-VM-test-deploy"

az group delete --name shm-VM-Module-Test --yes -y 

Remove-AzResourceGroup -Name "shm-VM-Module-Test" -Force
*/

using '../../1_Modules/New-resourceGroupe.bicep'

param resourceGroupName = 'shm-VM-Module-Test'
param resourceGroupLocation = 'swedencentral'
param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
