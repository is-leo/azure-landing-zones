param policyName string = 'defaultPolicy'
param policyDescription string = 'This policy enforces management and billing standards for Azure resources.'

var policyDefinition = {
  "if": {
    "allOf": [
      {
        "field": "type",
        "equals": "Microsoft.Resources/subscriptions/resourceGroups"
      },
      {
        "field": "tags['Environment']",
        "notEquals": "Production"
      }
    ]
  },
  "then": {
    "effect": "deny"
  }
}

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    displayName: policyName
    policyType: 'Custom'
    mode: 'All'
    description: policyDescription
    policyRule: policyDefinition
  }
}

output policyId string = policy.id
output policyName string = policy.name