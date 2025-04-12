resource "azurerm_subnet" "app_integration" {
  name                 = "snet-app-integration-${var.location_object.short_name}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.vnet_address_space[0]]
  service_endpoints    = ["Microsoft.Storage.Global"] # Global means we can have cross region traffic

  delegation {
    name = "webapp"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }
}

resource "azurerm_network_security_group" "app_integration" {
  name                = "nsg-app-integration-${var.location_object.short_name}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet_network_security_group_association" "app_integration" {
  subnet_id                 = azurerm_subnet.app_integration.id
  network_security_group_id = azurerm_network_security_group.app_integration.id
}
