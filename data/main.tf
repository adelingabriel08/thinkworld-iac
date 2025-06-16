resource "azurerm_resource_group" "main" {
  name     = "rg-${local.suffix}"
  location = local.region_network.location
  tags     = local.tags
}

resource "azurerm_resource_group" "pii" {
  for_each = local.all_pii_cosmos_networks
  name     = "rg-${each.value.suffix}"
  location = each.value.network.location
  tags     = local.tags
}

module "pii_cosmos" {
  for_each = local.all_pii_cosmos_networks
  source = "./modules/cosmos"

  resource_group                       = "rg-${each.value.suffix}"
  suffix                               = each.value.suffix
  network                              = each.value.network
  database_name                        = "ThinkWorldPII"
  private_dns_zone_resource_group_name = each.value.private_dns_zone_resource_group_name
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