/*
az deployment group create --resource-group "shm-VM-Module-Test" --name "SHM-VM-test-deploy_VirtualNetwork" --parameters 04_shm_VirtualSubNetwork_02.bicepparam
az deployment group create --resource-group "shm-Infra" --name "SHM-VM-test-deploy_VirtualSubNetwork_02" --parameters 05_shm_VirtualSubNetwork_02.bicepparam

az group delete --name shm-VM-Module-Test --yes -y 

Remove-AzResourceGroup -Name "shm-VM-Module-Test" -Force
*/

using '../../1_Modules/New-virtualSubnet.bicep'

param networkSecurityGroupName = 'shm-default-NSG'
param vnetName = 'shmVNET'
param subnetName = 'shm-Subnet02'
param subnetAddressPrefix = '172.16.8.0/24'
