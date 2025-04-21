data "azurerm_subnet" "app_integration" {
  name                 = "snet-app-integration-${var.network.location_short}"
  resource_group_name  = "rg-${var.network.suffix}"
  virtual_network_name = "vnet-${var.network.suffix}"
}