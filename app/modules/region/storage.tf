resource "azurerm_storage_account" "functions_storage" {
  name                     = "st${var.storage_account_suffix}${var.network.location_short}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}