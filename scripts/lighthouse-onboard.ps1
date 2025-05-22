# PowerShell script for onboarding Azure Lighthouse

# This script facilitates the onboarding of Azure Lighthouse, allowing for the management of multiple Azure tenants.

param (
    [string]$TenantId,
    [string]$PrincipalId,
    [string]$RoleDefinitionId,
    [string]$ResourceId
)

function Onboard-AzureLighthouse {
    param (
        [string]$TenantId,
        [string]$PrincipalId,
        [string]$RoleDefinitionId,
        [string]$ResourceId
    )

    # Connect to the Azure account
    Connect-AzAccount -TenantId $TenantId

    # Define the role assignment
    $roleAssignment = New-AzRoleAssignment -ObjectId $PrincipalId -RoleDefinitionId $RoleDefinitionId -Scope $ResourceId

    if ($roleAssignment) {
        Write-Host "Successfully onboarded Azure Lighthouse for Tenant ID: $TenantId"
    } else {
        Write-Host "Failed to onboard Azure Lighthouse for Tenant ID: $TenantId"
    }
}

# Validate input parameters
if (-not $TenantId -or -not $PrincipalId -or -not $RoleDefinitionId -or -not $ResourceId) {
    Write-Host "All parameters (TenantId, PrincipalId, RoleDefinitionId, ResourceId) must be provided."
    exit 1
}

# Call the onboarding function
Onboard-AzureLighthouse -TenantId $TenantId -PrincipalId $PrincipalId -RoleDefinitionId $RoleDefinitionId -ResourceId $ResourceId