/*
az deployment sub create --name "shm-Infra-deploy" --location swedencentral --parameters 01-shm-Infra.bicepparam

az group delete --name "shm-Infra" --yes -y 
Remove-AzResourceGroup -Name "shm-Infra" -Force
*/

//using '../../#Modules/New-resourceGroupe.bicep'
//using './../../#Modules/New-resourceGroupe.bicep'
using '../../1_Modules/New-resourceGroupe.bicep'

param resourceGroupName = 'shm-Infra'
param resourceGroupLocation = 'swedencentral'
param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
