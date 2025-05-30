/*
Get-AzVMSize -Location "swedencentral"

Get-AzVMImageOffer -Location "swedencentral" -PublisherName "MicrosoftSQLServer"

az deployment group create --resource-group "xxxx" --name "xxxx" --parameters xxxx.bicepparam

2025-01-27 : SH : First version, not, I have only tested with one data and one log disk.

*/

using '../1_Modules/New-SQLvmMachine.bicep'

param vmName = '' //'shm-VMSQL01' The name of the VM
param location = 'swedencentral'
param vmSize = 'Standard_D2ads_v5'//'Standard_B2als_v2' The sice of the VM. See PowerShell script to get awalable VM sizes.
param adminUsername = '' //'shmAdmin' The local user name. (to do, get this in a KeyVault)
@secure()
param adminPassword = ''//'Qwert1234%' The password.
param SQLimage = 'sql2022-ws2022' //The Windows / SQL image. See PowerShell script to get alla image configurations.
param sqlSku  = 'standard-gen2' //The SKU of the SQL. See the allowe SKU:s in the bicep file: New-SQLvmMachine.bicep
param nicName = '' //The name of the Nic created.

param storageWorkloadType = 'General' //The storage.

param sqlDataDisksCount = 1 //Number of data disks.
param sqlDataPath = 'F:\\SQLData' //The path of data.

param sqlLogDisksCount = 1 //Number of Log disks
param sqlLogPath = 'G:\\SQLLog' //The path of the log disk.

param securityType = 'TrustedLaunch'

param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
