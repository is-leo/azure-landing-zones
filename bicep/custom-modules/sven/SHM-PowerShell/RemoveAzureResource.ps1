#.\RemoveAzureResource.ps1 -resourceGroupName "SHM-PowerShell-Test" -AzureResourceType "AzSqlDatabase" -AzureResourceName "shmdb"
#.\RemoveAzureResource.ps1 -resourceGroupName "SHM-PowerShell-Test" -AzureResourceType "AzSqlServer" -AzureResourceName "shmtest"
#.\RemoveAzureResource.ps1 -resourceGroupName "SHM-PowerShell-Test" -AzureResourceType "AzResourceGroup" -AzureResourceName "SHM-PowerShell-Test"
#.\RemoveAzureResource.ps1 -resourceGroupName "shm-Bicep-Test" -AzureResourceType "AzResourceGroup" -AzureResourceName "shm-Bicep-Test"
# Input parameters
param(
    [string]$ResourceGroupName,    
    [string]$AzureResourceType,
    [string]$AzureResourceName
)
# Validate Input Parameters
if (-not $resourceGroupName -or -not $AzureResourceType -or -not $AzureResourceName ) {
    Write-Host "All parameters (resourceGroupName, AzureResourceType, AzureResourceName) are required.
    Please use the following AzureResourceType 'AzSqlServer', 'AzSqlDatabase', or 'AzResourceGroup'
    Usage: RemoveAzureResource.ps1 -resourceGroupName ""Din resursgrupp"" 
    .\RemoveAzureResource.ps1 -resourceGroupName ""SHM-PowerShell-Test"" -AzureResourceType ""AzSqlDatabase"" -AzureResourceName ""shmdb"" " -ForegroundColor Red
    exit 1
}

# Ensure you are logged in to Azure
Write-Host "Checking Azure login status..."
if (!(Get-AzContext)) {
    Write-Host "Not logged into Azure. Logging in now..."
    Connect-AzAccount
}

# Validate the input and perform the appropriate action
switch ($AzureResourceType) {
    "AzSqlServer" {
        Write-Host "Removing Azure SQL Server: $AzureResourceName in Resource Group: $ResourceGroupName..."
        try {
            Remove-AzSqlServer -ResourceGroupName $ResourceGroupName -ServerName $AzureResourceName -Force
            Write-Host "Azure SQL Server removed successfully."
        } catch {
            Write-Error "Failed to remove Azure SQL Server. Error: $_"
        }
    }
    "AzSqlDatabase" {
        Write-Host "Removing Azure SQL Database: $AzureResourceName in Resource Group: $ResourceGroupName..."
        try {
        # Get all SQL Servers in the resource group
        $sqlServers = Get-AzSqlServer -ResourceGroupName $resourceGroupName

        # Iterate through each server to find the database
        foreach ($server in $sqlServers) {
        try {
            # Check if the database exists on this server
            $sqlDatabase = Get-AzSqlDatabase -ResourceGroupName $resourceGroupName -ServerName $server.ServerName -DatabaseName $AzureResourceName -ErrorAction Stop
            Write-Host "Database found! Server name: $($server.ServerName)"
            $serverName = $server.ServerName
            break
        } catch {
                # Ignore errors for servers that don't host the database
                Write-Error "Failed to remove Azure SQL Database. Error: $_"
                exit 1
            }
        }
            Write-Host "Removing:  $AzureResourceName"
            Remove-AzSqlDatabase -ResourceGroupName $ResourceGroupName -ServerName $serverName -DatabaseName $AzureResourceName -Force
            Write-Host "Azure SQL Database removed successfully."
        } catch {
            Write-Error "Failed to remove Azure SQL Database. Error: $_"
        }
    }
    "AzResourceGroup" {
        Write-Host "Removing Resource Group: $ResourceGroupName..."
        try {
            Remove-AzResourceGroup -Name $ResourceGroupName -Force -AsJob
            Write-Host "Resource Group removal initiated. This may take some time."
        } catch {
            Write-Error "Failed to remove Resource Group. Error: $_"
        }
    }
    Default {
        Write-Error "Invalid Azure Resource Type specified. Please use 'AzSqlServer', 'AzSqlDatabase', or 'AzResourceGroup'."
    }
}
