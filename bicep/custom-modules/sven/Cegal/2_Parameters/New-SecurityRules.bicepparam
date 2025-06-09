/*
az deployment group create --resource-group "xxx" --name "xxx_defaultNSG" --parameters xxx.bicepparam

2025-01-27 : SH : First version.

*/

using '../1_Modules/New-SecurityRules.bicep'

param networkSecurityGroupName = '' //The name of the networkSecurityGroup
param SecurityRuleName = '' //The name of the rule ex 'shm-Rule001' 
param description = '' //Description of the rule.
param priority = 1000 //1000
param access = '' //'Allow'
param direction = '' //'Inbound'
param destinationPortRange = '' //'3389', '1433'
param protocol = '' //'Tcp', 'Udp'
param sourcePortRange = '' //*
param sourceAddressPrefix = '' //*
param destinationAddressPrefix = ''//*
