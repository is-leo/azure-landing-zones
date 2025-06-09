/*
Template of create resourceGroupe

az deployment sub create --name "xxx" --location swedencentral --parameters xxx.bicepparam

az group delete --name "xxx" --yes -y 
Remove-AzResourceGroup -Name "xxx" -Force

2025-01-22 : The deployment AZ command need to be filed out when this template is copied.

*/

//using '../../#Modules/New-resourceGroupe.bicep'
//using './../../#Modules/New-resourceGroupe.bicep'
using '../../1_Modules/New-resourceGroupe.bicep'

param resourceGroupName = 'Leo-RG' //The name of the resource group ex 'shm-Infra'
param resourceGroupLocation = 'swedencentral' //The name of the datacenter location ex //'swedencentral'
param tags = {
  owner: 'first.last@sqlservice.se'
}
