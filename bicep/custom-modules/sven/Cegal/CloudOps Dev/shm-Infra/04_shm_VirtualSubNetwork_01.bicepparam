/*
az deployment group create --resource-group "shm-VM-Module-Test" --name "SHM-VM-test-deploy_VirtualNetwork" --parameters 04_shm_VirtualSubNetwork_01.bicepparam
az deployment group create --resource-group "shm-Infra" --name "shm-Infra-deploy_VirtualSubNetwork_01" --parameters 04_shm_VirtualSubNetwork_01.bicepparam

az group delete --name shm-Infra --yes -y 

Remove-AzResourceGroup -Name "shm-Infra" -Force
*/

using '../../1_Modules/New-virtualSubnet.bicep'

param networkSecurityGroupName = 'shm-default-NSG'
param vnetName = 'shmVNET'
param subnetName = 'shm-Subnet01'
param subnetAddressPrefix = '172.16.7.0/24'

