provider "azurerm" {
    features {}

    subscription_id = "9f5b58fe-04c4-472d-8ecd-f3634f9f7040"

  }
  
  resource "azurerm_resource_group" "shm-TerraformTest" {
    name     = "shm-TerraformTest"
    tags = {
    owner = "sven.hagstrom@sqlservice.se"  # Provide the owner as required by policy
    }
    location = "Sweden Central"
  }
  