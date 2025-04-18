resource "azurerm_resource_group" "main" {
  name     = "rg-${local.suffix}"
  location = local.region_network.location
  tags     = local.tags
}

resource "azurerm_resource_group" "pii" {
  name     = "rg-${local.region_suffix}"
  location = local.region_network.location
  tags     = local.tags
}


module "pii_cosmos" {
  source = "./modules/cosmos"

  resource_group                       = azurerm_resource_group.pii.name
  suffix                               = "${local.suffix}-pii-${module.azure_primary_region.location_short}"
  network                              = local.region_network
  database_name                        = "ThinkWorldPII"
  private_dns_zone_resource_group_name = "rg-${local.region_network.suffix}"
  tags                                 = local.tags

  depends_on = [ azurerm_resource_group.pii ]
}

module "global_cosmos" {
  source = "./modules/cosmos"

  resource_group                       = azurerm_resource_group.main.name
  suffix                               = "${local.suffix}-global"
  network                              = local.region_network
  database_name                        = "ThinkWorldPII"
  private_dns_zone_resource_group_name = "rg-${local.region_network.suffix}"
  tags                                 = local.tags
  replication_networks                 = local.replication_networks

  depends_on = [ azurerm_resource_group.main ]
}
 
module "router_cosmos" {
  source = "./modules/cosmos"

  resource_group                       = azurerm_resource_group.main.name
  suffix                               = "${local.suffix}-router"
  network                              = local.region_network
  database_name                        = "ThinkWorldRouter"
  private_dns_zone_resource_group_name = "rg-${local.region_network.suffix}"
  tags                                 = local.tags
  replication_networks                 = local.replication_networks

  depends_on = [ azurerm_resource_group.main ]
}