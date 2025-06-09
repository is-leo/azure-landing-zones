# .\UpdateOrCreateSqlFirewallRule.ps1 -resourceGroupName "SHM-PowerShell-Test" -sqlServerName "shmtest" -firewallRuleName "localOffice" -StartIpAddress "94.254.38.0" -EndIpAddress "94.254.38.255"
# Input Parameters
param(
    [string]$resourceGroupName,
    [string]$sqlServerName,
    [string]$firewallRuleName,
    [string]$StartIpAddress,
    [string]$EndIpAddress
)

# Validate Input Parameters
if (-not $resourceGroupName -or -not $sqlServerName -or -not $firewallRuleName -or -not $StartIpAddress -or -not $EndIpAddress) {
    Write-Host "All parameters (resourceGroupName, sqlServerName, firewallRuleName, StartIpAddress, EndIpAddress) are required.
    Usage: UpdateOrCreateSqlFirewallRule.ps1 -resourceGroupName ""Din resursgrupp"" -sqlServerName ""SQL Server namn"" -firewallRuleName ""FireWall rule name"" -StartIpAddress ""192.168.1.0"" -EndIpAddress ""192.168.1.255"" 
    .\UpdateOrCreateSqlFirewallRule.ps1 -resourceGroupName ""SHM-PowerShell-Test"" -sqlServerName ""shmtest"" -firewallRuleName ""localOffice"" -StartIpAddress ""94.254.38.0"" -EndIpAddress ""94.254.38.255""" -ForegroundColor Red
    exit 1
}

# Connect to Azure
Write-Host "Connecting to Azure..." -ForegroundColor Green
Connect-AzAccount -ErrorAction Stop

# Check if Firewall Rule Exists
Write-Host "Checking for firewall rule '$firewallRuleName' on SQL Server: $sqlServerName..." -ForegroundColor Green
$firewallRule = Get-AzSqlServerFirewallRule -ResourceGroupName $resourceGroupName -ServerName $sqlServerName -FirewallRuleName $firewallRuleName -ErrorAction SilentlyContinue

if ($firewallRule) {
    # Update Existing Firewall Rule
    Write-Host "Firewall rule '$firewallRuleName' exists. Updating with Start IP: $StartIpAddress and End IP: $EndIpAddress..." -ForegroundColor Yellow
    Set-AzSqlServerFirewallRule -ResourceGroupName $resourceGroupName -ServerName $sqlServerName -FirewallRuleName $firewallRuleName -StartIpAddress $StartIpAddress -EndIpAddress $EndIpAddress -ErrorAction Stop
    Write-Host "Firewall rule '$firewallRuleName' updated successfully!" -ForegroundColor Green
} else {
    # Create New Firewall Rule
    Write-Host "Firewall rule '$firewallRuleName' does not exist. Creating it with Start IP: $StartIpAddress and End IP: $EndIpAddress..." -ForegroundColor Yellow
    New-AzSqlServerFirewallRule -ResourceGroupName $resourceGroupName -ServerName $sqlServerName -FirewallRuleName $firewallRuleName -StartIpAddress $StartIpAddress -EndIpAddress $EndIpAddress -ErrorAction Stop
    Write-Host "Firewall rule '$firewallRuleName' created successfully!" -ForegroundColor Green
}
