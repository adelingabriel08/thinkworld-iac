# Cosmos dns zone
resource "azurerm_private_dns_zone" "primary" {
  name                = "privatelink.documents.azure.net"
  resource_group_name = module.primary_region.resource_group_name
  depends_on          = [module.primary_region]
}

resource "azurerm_private_dns_zone" "secondary" {
  count               = var.secondary_region_vnet_address_space != null ? 1 : 0
  name                = "privatelink.documents.azure.net"
  resource_group_name = module.secondary_region[0].resource_group_name
  depends_on          = [module.secondary_region[0]]
}

resource "azurerm_private_dns_zone_virtual_network_link" "primary" {
  name                  = "pl-${module.primary_region.suffix}"
  resource_group_name   = module.primary_region.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.primary.name
  virtual_network_id    = module.primary_region.virtual_network_id
  depends_on            = [ module.primary_region, azurerm_private_dns_zone.primary ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "secondary" {
  count                 = var.secondary_region_vnet_address_space != null ? 1 : 0
  name                  = "pl-${module.secondary_region[0].suffix}"
  resource_group_name   = module.secondary_region[0].resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.secondary[0].name
  virtual_network_id    = module.secondary_region[0].virtual_network_id
  depends_on            = [module.secondary_region[0], azurerm_private_dns_zone.secondary[0] ]
}

// TODO v-net peering for global PEs
