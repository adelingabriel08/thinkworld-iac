data "azurerm_subnet" "endpoints" {
  name                 = "snet-endpoints-${var.network.location_short}"
  resource_group_name  = "rg-${var.network.suffix}"
  virtual_network_name = "vnet-${var.network.suffix}"
}

data "azurerm_subnet" "replication_region" {
  for_each = var.replication_networks

  name                 = "snet-endpoints-${each.value.location_short}"
  resource_group_name  = "rg-${each.value.suffix}"
  virtual_network_name = "vnet-${each.value.suffix}"
}

data "azurerm_resource_group" "main" {
  name = var.resource_group
}

data "azurerm_resource_group" "dns_zone_resource_group" {
  name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "cosmos" {
  name                = "privatelink.documents.azure.net"
  resource_group_name = data.azurerm_resource_group.dns_zone_resource_group.name
}

data "azurerm_private_dns_zone" "replication_zone" {
  for_each = var.replication_networks

  name                = "privatelink.documents.azure.net"
  resource_group_name = "rg-${each.value.suffix}"
}