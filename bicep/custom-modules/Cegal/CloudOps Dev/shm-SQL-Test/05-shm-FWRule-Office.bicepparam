/*
--New-AzResourceGroup -Name "shm-SQL-Test" -Location "swedencentral"
az deployment group create --resource-group "shm-SQL-Test" --parameters 05-shm-FWRule-Office.bicepparam 

az group delete --name shm-SQL-Test --yes -y 

Remove-AzResourceGroup -Name "shm-SQL-Test" -Force
*/

using '../../1_Modules/New-sqlFirewallRule.bicep'

param sqlServerName = 'shmTest'  // SQL Server name
param firewallRuleName = 'Cegal Sthlm Office'  // Name of the firewall rule
param startdIpAddress = '94.254.38.0'  // The IP address to allow
param endIpAddress = '94.254.38.255'  // The IP address to allow
