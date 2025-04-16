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
  suffix                               = local.region_suffix
  network                              = local.region_network
  database_name                        = "ThinkWorldPII"
  private_dns_zone_resource_group_name = "rg-${local.region_network.suffix}"
  tags                                 = local.tags

  depends_on = [ azurerm_resource_group.pii ]
}

module "global_cosmos" {
  source = "./modules/cosmos"

  resource_group                       = azurerm_resource_group.main.name
  suffix                               = local.suffix
  network                              = local.region_network
  database_name                        = "ThinkWorldPII"
  private_dns_zone_resource_group_name = "rg-${local.region_suffix}"
  tags                                 = local.tags

  depends_on = [ azurerm_resource_group.main ]
}
 
module "router_cosmos" {
  source = "./modules/cosmos"

  resource_group                       = azurerm_resource_group.main.name
  suffix                               = local.suffix
  network                              = local.region_network
  database_name                        = "ThinkWorldRouter"
  private_dns_zone_resource_group_name = "rg-${local.suffix}"
  tags                                 = local.tags

  depends_on = [ azurerm_resource_group.main ]
}