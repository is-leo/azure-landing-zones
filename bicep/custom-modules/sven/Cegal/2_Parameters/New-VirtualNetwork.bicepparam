/*
az deployment group create --resource-group "xxx" --name "xxx" --parameters xxx.bicepparam

az group delete --name xxxx --yes -y 

Remove-AzResourceGroup -Name "xxx" -Force

2025-01-24 : SH : first version

*/

using '../1_Modules/New-virtualNetwork.bicep'

param location = 'swedencentral'
param addressPrefix = ''//You IP net ex '172.16.0.0/20'
param virtualNetworkName = '' //Your vNetName 'shmVNET'

param tags = {
  owner: 'firstname.lastname@sqlservice.se'
}
