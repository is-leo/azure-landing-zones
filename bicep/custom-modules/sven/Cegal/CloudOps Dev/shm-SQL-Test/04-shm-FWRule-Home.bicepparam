/*
--New-AzResourceGroup -Name "shm-SQL-Test" -Location "swedencentral"
az deployment group create --resource-group "shm-SQL-Test" --parameters 04-shm-FWRule-Home.bicepparam 

az group delete --name shm-SQL-Test --yes -y 

Remove-AzResourceGroup -Name "shm-SQL-Test" -Force
*/

using '../../1_Modules/New-sqlFirewallRule.bicep'

param sqlServerName = 'shmTest'  // SQL Server name
param firewallRuleName = 'home'  // Name of the firewall rule
param startdIpAddress = '90.229.153.9'  // The IP address to allow
param endIpAddress = '90.229.153.9'  // The IP address to allow
