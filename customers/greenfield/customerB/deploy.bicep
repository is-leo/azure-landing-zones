// Deploy ALZ
// Deploy Management Groups
module alz '../../../bicep/alz-main/infra-as-code/bicep/modules/managementGroups/managementGroups.bicep' = {
  name: 'alzMGDeployment'
  scope: tenant()
}

module policyDefinitions '../../../bicep/alz-main/infra-as-code/bicep/modules/policy/definitions/customPolicyDefinitions.bicep' = {
  name: 'policyDefinitionsDeployment'
  params: {
    parTargetManagementGroupId: 'alz'
    // Add other parameters as needed
  }
}

// Deploy Application Zone


// Deploy Custom Policies (optional)
