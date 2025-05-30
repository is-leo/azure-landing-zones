/*
New-AzResourceGroup -Name "SHM-VM-Test" -Location "swedencentral"
az deployment group create --resource-group "SHM-VM-Test" --parameters shm-vm01.bicepparam 

Remove-AzResourceGroup -Name "SHM-VM-Test" -Force
*/
using '../Modules/vmMachineTemplate.bicep'

@description('Username for the Virtual Machine.')
param adminUsername = 'shmAdmin'

@description('Password for the Virtual Machine.')
@secure()
param adminPassword = 'Qwert1234%'
param publicIpName  = 'shmPublicNet'
param publicIPAllocationMethod = 'Dynamic'

param publicIpSku = 'Basic'

param OSVersion = '2022-datacenter-azure-edition'

@description('Size of the virtual machine.')
param vmSize  = 'Standard_D2s_v5'
param vmName = 'shm-vm01'

param securityType = 'TrustedLaunch'

param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}

param nicName = 'smhVMNic'
param addressPrefix = '10.0.0.0/16'
param subnetName = 'shm-Subnet'
param subnetPrefix = '10.0.8.0/24'
param virtualNetworkName = 'shmVNET'
param networkSecurityGroupName = 'shm-default-NSG'

@description('Commands to execute via Custom Script Extension.')
param customScriptCommands = '''
powershell -Command "& {
    if (-Not (Get-Command winget -ErrorAction SilentlyContinue)) {
      Install-PackageProvider -Name NuGet -Force | Out-Null;
      Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
      Repair-WinGetPackageManager -AllUsers
    }
    winget install --id Microsoft.SQLServerManagementStudio --silent --accept-package-agreements --accept-source-agreements;
}
"
'''
