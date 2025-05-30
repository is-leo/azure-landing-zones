output "resource_group_name" {
  value = azurerm_resource_group.shm-TerraformTest.name
}

output "sql_server_name" {
  value = azurerm_mssql_server.sql_server.name
}

output "sql_database_name" {
  value = azurerm_mssql_database.sql_db.name
}
