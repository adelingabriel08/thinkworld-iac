data "azurerm_subnet" "app_integration" {
  name                 = "snet-app-integration-${var.network.location_short}"
  resource_group_name  = "rg-${var.network.suffix}"
  virtual_network_name = "vnet-${var.network.suffix}"
}

data "azurerm_cosmosdb_account" "pii" {
  name                = "cosno-${var.data_lifecycle_preffix}-pii-${var.network.location_short}"
  resource_group_name = "rg-${var.data_lifecycle_preffix}-pii-${var.network.location_short}"
}

data "azurerm_client_config" "current" {}