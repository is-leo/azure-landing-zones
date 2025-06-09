/*
az deployment group create --resource-group "shm-VM-Module-Test" --name "SHM-VM-test-deploy_defaultNSG" --parameters 03_shm_NSG.bicepparam
az deployment group create --resource-group "shm-Infra" --name "SHM-Infra-deploy_defaultNSG" --parameters 03_shm_NSG.bicepparam

az group delete --name shm-VM-Module-Test --yes -y 

Remove-AzResourceGroup -Name "shm-VM-Module-Test" -Force
*/

using '../../1_Modules/New-NetworkSecurityGroup.bicep'

param location = 'swedencentral'
param networkSecurityGroupName = 'shm-default-NSG'
param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
