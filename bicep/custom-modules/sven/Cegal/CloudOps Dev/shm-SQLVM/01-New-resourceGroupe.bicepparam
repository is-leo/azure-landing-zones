/*
Template of create resourceGroupe

az deployment sub create --name "shm-SQLVM_Deploy" --location swedencentral --parameters 01-New-resourceGroupe.bicepparam

az group delete --name "shm-SQLVM" --yes -y 
Remove-AzResourceGroup -Name "shm-SQLVM" -Force

2025-01-22 : The deployment AZ command need to be filed out when this template is copied.

*/

//using '../../#Modules/New-resourceGroupe.bicep'
//using './../../#Modules/New-resourceGroupe.bicep'
using '../../1_Modules/New-resourceGroupe.bicep'

param resourceGroupName = 'shm-SQLVM' //The name of the resource group ex 'shm-Infra'
param resourceGroupLocation = 'swedencentral' //The name of the datacenter location ex //'swedencentral'
param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
