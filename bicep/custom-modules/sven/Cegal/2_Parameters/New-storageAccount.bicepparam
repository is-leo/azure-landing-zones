/*
Rename xxx to the files name:
az deployment group create --resource-group "xxx" --name "xxx-deploy_storageAccount" --parameters xxx.bicepparam
az deployment group create --resource-group "shm-Infra" --name "xxx-deploy_storageAccount" --parameters xxx.bicepparam

az group delete --name xxx --yes -y 

Remove-AzResourceGroup -Name "xxx" -Force
2025-01-22 : SH : Updated with new parameters.
*/

using '../1_Modules/New-storageAccount.bicep'

param location = 'swedencentral'
param storageAccountName = ''//'shmvmtest001'
param storageSku = 'Standard_LRS'//'Standard_LRS'
param kind = 'StorageV2' //'StorageV2'
param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
