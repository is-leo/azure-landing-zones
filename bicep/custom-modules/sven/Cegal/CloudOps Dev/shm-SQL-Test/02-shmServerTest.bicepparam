/*
--New-AzResourceGroup -Name "shm-SQL-Test" -Location "swedencentral"
az deployment group create --resource-group "shm-SQL-Test" --parameters 02-shmServerTest.bicepparam 

az group delete --name shm-SQL-Test --yes -y 

Remove-AzResourceGroup -Name "shm-SQL-Test" -Force
*/
using '../../1_Modules/Set-SQLServer.bicep'
//az.getSecret('<subscription-id>', '<rg-name>', '<key-vault-name>', '<secret-name>', '<secret-version>')
/*
var subscriptionId = '9f5b58fe-04c4-472d-8ecd-f3634f9f7040'
var rgName = 'shm-Infra'
var keyVaultName = 'shmKeyVaultSWE'
var secretName = 'sqlAdminUsername'
var secretVersion = 'sqlAdminPassword'
*/

param sqlAdminUsername  = 'sqlAdminUser' //az.getSecret(subscriptionId, rgName, keyVaultName, secretName, secretVersion) //'sqlAdminUser'  // Administrator username
param sqlAdminPassword = 'Qwerty1234%'  //az.getSecret(subscriptionId, rgName, keyVaultName, secretName, secretVersion) //'Qwerty1234%' 
param location = 'swedencentral'
param sqlServerName = 'shmTest'
param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
