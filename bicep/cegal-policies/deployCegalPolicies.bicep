targetScope = 'managementGroup'

metadata name = 'Cegal - Managed and Maintenance Tag Policy Definitions at Management Group Scope'
metadata description = 'Automatically adds "cegal-managed" and "cegal-maintenance" tags to resources managed by Cegal'

@sys.description('The mnagement group scope to which the policy definitions are to be created at.')
param parTargetManagementGroupId string = 'alz'

@sys.description('Set Parameter to true to Opt-out of deployment telemetry')
param parTelemetryOptOut bool = false

var varTargetManagementGroupResourceId = tenantResourceId('Microsoft.Management/managementGroups', parTargetManagementGroupId)

// This variable contains a number of objects that load in the custom Azure Policy Defintions that are provided as part of the ESLZ/ALZ reference implementation - this is automatically created in the file 'infra-as-code\bicep\modules\policy\lib\policy_definitions\_policyDefinitionsBicepInput.txt' via a GitHub action, that runs on a daily schedule, and is then manually copied into this variable.
var varCustomPolicyDefinitionsArray = [
  {
		name: 'Cegal-Managed-Tag'
		libDefinition: loadJsonContent('bicep/cegal-policies/definitions/cegal_managed_tag.json')
	}
	{
		name: 'Append-AppService-latestTLS'
		libDefinition: loadJsonContent('lib/policy_definitions/policy_definition_es_Append-AppService-latestTLS.json')
	}
  ]
