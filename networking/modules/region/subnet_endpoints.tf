resource "azurerm_subnet" "endpoints" {
  name                 = "snet-endpoints-${var.location_object.short_name}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [local.endpoint_subnet_ranges[0]]
}

resource "azurerm_network_security_group" "endpoints" {
  name                = "nsg-endpoints-${var.location_object.short_name}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet_network_security_group_association" "endpoints" {
  subnet_id                 = azurerm_subnet.endpoints.id
  network_security_group_id = azurerm_network_security_group.endpoints.id
}