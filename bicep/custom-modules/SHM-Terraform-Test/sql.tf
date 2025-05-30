resource "azurerm_mssql_server" "sql_server" {
  name                         = "shmterratest"
  resource_group_name          = azurerm_resource_group.shm-TerraformTest.name
  location                     = azurerm_resource_group.shm-TerraformTest.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "Password1234!"

    tags = {
    owner = "sven.hagstrom@sqlservice.se"  # Provide the owner as required by policy
  }
}

resource "azurerm_mssql_database" "sql_db" {
  name                = "shm-Test"
  server_id           = azurerm_mssql_server.sql_server.id
  sku_name            = "S0"
  tags = {
    owner = "sven.hagstrom@sqlservice.se"  # Provide the owner as required by policy
  }
}
