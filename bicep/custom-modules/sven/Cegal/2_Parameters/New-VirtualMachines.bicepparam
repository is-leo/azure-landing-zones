/*
az deployment group create --resource-group "shm-VM-Module-Test" --name "SHM-VM-test-deploy_VM" --parameters 03_shm_New-VM01.bicepparam

az group delete --name shm-VM-Module-Test --yes -y 

Remove-AzResourceGroup -Name "shm-VM-Module-Test" -Force

Denna fråga listar vilka vmSize som är tillgängliga.
az vm list-skus --location swedencentral --size Standard  --output table
2025-01-28 : SH : First version, 

*/

using '../1_Modules/New-VirtualMachines.bicep'

param vmName = '' //'shm-vm01' The name of the VM.
param location = 'swedencentral'
param adminUsername = 'shmAdmin'
@secure()
param adminPassword = 'Qwert1234%'
param OSVersion = '2022-datacenter-azure-edition' //See all versions in the bicep file. New-VirtualMachines.bicep
param vmSize = 'Standard_D2ads_v5' //Standard_B2als_v2 'Standard_D2ads_v5'
param securityType = 'TrustedLaunch'
param nicName = '' //'vmNIC01' The name of the nic
param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
