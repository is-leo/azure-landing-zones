/*
az deployment group create --resource-group "shm-VM-Module-Test" --name "SHM-VM-test-deploy_PublicIp" --parameters 03-shm-PublicIp.bicepparam
az deployment group create --resource-group "shm-Infra" --name "SHM-VM-test-deploy_PublicIp01" --parameters 03-shm-PublicIp01.bicepparam

az group delete --name shm-VM-Module-Test --yes -y 

Remove-AzResourceGroup -Name "shm-VM-Module-Test" -Force
*/

using '../1_Modules/New-PublicIp.bicep'

param publicIpName = ''// The name of the public IP'shmPublicNet01'
param location = '' // location'swedencentral'
param publicIPAllocationMethod = 'Dynamic' 
param publicIpSku = 'Basic'
param vmName = ''//'shm-vm01' The name of the virtual machine.
param tags = {
  owner: 'firstname.lastname@sqlservice.se'
}
