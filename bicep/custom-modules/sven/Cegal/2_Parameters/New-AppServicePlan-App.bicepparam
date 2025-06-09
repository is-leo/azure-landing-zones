using '../1_Modules/New-appServicePlan-App.bicep' /*TODO: Provide a path to a bicep template*/

param appServicePlanSku = {
  name: 'F1'
  tier: 'Free'
}

param sqlDatabaseSku = {
  name: 'Standard'
  tier: 'Standard'
}

