resource "azurerm_cosmosdb_account" "main" {
  name                               = "cosno-${var.suffix}"
  location                           = data.azurerm_resource_group.main.location
  resource_group_name                = data.azurerm_resource_group.main.name
  offer_type                         = "Standard"
  free_tier_enabled                  = false

  public_network_access_enabled    = true # To allow public access from GP for troubleshooting
  multiple_write_locations_enabled = true

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = data.azurerm_resource_group.main.location
    failover_priority = 0
  }

  dynamic "geo_location" {
    for_each = var.replication_networks
    content {
      location          = geo_location.value.location
      failover_priority = 1 + index(keys(var.replication_networks), geo_location.value.suffix)
    }
  }

  tags = var.tags
}

resource "azurerm_cosmosdb_sql_database" "database" {
  name                = var.database_name
  resource_group_name = data.azurerm_resource_group.main.name
  account_name        = azurerm_cosmosdb_account.main.name
}

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "pe-${azurerm_cosmosdb_account.main.name}"
  location            = var.network.location
  resource_group_name = data.azurerm_resource_group.main.name
  subnet_id           = data.azurerm_subnet.endpoints.id

  private_service_connection {
    name                           = "psc-${azurerm_cosmosdb_account.main.name}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_cosmosdb_account.main.id
    subresource_names              = ["sql"]
  }

  private_dns_zone_group {
    name                 = "pdnszg-${azurerm_cosmosdb_account.main.name}"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.cosmos.id]
  }
}

resource "azurerm_private_endpoint" "private_endpoint_regions" {
  for_each = data.azurerm_subnet.replication_region

  name                = "pe-${azurerm_cosmosdb_account.main.name}-${var.replication_networks[each.key].location_short}"
  location            = var.replication_networks[each.key].location
  resource_group_name = data.azurerm_resource_group.main.name
  subnet_id           = each.value.id

  private_service_connection {
    name                           = "psc-${azurerm_cosmosdb_account.main.name}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_cosmosdb_account.main.id
    subresource_names              = ["sql"]
  }

  private_dns_zone_group {
    name                 = "pdnszg-${azurerm_cosmosdb_account.main.name}"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.replication_zone[each.key].id]
  }
}
