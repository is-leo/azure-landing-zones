/*
az deployment sub create --name "SHM-SQL-test-deploy" --location swedencentral --parameters 01-shm-SQL-Test.bicepparam

az group delete --name shm-SQL-Test --yes -y 

Remove-AzResourceGroup -Name "shm-SQL-Test" -Force
*/

using '../../1_Modules/New-resourceGroupe.bicep'

param resourceGroupName = 'shm-SQL-Test'
param resourceGroupLocation = 'swedencentral'
param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
