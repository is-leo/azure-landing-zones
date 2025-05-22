# PowerShell script to generate reports based on Azure resource deployments

# Define the output report file path
$outputReportPath = "C:\Reports\AzureDeploymentReport.csv"

# Function to generate the report
function Generate-AzureReport {
    param (
        [string]$subscriptionId
    )

    # Connect to Azure
    Connect-AzAccount

    # Select the subscription
    Select-AzSubscription -SubscriptionId $subscriptionId

    # Retrieve resource groups
    $resourceGroups = Get-AzResourceGroup

    # Initialize an array to hold report data
    $reportData = @()

    foreach ($rg in $resourceGroups) {
        # Retrieve resources in the resource group
        $resources = Get-AzResource -ResourceGroupName $rg.ResourceGroupName

        foreach ($resource in $resources) {
            # Create a custom object for the report
            $reportItem = [PSCustomObject]@{
                ResourceGroupName = $rg.ResourceGroupName
                ResourceName      = $resource.ResourceName
                ResourceType      = $resource.ResourceType
                Location          = $resource.Location
                ProvisioningState  = $resource.ProvisioningState
            }
            $reportData += $reportItem
        }
    }

    # Export the report data to a CSV file
    $reportData | Export-Csv -Path $outputReportPath -NoTypeInformation

    Write-Host "Report generated successfully at $outputReportPath"
}

# Call the function with the desired subscription ID
Generate-AzureReport -subscriptionId "your-subscription-id"