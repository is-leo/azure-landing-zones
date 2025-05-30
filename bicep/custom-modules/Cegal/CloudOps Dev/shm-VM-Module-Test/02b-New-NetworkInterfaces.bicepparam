/*
az deployment group create --resource-group "shm-VM-Module-Test" --name "Deploy-Of-vmNIC02-NetworkInterfaces" --parameters 02b-New-NetworkInterfaces.bicepparam

az group delete --name shm-VM-Module-Test --yes -y 

Remove-AzResourceGroup -Name "shm-VM-Module-Test" -Force
*/

using '../../1_Modules/New-NetworkInterfaces.bicep'

param virtualNetworkName = 'shmVNET' //'shmVNET' The name of the network
param subnetName = 'shm-Subnet02' //'shm-Subnet01' The name of the subnet
param infraResourceGroup = 'shm-Infra' //'shm-Infra' The name of the resource group for the infra.
param location = 'swedencentral'
param nicName = 'vmNIC02' //'vmNIC' The name of the Nic
param createPublicIP = true //true / false
param publicIPName = 'shmVM-PublicNet02' //'shmVMSQL-PublicNet01' The name of the public IP (This has no effect if the NIC is private)
param publicIPSKU = 'Standard' //The SKU of the public IP (This has no effect if the NIC is private)
param publicIPAllocationMethod = 'Static' //The public network allocation (This has no effect if the NIC is private)
param privateIPAllocationMethod = 'Dynamic' //The private network allocation
param ipConfigName = 'ipconfig1' //'ipconfig1' The IP config name.

param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
