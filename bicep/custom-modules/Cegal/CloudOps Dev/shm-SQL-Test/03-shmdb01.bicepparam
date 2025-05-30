/*
--New-AzResourceGroup -Name "shm-SQL-Test" -Location "swedencentral"
az deployment group create --resource-group "shm-SQL-Test" --parameters 03-shmdb01.bicepparam 

az group delete --name shm-SQL-Test --yes -y 

Remove-AzResourceGroup -Name "shm-SQL-Test" -Force

*/
using '../../1_Modules/Set-SQLdb.bicep'

param location = 'swedencentral'  // Location for the Resource Group and all resources
param sqlServerName = 'shmTest'  // SQL Server name
param sqlDatabaseName  = 'shmdb01'  // Database name
param sqlSKU =  'S0' //'S0', 'GP_Gen5_2'
param sqlTier = 'Standard' //'Standard', 'GeneralPurpose'

param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
