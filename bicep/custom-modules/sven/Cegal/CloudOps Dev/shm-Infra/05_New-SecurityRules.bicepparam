/*
az deployment group create --resource-group "shm-Infra" --name "Deploy-SHM-Rule01" --parameters 05_New-SecurityRules.bicepparam

2025-01-27 : SH : First version.

*/

using '../../1_Modules/New-SecurityRules.bicep'

param networkSecurityGroupName = 'shm-default-NSG' //The name of the networkSecurityGroup
param SecurityRuleName = 'SHM-Rule01' //The name of the rule ex 'shm-Rule001' 
param description = 'SHM-Rule01 3389' //Description of the rule.
param priority = 1000 //1000
param access = 'Allow' //'Allow'
param direction = 'Inbound' //'Inbound'
param destinationPortRange = '3389' //'3389', '1433'
param protocol = 'Tcp' //'Tcp', 'Udp'
param sourcePortRange = '*' //*
param sourceAddressPrefix = '*' //*
param destinationAddressPrefix = '*'//*
