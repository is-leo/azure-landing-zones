/*

az deployment group create --resource-group "shm-Infra" --parameters 02-shmKeyVault.bicepparam 

az keyvault secret set --vault-name 'shmKeyVaultSWE' --name 'sqlAdminUsername' --value 'sqlAdminUser'
az keyvault secret set --vault-name 'shmKeyVaultSWE' --name sqlAdminPassword --value 'Qwerty1234%'

az keyvault list-deleted --subscription '9f5b58fe-04c4-472d-8ecd-f3634f9f7040'  --resource-type vault
az keyvault purge --subscription '9f5b58fe-04c4-472d-8ecd-f3634f9f7040' -n 'shmKeyVaultSWE'
*/

using '../../1_Modules/New-KeyVault.bicep'

param keyVaultName = 'shmKeyVaultSWE'
param objectId = '978b0249-6bad-4039-aa2e-f1081ac3f4a6' //Jag
param location = 'swedencentral'
param enabledForDeployment = false
param enabledForDiskEncryption = false
param enabledForTemplateDeployment = false
param tenantId = '9f5b58fe-04c4-472d-8ecd-f3634f9f7040' //Vår tenant
param keysPermissions = [
  'all'
]
param secretsPermissions = [
  'all'
]
param skuName = 'standard'
param tags = {
  owner: 'sven.hagstrom@sqlservice.se'
}
