/*
--New-AzResourceGroup -Name "Leo-SQL-Test" -Location "swedencentral"
az deployment group create --resource-group "Leo-SQL-Test" --parameters 04-leo-SQLdb02.bicepparam 

az group delete --name Leo-SQL-Test --yes -y 

Remove-AzResourceGroup -Name "Leo-SQL-Test" -Force
*/
using '../../1_Modules/SQLdbTemplate.bicep'

param location = 'swedencentral'  // Location for the Resource Group and all resources
param sqlServerName = 'leoTest02'  // SQL Server name
param sqlDatabaseName  = 'leodb02'  // Database name
param sqlSKU =  'S0' //'S0', 'GP_Gen5_2'
param sqlTier = 'Standard' //'Standard', 'GeneralPurpose'

param tags = {
  owner: 'first.name@sqlservice.se'
}
