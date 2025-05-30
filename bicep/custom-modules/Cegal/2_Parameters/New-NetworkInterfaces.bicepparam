/*
az deployment group create --resource-group "xxxx" --name "xxxx" --parameters xxxx.bicepparam

az group delete --name xxxx --yes -y 

Remove-AzResourceGroup -Name "xxxx" -Force
*/

using '../1_Modules/New-NetworkInterfaces.bicep'

param virtualNetworkName = '' //'shmVNET' The name of the network
param subnetName = '' //'shm-Subnet01' The name of the subnet
param infraResourceGroup = '' //'shm-Infra' The name of the resource group for the infra.
param location = 'swedencentral'
param nicName = '' //'vmNIC' The name of the Nic
param createPublicIP = false //true / false
param publicIPName = '' //'shmVMSQL-PublicNet01' The name of the public IP (This has no effect if the NIC is private)
param publicIPSKU = 'Standard' //The SKU of the public IP (This has no effect if the NIC is private)
param publicIPAllocationMethod = 'Static' //The public network allocation (This has no effect if the NIC is private)
param privateIPAllocationMethod = 'Dynamic' //The private network allocation
param ipConfigName = '' //'ipconfig1' The IP config name.

param tags = {
  owner: 'firstname.lastname@sqlservice.se'
}
