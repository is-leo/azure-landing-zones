/*
az deployment group create --resource-group "xxx" --name "xxxx-deploy_VirtualSubNetwork" --parameters xxxx.bicepparam

az group delete --name xxx --yes -y 

Remove-AzResourceGroup -Name "xxxx" -Force

2025-01-27 : SH : First version
                  networkSecurityGroupName är NSG gruppen som man vill koppla subnätet till.
                  vnetName är det virtuella nätverk som subnätet skall ingå i.

*/

using '../1_Modules/New-virtualSubnet.bicep'

param networkSecurityGroupName = ''//'shm-default-NSG'
param vnetName = ''//'shmVNET'
param subnetName = '' //'shm-Subnet01'
param subnetAddressPrefix = ''// '172.16.7.0/24'
