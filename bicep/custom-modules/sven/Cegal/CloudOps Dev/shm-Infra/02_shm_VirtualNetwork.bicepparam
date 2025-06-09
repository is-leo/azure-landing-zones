/*
az deployment group create --resource-group "shm-Infra" --name "SHM-VM-test-deploy_VirtualNetwork" --parameters 02_shm_VirtualNetwork.bicepparam

az group delete --name shm-VM-Module-Test --yes -y 

Remove-AzResourceGroup -Name "shm-VM-Module-Test" -Force
*/

using '../../1_Modules/New-virtualNetwork.bicep'

param location = 'swedencentral'
param addressPrefix = '172.16.0.0/20'
param virtualNetworkName = 'shmVNET'

param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
