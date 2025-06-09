/*
az deployment group create --resource-group "shm-SQLVM" --name "SHM-SQLVM-deploy_PublicIp" --parameters 02-New-PublicIp.bicepparam

az group delete --name shm-SQLVM --yes -y 

Remove-AzResourceGroup -Name "shm-SQLVM" -Force
*/

using '../../1_Modules/New-PublicIp.bicep'

param publicIpName = 'shmVMSQL-PublicNet01'// The name of the public IP'shmPublicNet01'
param location = 'swedencentral' // location'swedencentral'
param publicIPAllocationMethod = 'Dynamic' 
param publicIpSku = 'Basic'
param vmName = 'shm-SQLvm01'//'shm-vm01' The name of the virtual machine.
param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
