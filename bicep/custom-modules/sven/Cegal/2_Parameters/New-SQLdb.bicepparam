/*
Command to list every SKU
az sql db list-editions -l swedencentral -o table

--New-AzResourceGroup -Name "xxx" -Location "swedencentral"
az deployment group create --resource-group "xxx" --parameters xxx.bicepparam 

az group delete --name xxx --yes -y 

Remove-AzResourceGroup -Name "xxx" -Force

2025-01-22 : The deployment AZ command need to be filed out when this template is copied.
2025-01-22 : Note that if using S for "sqlSKU" then it is Standard for sqlTier. If using GP_ for sqlSKU then it is GeneralPurpose for sqlTier
*/
using '../1_Modules/Set-SQLdb.bicep'

param location = 'swedencentral'  // Location for the Resource Group and all resources
param sqlServerName = ''//'shmTest'  // SQL Server name
param sqlDatabaseName  = ''//'shmdb'  // Database name
param sqlSKU =  'S0' //'S0', 'GP_Gen5_2'
param sqlTier = 'Standard' //'Standard', 'GeneralPurpose'

param tags = {
  owner: 'first.name@sqlservice.se'
}
