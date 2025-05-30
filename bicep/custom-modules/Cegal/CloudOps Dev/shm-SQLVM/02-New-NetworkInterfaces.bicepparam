/*
az deployment group create --resource-group "shm-SQLVM" --name "Deploy-Of-SHMVMSQL-NetworkInterfaces" --parameters 02-New-NetworkInterfaces.bicepparam

az group delete --name shm-SQLVM --yes -y 

Remove-AzResourceGroup -Name "shm-SQLVM" -Force
*/

using '../../1_Modules/New-NetworkInterfaces.bicep'

param virtualNetworkName = 'shmVNET' //'shmVNET' The name of the network
param subnetName = 'shm-Subnet01' //'shm-Subnet01' The name of the subnet
param infraResourceGroup = 'shm-Infra' //'shm-Infra' The name of the resource group for the infra.
param location = 'swedencentral'
param nicName = 'vmSQLNIC01' //'vmNIC' The name of the Nic
param createPublicIP = true //true / false
param publicIPName = 'shmVMSQL-PublicNet01' //'shmVMSQL-PublicNet01' The name of the public IP (This has no effect if the NIC is private)
param publicIPSKU = 'Standard' //The SKU of the public IP (This has no effect if the NIC is private)
param publicIPAllocationMethod = 'Static' //The public network allocation (This has no effect if the NIC is private)
param privateIPAllocationMethod = 'Dynamic' //The private network allocation
param ipConfigName = 'ipconfig1' //'ipconfig1' The IP config name.

param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
