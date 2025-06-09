/*
az deployment group create --resource-group "shm-VM-Module-Test" --name "SHM-VM-test-deploy_storageAccount" --parameters 02_shm_storageAccount.bicepparam
az deployment group create --resource-group "shm-Infra" --name "SHM-VM-test-deploy_storageAccount" --parameters 02_shm_storageAccount.bicepparam

az group delete --name shm-VM-Module-Test --yes -y 

Remove-AzResourceGroup -Name "shm-VM-Module-Test" -Force
*/

using '../../1_Modules/New-storageAccount.bicep'

param location = 'swedencentral'
param storageAccountName = 'shmvmtest001'
param storageSku = 'Standard_LRS'
param kind = 'StorageV2'
param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
