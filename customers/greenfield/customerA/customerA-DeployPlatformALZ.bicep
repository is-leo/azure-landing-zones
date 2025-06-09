//# Wrapper for plafrom ALZ with some customization

targetScope = 'managementGroup'
param parTargetManagementGroupId string  = 'customerA-mg' 

// Deploy ALZ
// Deploy Management Groups
module alz '../../../bicep/alz-main/infra-as-code/bicep/modules/managementGroups/managementGroups.bicep' = {
  name: 'alzMGDeployment'
  scope: tenant()
}

//Deploy Policy Definitions and Initiatives
module policyDefinitions '../../../bicep/alz-main/infra-as-code/bicep/modules/policy/definitions/customPolicyDefinitions.bicep' = {
  name: 'policyDefinitionsDeployment'
  scope: managementGroup(parTargetManagementGroupId)
   params: {
    parTargetManagementGroupId: parTargetManagementGroupId //passes the defined management group ID (customerA-mg) to the module
  }
}

// Deploy RBAC Role Definitions:Subscription owner,Application owners (DevOps/AppOps),Network management (NetOps),Security operations (SecOps))
module rbacRoleDefinitions '../../../bicep/alz-main/infra-as-code/bicep/modules/customRoleDefinitions/customRoleDefinitions.bicep' = {
  name: 'rbacRoleDefinitionsDeployment'
  scope: managementGroup(parTargetManagementGroupId)
  params: {
  
  }
}

// Deploy RBAC Role Assignments to user managed identity
//az identity show --resource-group CloudOpsMonitoringRG --name alertsManagedIdentity --query 'principalId'
module rbacRoleAssignments '../../../bicep/alz-main/infra-as-code/bicep/modules/roleAssignments/roleAssignmentManagementGroup.bicep' = {
  name: 'rbacRoleAssignmentsDeployment'
  scope: managementGroup(parTargetManagementGroupId)
  params: {
    parAssigneeObjectId: '666f51c4-93e0-4b9b-a484-69480f189a82' // UAMI: alertsManagedIdentity
    parAssigneePrincipalType: 'ServicePrincipal'
    parRoleDefinitionId: '/providers/Microsoft.Management/managementGroups/customerA-mg/providers/Microsoft.Authorization/roleDefinitions/acdd72a7-3385-48ef-bd42-f606fba81ae7' // Reader role
  }
}
                      
// Deploy Policy Assignments
module policyAssignments '../../../bicep/alz-main/infra-as-code/bicep/modules/policy/assignments/policyAssignmentManagementGroup.bicep' = {
  name: 'policyAssignmentsDeployment'
  scope: managementGroup(parTargetManagementGroupId)
  params: {
    parPolicyAssignmentName: 'A-policyAssignment'
    parPolicyAssignmentDisplayName: 'Customer A Policy Assignment'
    parPolicyAssignmentDescription: 'This is a policy assignment for Customer A.'
    parPolicyAssignmentDefinitionId: '/providers/Microsoft.Management/managementGroups/customerA-mg/providers/Microsoft.Authorization/policyDefinitions/your-policy-definition-id' //Set this to the full resource ID of the policy definition you want to assign.
    parPolicyAssignmentParameters: {} ////Values for parameters required by the policy/initiative (if any).
    parPolicyAssignmentParameterOverrides: {} //Overrides for policy parameters at assignment time.
    parPolicyAssignmentNonComplianceMessages: [] //Custom messages shown when resources are non-compliant.
    parPolicyAssignmentNotScopes: [] //Resource IDs to exclude from the assignment.
    parPolicyAssignmentEnforcementMode: 'Default' //Set to 'Default' (enforced) or 'DoNotEnforce' (audit only).
    parPolicyAssignmentOverrides: [] //Used to override policy effects or rules.
    parPolicyAssignmentResourceSelectors: [] //Advanced targeting for resources within the scope.
    parPolicyAssignmentDefinitionVersion: '' //Specifies a version of the policy definition to assign (optional).
  }
}


