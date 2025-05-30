/*
az deployment group create --resource-group "xxx" --name "xxx_defaultNSG" --parameters xxx.bicepparam

2025-01-27 : SH : First version.

*/

using '../1_Modules/New-NetworkSecurityGroup.bicep'

param location = ''//'swedencentral'
param networkSecurityGroupName = ''//'shm-default-NSG'
param tags = {
  owner: 'firstname.lastname@sqlservice.se'
}
