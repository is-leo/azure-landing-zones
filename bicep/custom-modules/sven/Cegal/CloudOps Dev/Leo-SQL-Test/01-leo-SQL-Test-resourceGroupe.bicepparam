/*
Template of create resourceGroupe

az deployment sub create --name "leo-Infra-deploy" --location swedencentral --parameters 01-leo-SQL-Test-resourceGroupe.bicepparam

az group delete --name "Leo-SQL-Test" --yes -y 
Remove-AzResourceGroup -Name "Leo-SQL-Test" -Force
*/

//using '../../#Modules/New-resourceGroupe.bicep'
//using './../../#Modules/New-resourceGroupe.bicep'
using '../../1_Modules/New-resourceGroupe.bicep'

param resourceGroupName = 'Leo-SQL-Test' //The name of the resource group ex 'shm-Infra'
param resourceGroupLocation = 'swedencentral' //The name of the datacenter location ex //'swedencentral'
param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
