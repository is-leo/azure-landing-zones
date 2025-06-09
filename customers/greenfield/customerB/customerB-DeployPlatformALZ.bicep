//# Wrapper for setinng up ALZ platform with some customer specific customization

targetScope = 'managementGroup'

param  parTargetManagementGroupId string
param  parAssigneeObjectId string 
param  parAssigneePrincipalType string 
param  parRoleDefinitionId string 
param  parPolicyAssignmentName string 
param  parPolicyAssignmentDisplayName string
param  parPolicyAssignmentDescription string
param  parPolicyAssignmentDefinitionId string 
param  parPolicyAssignmentParameters object = {} 
param  parPolicyAssignmentParameterOverrides object = {}
param  parPolicyAssignmentNonComplianceMessages array = []
param  parPolicyAssignmentNotScopes array = [] 
param  parPolicyAssignmentEnforcementMode string 
param  parPolicyAssignmentOverrides array = [] 
param  parPolicyAssignmentResourceSelectors array = [] 
param  parPolicyAssignmentDefinitionVersion string? 
param  parPolicyAssignmentIdentityType string = 'None' 
param  parPolicyAssignmentIdentityRoleAssignmentsAdditionalMgs array = []
param  parPolicyAssignmentIdentityRoleAssignmentsSubs array = []
param  parPolicyAssignmentIdentityRoleAssignmentsResourceGroups array = []
param  parPolicyAssignmentIdentityRoleDefinitionIds array = []
param  parTelemetryOptOut bool = false
param  loggingResourceGroupName string 
param  subscriptionId string

// Deploy ALZ
// Deploy Management Groups
module modTemplateALZPlatform '../../../bicep/orchestration/templateALZPlatform.bicep' = {
  name: 'modTemplateALZPlatform'
  params: {
    parTargetManagementGroupId: parTargetManagementGroupId
    parAssigneeObjectId: parAssigneeObjectId 
    parAssigneePrincipalType: parAssigneePrincipalType  
    parRoleDefinitionId: parRoleDefinitionId  
    parPolicyAssignmentName: parPolicyAssignmentName
    parPolicyAssignmentDisplayName: parPolicyAssignmentDisplayName
    parPolicyAssignmentDescription: parPolicyAssignmentDescription
    parPolicyAssignmentDefinitionId: parPolicyAssignmentDefinitionId
    parPolicyAssignmentParameters: parPolicyAssignmentParameters
    parPolicyAssignmentParameterOverrides: parPolicyAssignmentParameterOverrides
    parPolicyAssignmentNonComplianceMessages: parPolicyAssignmentNonComplianceMessages
    parPolicyAssignmentNotScopes: parPolicyAssignmentNotScopes
    parPolicyAssignmentEnforcementMode: parPolicyAssignmentEnforcementMode
    parPolicyAssignmentOverrides: parPolicyAssignmentOverrides
    parPolicyAssignmentResourceSelectors: parPolicyAssignmentResourceSelectors
    parPolicyAssignmentDefinitionVersion: parPolicyAssignmentDefinitionVersion
    parPolicyAssignmentIdentityType : parPolicyAssignmentIdentityType
    parPolicyAssignmentIdentityRoleAssignmentsAdditionalMgs: parPolicyAssignmentIdentityRoleAssignmentsAdditionalMgs
    parPolicyAssignmentIdentityRoleAssignmentsSubs: parPolicyAssignmentIdentityRoleAssignmentsSubs
    parPolicyAssignmentIdentityRoleAssignmentsResourceGroups: parPolicyAssignmentIdentityRoleAssignmentsResourceGroups
    parPolicyAssignmentIdentityRoleDefinitionIds: parPolicyAssignmentIdentityRoleDefinitionIds
    parTelemetryOptOut: parTelemetryOptOut
    loggingResourceGroupName: loggingResourceGroupName
    subscriptionId: subscriptionId
  }
}
