//# Wrapper for plafrom ALZ with some customization

targetScope = 'managementGroup'

// METADATA
metadata name = 'ALZ Platform - Template'
metadata description = 'ALZ modules to set up paltform landing zone'


param parTargetManagementGroupId string
param parAssigneeObjectId string //- Managed Identities (System and User Assigned). Service Principals or Security Groups IDs
param parAssigneePrincipalType string // SertvicePrincipal or Group
param parRoleDefinitionId string //- Role Definition ID (e.g., Reader, Contributor, Owner, or custom roles)

//Plicy Assignment Parameters
param  parPolicyAssignmentName string 
param  parPolicyAssignmentDisplayName string
param  parPolicyAssignmentDescription string
param  parPolicyAssignmentDefinitionId string //Set this to the full resource ID of the policy or initiative definition you want to assign.
param  parPolicyAssignmentParameters object = {} ////Values for parameters required by the policy/initiative (if any).
param  parPolicyAssignmentParameterOverrides object = {} //Overrides for policy parameters at assignment time.
param  parPolicyAssignmentNonComplianceMessages array = []//Custom messages shown when resources are non-compliant.
param  parPolicyAssignmentNotScopes array = [] //Resource IDs to exclude from the assignment.
param  parPolicyAssignmentEnforcementMode string //Set to 'Default' (enforced) or 'DoNotEnforce' (audit only).
param  parPolicyAssignmentOverrides array = [] //Used to override policy effects or rules.
param  parPolicyAssignmentResourceSelectors array = [] //Advanced targeting for resources within the scope.
param  parPolicyAssignmentDefinitionVersion string? //? optional can be null or string ex: '1.0.0' or null

@description ('Most policy assignments do not require a managed identity unless the policy uses the deployIfNotExists or modify effect, which needs permissions to create or change resources.')
param  parPolicyAssignmentIdentityType string = 'None' // Set to 'None' or 'SystemAssigned' for managed identity 

@description('Array of additional management group IDs where the managed identity (created by the policy assignment) should be granted roles.')
param parPolicyAssignmentIdentityRoleAssignmentsAdditionalMgs array = []

@description('Array of subscription IDs where the managed identity should be granted roles.')
param parPolicyAssignmentIdentityRoleAssignmentsSubs array = []

@description('Array of resource group IDs (in the format subscriptionId/resourceGroupName) where the managed identity should be granted roles.')
param parPolicyAssignmentIdentityRoleAssignmentsResourceGroups array = []

@description('Array of RBAC role definition IDs (e.g., Contributor, Reader) to assign to the managed identity at the specified scopes above.')
param parPolicyAssignmentIdentityRoleDefinitionIds array = []

@description('Opt-out of telemetry.')
param parTelemetryOptOut bool = false

// Logging Parameters
param subscriptionId string 
param loggingResourceGroupName string
param loggingLocation string = 'swedencentral' // Default location for the Log Analytics Workspace
param logAnalyticsWorkspaceName string = 'alz-log-analytics'
param tags object = {}


// Deploy ALZ
// Deploy Management Groups
module modManagementGroups '../alz-main/infra-as-code/bicep/modules/managementGroups/managementGroups.bicep' = {
  name: 'modManagementGroupsDeployment'
  scope: tenant()
}

//Deploy Policy Definitions and Initiatives
module modPolicyDefinitions '../alz-main/infra-as-code/bicep/modules/policy/definitions/customPolicyDefinitions.bicep' = {
  name: 'modPolicyDefinitionsDeployment'
  scope: managementGroup(parTargetManagementGroupId)
   params: {
    parTargetManagementGroupId: parTargetManagementGroupId 
  }
}

// Deploy RBAC Role Definitions:Subscription owner,Application owners (DevOps/AppOps),Network management (NetOps),Security operations (SecOps))
module modRBACRoleDefinitions '../alz-main/infra-as-code/bicep/modules/customRoleDefinitions/customRoleDefinitions.bicep' = {
  name: 'modRBACRoleDefinitionsDeployment'
  scope: managementGroup(parTargetManagementGroupId)
  params: {
  
  }
}

// Deploy Logging and Security Module
module modLogging '../alz-main/infra-as-code/bicep/modules/logging/logging.bicep' = {
  name: 'modLogging'
  scope: resourceGroup(subscriptionId,loggingResourceGroupName)
  params: {
    parLogAnalyticsWorkspaceName: logAnalyticsWorkspaceName
    parLogAnalyticsWorkspaceLocation: loggingLocation
    parTags: tags
    // Add other parameters as needed, or use defaults
  }
}


// Deploy RBAC Role Assignments to user managed identity
//az identity show --resource-group CloudOpsMonitoringRG --name alertsManagedIdentity --query 'principalId'
module modRBACRoleAssignments '../alz-main/infra-as-code/bicep/modules/roleAssignments/roleAssignmentManagementGroup.bicep' = {
  name: 'modRBACRoleAssignmentsDeployment'
  scope: managementGroup(parTargetManagementGroupId)
  params: {
    parAssigneeObjectId: parAssigneeObjectId 
    parAssigneePrincipalType: parAssigneePrincipalType
    parRoleDefinitionId: parRoleDefinitionId
  }
}

// Deploy Subscription Placement Module
module modSubscriptionPlacement '../alz-main/infra-as-code/bicep/modules/subscriptionPlacement/subscriptionPlacement.bicep' ={
  name: 'modSubscriptionPlacementDeployment'
  scope: managementGroup(parTargetManagementGroupId)
  params: {
    parTargetManagementGroupId: parTargetManagementGroupId
    parSubscriptionIds: [subscriptionId] // Assuming you want to place the current subscription in the target management group
  }
}
                      
// Deploy Policy Assignments
module modPolicyAssignments '../alz-main/infra-as-code/bicep/modules/policy/assignments/policyAssignmentManagementGroup.bicep' = {
  name: 'modPolicyAssignmentsDeployment'
  scope: managementGroup(parTargetManagementGroupId)
  params: {
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
  }
}

