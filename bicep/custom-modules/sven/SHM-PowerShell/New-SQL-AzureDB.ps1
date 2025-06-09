# Parameters
$location = "swedencentral"              # Location for the Resource Group and all resources
$sqlServerName = "shmtest"               # SQL Server name
$sqlDatabaseName = "shmdb"               # Database name
$sqlAdminUsername = "sqlAdminUser"       # Administrator username
$sqlAdminPassword = Read-Host -Prompt "Enter SQL Admin Password" -AsSecureString
$firewallRuleName = "localOffice"        # Name of the firewall rule
$allowedIpAddress = "90.229.153.9"       # The IP address to allow
$tags = @{
    owner = "sven.hagstrom@sqlservice.se"
}

# Login to Azure (if not already logged in)
Connect-AzAccount

# Resource group name
$resourceGroupName = "SHM-PowerShell-Test"

# Create Resource Group (if not exists)
if (-not (Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $resourceGroupName -Location $location
}

# Create SQL Server
$sqlServer = New-AzSqlServer `
    -ResourceGroupName $resourceGroupName `
    -ServerName $sqlServerName `
    -Location $location `
    -SqlAdministratorCredentials (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $sqlAdminUsername, $sqlAdminPassword) `
    -Tags $tags

# Create SQL Database
$sqlDatabase = New-AzSqlDatabase `
    -ResourceGroupName $resourceGroupName `
    -ServerName $sqlServerName `
    -DatabaseName $sqlDatabaseName `
    -Edition "Standard" `
    -RequestedServiceObjectiveName "S0" `
    -Collation "SQL_Latin1_General_CP1_CI_AS" `
    -Tags $tags

# Create SQL Server Firewall Rule
New-AzSqlServerFirewallRule `
    -ResourceGroupName $resourceGroupName `
    -ServerName $sqlServerName `
    -FirewallRuleName $firewallRuleName `
    -StartIpAddress $allowedIpAddress `
    -EndIpAddress $allowedIpAddress

Write-Host "SQL Server, Database, and Firewall Rule created successfully!" -ForegroundColor Green
