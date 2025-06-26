# App Service Plan & SQL App Module

This Bicep module deploys a standard Azure web application stack, including:

- **App Service Plan** (`Microsoft.Web/serverfarms`)
- **App Service Web App** (`Microsoft.Web/sites`)
- **Azure SQL Server** (`Microsoft.Sql/servers`)
- **Azure SQL Database** (`Microsoft.Sql/servers/databases`)

All resources are deployed into an existing resource group. The module is parameterized for environment, solution name, instance count, SKUs, location, and SQL admin credentials.

---

## Parameters 

Parameter name              | Required | Description
--------------              | -------- | -----------
environmentName             | Yes      | The name of the environment. Allowed values: `nonprod`, `prod`.
solutionName                | Yes | The unique name of the solution. Used to ensure resource names are unique. Min 5, Max 30 characters.
appServicePlanInstanceCount | Yes | The number of App Service plan instances. Min 1, Max 10.
appServicePlanSku | Yes | Object with `name` and `tier` for the App Service plan SKU.
location | Yes | The Azure region for deployment.
sqlServerAdministratorLogin | Yes | The administrator login username for the SQL server. (Secure)
sqlServerAdministratorPassword | Yes | The administrator login password for the SQL server. (Secure)
sqlDatabaseSku | Yes | Object with `name` and `tier` for the SQL database SKU.

---

## Outputs

This module does not define explicit outputs, but you can extend it to output resource IDs or connection strings as needed.

---

## Parameters
- [Link to `managementGroupsScopeEscape.bicep` Parameters](generateddocs/managementGroupsScopeEscape.bicep.md)


## Bicep Visualizer

/*
1. Create the resource group (if not already created):
az group create --name <your-resource-group> --location <your-location>

2. Deploy the module:
az deployment group create \ 
  --name main \
  --resource-group <your-resource-group> \
  --template-file [appServicePlanApp.bicep]
  --parameters [appServicePlanApp.parameters.json]
  */

The SQL administrator password can be securely referenced from Azure Key Vault, as shown in the parameter file example.

All resource names are generated dynamically based on the environmentName and solutionName parameters.

The module is suitable for both development and production environments by adjusting the parameters.