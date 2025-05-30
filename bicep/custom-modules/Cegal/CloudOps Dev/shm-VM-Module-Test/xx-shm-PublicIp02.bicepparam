/*
az deployment group create --resource-group "shm-VM-Module-Test" --name "SHM-VM-test-deploy_PublicIp" --parameters 03-shm-PublicIp.bicepparam
az deployment group create --resource-group "shm-Infra" --name "SHM-VM-test-deploy_PublicIp02" --parameters 03-shm-PublicIp02.bicepparam

az group delete --name shm-VM-Module-Test --yes -y 

Remove-AzResourceGroup -Name "shm-VM-Module-Test" -Force
*/

using '../../1_Modules/New-PublicIp.bicep'

param publicIpName = 'shmPublicNet02'
param location = 'swedencentral'
param publicIPAllocationMethod = 'Dynamic'
param publicIpSku = 'Basic'
param vmName = 'shm-vm02'
param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
