data "azurerm_subnet" "endpoints" {
  name                 = "snet-endpoints-${var.network.location_short}"
  resource_group_name  = "rg-${var.network.suffix}"
  virtual_network_name = "vnet-${var.network.suffix}"
}

data "azurerm_resource_group" "main" {
  name = var.resource_group
}

data "azurerm_private_dns_zone" "cosmos" {
  name                = "privatelink.documents.azure.net"
  resource_group_name = data.azurerm_resource_group.main.name
}