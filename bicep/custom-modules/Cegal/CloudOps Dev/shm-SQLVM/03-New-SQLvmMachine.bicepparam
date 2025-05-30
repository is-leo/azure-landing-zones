/*

Get-AzVMSize -Location "swedencentral"

Get-AzVMImageOffer -Location "swedencentral" -PublisherName "MicrosoftSQLServer"

az deployment group create --resource-group "shm-SQLVM" --name "SHM-SQLVM-test-deploy_VM" --parameters 03-New-SQLvmMachine.bicepparam

*/

using '../../1_Modules/New-SQLvmMachine.bicep'

param vmName = 'shm-VMSQL01'
param location = 'swedencentral'
param vmSize = 'Standard_D2ads_v5'//'Standard_B2als_v2'
param adminUsername = 'shmAdmin'
@secure()
param adminPassword = 'Qwert1234%'
param SQLimage = 'sql2022-ws2022'
param sqlSku  = 'standard-gen2'
param nicName = 'vmSQLNIC01'

param storageWorkloadType = 'General'

param sqlDataDisksCount = 1
param sqlDataPath = 'F:\\SQLData'

param sqlLogDisksCount = 1
param sqlLogPath = 'G:\\SQLLog'

param securityType = 'TrustedLaunch'

param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
