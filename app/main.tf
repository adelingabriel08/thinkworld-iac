module "app" {
  source = "./modules/region"

  for_each = local.networks

  suffix                   = "${local.suffix}-${each.value.location_short}"
  network                  = local.networks[each.key]
  tags                     = local.tags
  storage_account_suffix   = local.storage_account_suffix
  global_cosmos_db_id      = data.azurerm_cosmosdb_account.global.id
  router_cosmos_db_id      = data.azurerm_cosmosdb_account.router.id
  data_lifecycle_preffix   = local.data_lifecycle_preffix
  global_tm_profile_name   = azurerm_traffic_manager_profile.global.name
  router_tm_profile_name   = azurerm_traffic_manager_profile.router.name
  global_tm_profile_id     = azurerm_traffic_manager_profile.global.id
  router_tm_profile_id     = azurerm_traffic_manager_profile.router.id
  global_cosmos_db_rg      = data.azurerm_cosmosdb_account.global.resource_group_name
  global_cosmos_db_account = data.azurerm_cosmosdb_account.global.name
  router_cosmos_db_rg      = data.azurerm_cosmosdb_account.router.resource_group_name
  router_cosmos_db_account = data.azurerm_cosmosdb_account.router.name
}

resource "azurerm_traffic_manager_profile" "global" {
  name                    = "tm-global-app"
  resource_group_name     = azurerm_resource_group.global.name
  traffic_routing_method  = "Geographic"
  dns_config {
    relative_name = "thinkworld"
    ttl           = 30
  }
  monitor_config {
    protocol = "HTTP"
    port     = 80
    path     = "/"
  }
  tags = local.tags
}

resource "azurerm_traffic_manager_profile" "router" {
  name                    = "tm-router-app"
  resource_group_name     = azurerm_resource_group.global.name
  traffic_routing_method  = "Geographic"
  dns_config {
    relative_name = "router-app"
    ttl           = 30
  }
  monitor_config {
    protocol = "HTTP"
    port     = 80
    path     = "/"
  }
  tags = local.tags
}

resource "azurerm_resource_group" "global" {
  name     = "rg-${local.product_short_code}-${local.lifecycle}"
  location = local.networks[values(local.networks)[0].suffix].location
  tags     = local.tags
}

# TODOs: 

# role assignment for cosmos (MUST)
# traffic manager profiles & endpoints (MUST)