@description('Specifies the name of the key vault.')
param keyVaultName string

@description('Specifies the Azure location where the key vault should be created.')
param location string = resourceGroup().location

@description('Tags to apply to the Key Vault.')
param tags object = {}

@description('Specifies whether purge protection is enabled for the vault. The setting is only effective if soft delete is also enabled. Enabling this feature cannot be undone.')
param enablePurgeProtection bool = true

@description('Specifies whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault.')
param enabledForDeployment bool = false

@description('Specifies whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unpack keys.')
param enabledForDiskEncryption bool = false

@description('Specifies whether Azure Resource Manager is permitted to retrieve secrets from the key vault.')
param enabledForTemplateDeployment bool = false

@description('Specifies whether the key vault should use role-based access control (RBAC) for authorization. If set to true, the vault uses RBAC; if false, it uses access policies.')
param enableRbacAuthorization bool = false

@description('Specifies the Azure Active Directory tenant ID that should be used for authenticating requests to the key vault.')
param tenantId string

@description('Specifies the object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies.')
param objectId string

@description('Specifies the permissions to keys in the vault.')
param keysPermissions array = []

@description('Specifies the permissions to secrets in the vault.')
param secretsPermissions array = []

@description('Specifies whether the key vault is a standard vault or a premium vault.')
@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'

@description('Network ACLs for the Key Vault.')
param networkAcls object = {
  bypass: 'None'
  defaultAction: 'Deny'
  ipRules: []
  virtualNetworkRules: []
}

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  tags: tags
  properties: {
    tenantId: tenantId
    enablePurgeProtection: enablePurgeProtection
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    enabledForDeployment: enabledForDeployment
    enabledForDiskEncryption: enabledForDiskEncryption
    enabledForTemplateDeployment: enabledForTemplateDeployment
    enableRbacAuthorization: enableRbacAuthorization
    sku: {
      family: 'A'
      name: skuName
    }
    accessPolicies: !enableRbacAuthorization ? [
      {
        tenantId: tenantId
        objectId: objectId
        permissions: {
          keys: keysPermissions
          secrets: secretsPermissions
        }
      }
    ] : []
    networkAcls: networkAcls
  }
}

output keyVaultName string = keyVault.name
output keyVaultResourceId string = keyVault.id
output keyVaultUri string = keyVault.properties.vaultUri
