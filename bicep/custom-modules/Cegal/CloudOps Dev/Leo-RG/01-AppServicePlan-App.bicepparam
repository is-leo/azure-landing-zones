using '../1_Modules/New-AppServicePlan-App.bicep' /* Updated path: ensure this file exists at the specified location */

param appServicePlanSku = {
  name: 'F1'
  tier: 'Free'
}

param sqlDatabaseSku = {
  name: 'Standard'
  tier: 'Standard'
}

