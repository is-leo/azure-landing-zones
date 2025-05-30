targetScope = 'subscription'

param userManagedIdentityId = '/subscriptions/ad6a7a5f-5319-46b1-b9a9-514d4d29f75c/resourceGroups/CloudOpsMonitoringRG/providers/Microsoft.ManagedIdentity/userAssignedIdentities/alertsManagedIdentity'
param resourceGroupName = 'CloudOpsMonitoringRG'
param location = 'swedencentral'
param maintenancePolicyName = 'Cegal-Add-Maintenance-Tag'
param managedPolicyName = 'Cegal-Add-Managed-Tag'

// This variable contains a number of objects that load in the custom Azure Policy Defintions that are provided as part of the ESLZ/ALZ reference implementation - this is automatically created in the file 'infra-as-code\bicep\modules\policy\lib\policy_definitions\_policyDefinitionsBicepInput.txt' via a GitHub action, that runs on a daily schedule, and is then manually copied into this variable.
var varCustomPolicyDefinitionsArray = [
	{
		name: 'Cegal-Managed-Tag'
		libDefinition: loadJsonContent('definitions/cegal_managed_tag.json')
	}
	{
		name: 'Cegal-Maintenance-Tag'
		libDefinition: loadJsonContent('definitions/cegal_maintenance_tag.json')
	}
]

	// Loop to deploy policy definitions
resource resPolicyDefinitions 'Microsoft.Authorization/policyDefinitions@2025-01-01' = [
  for policy in varCustomPolicyDefinitionsArray: {
    name: policy.name
    properties: {
      displayName: policy.libDefinition.properties.displayName
      description: policy.libDefinition.properties.description
      metadata: policy.libDefinition.properties.metadata
      mode: policy.libDefinition.properties.mode
      policyType: policy.libDefinition.properties.policyType
      parameters: policy.libDefinition.properties.parameters
      policyRule: policy.libDefinition.properties.policyRule
    }
  }
]

// Output the IDs of the deployed policies
output maintenancePolicyId string = resPolicyDefinitions[0].id
output managedPolicyId string = resPolicyDefinitions[1].id

module policyAssignmentsModule 'assignCegalTags.bicep' = {
  name: 'policyAssignments'
  scope: resourceGroup(resourceGroupName)
  params: {
    managedPolicyName: managedPolicyName
    maintenancePolicyName: maintenancePolicyName
    managedPolicyId: resPolicyDefinitions[1].id
    maintenancePolicyId: resPolicyDefinitions[0].id
    location: location
    userManagedIdentityId: userManagedIdentityId
  }
}
