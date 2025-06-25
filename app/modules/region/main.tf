resource "azurerm_resource_group" "main" {
  name     = "rg-${var.suffix}"
  location = var.network.location
}

resource "azurerm_service_plan" "main" {
  name                = "asp-${var.suffix}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "global" {
  name                      = "app-global-${var.suffix}"
  resource_group_name       = azurerm_resource_group.main.name
  location                  = azurerm_service_plan.main.location
  service_plan_id           = azurerm_service_plan.main.id
  virtual_network_subnet_id = data.azurerm_subnet.app_integration.id
  
  identity {
    type = "SystemAssigned"
  }


  site_config {
    health_check_path                = "/health"
    health_check_eviction_time_in_min = 2
  }
}

resource "azurerm_linux_web_app" "router" {
  name                      = "app-router-${var.suffix}"
  resource_group_name       = azurerm_resource_group.main.name
  location                  = azurerm_service_plan.main.location
  service_plan_id           = azurerm_service_plan.main.id
  virtual_network_subnet_id = data.azurerm_subnet.app_integration.id

  identity {
    type = "SystemAssigned"
  }


  site_config {
    health_check_path                = "/health"
    health_check_eviction_time_in_min = 2
  }
}

resource "azurerm_linux_web_app" "pii" {
  name                      = "app-pii-${var.suffix}"
  resource_group_name       = azurerm_resource_group.main.name
  location                  = azurerm_service_plan.main.location
  service_plan_id           = azurerm_service_plan.main.id
  virtual_network_subnet_id = data.azurerm_subnet.app_integration.id

  identity {
    type = "SystemAssigned"
  }


  site_config {
    health_check_path                = "/health"
    health_check_eviction_time_in_min = 2
  }
}

resource "azurerm_linux_function_app" "global" {
  name                       = "func-global-${var.suffix}"
  resource_group_name        = azurerm_resource_group.main.name
  location                   = azurerm_resource_group.main.location
  service_plan_id            = azurerm_service_plan.main.id
  virtual_network_subnet_id  = data.azurerm_subnet.app_integration.id
  storage_account_name       = azurerm_storage_account.functions_storage.name
  storage_account_access_key = azurerm_storage_account.functions_storage.primary_access_key

  identity {
    type = "SystemAssigned"
  }

  site_config {}

  depends_on = [ azurerm_storage_account.functions_storage ]
}

resource "azurerm_linux_function_app" "pii" {
  name                       = "func-pii-${var.suffix}"
  resource_group_name        = azurerm_resource_group.main.name
  location                   = azurerm_resource_group.main.location
  service_plan_id            = azurerm_service_plan.main.id
  virtual_network_subnet_id  = data.azurerm_subnet.app_integration.id
  storage_account_name       = azurerm_storage_account.functions_storage.name
  storage_account_access_key = azurerm_storage_account.functions_storage.primary_access_key

  identity {
    type = "SystemAssigned"
  }

  site_config {}

  depends_on = [ azurerm_storage_account.functions_storage ]
}

# Replace azurerm_role_assignment with azurerm_cosmosdb_sql_role_assignment for Cosmos DB
resource "azurerm_cosmosdb_sql_role_assignment" "global_webapp_cosmos" {
  resource_group_name = var.global_cosmos_db_rg
  account_name        = var.global_cosmos_db_account
  role_definition_id  = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.global_cosmos_db_rg}/providers/Microsoft.DocumentDB/databaseAccounts/${var.global_cosmos_db_account}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
  principal_id        = azurerm_linux_web_app.global.identity[0].principal_id
  scope               = var.global_cosmos_db_id
}

resource "azurerm_cosmosdb_sql_role_assignment" "router_webapp_cosmos" {
  resource_group_name = var.router_cosmos_db_rg
  account_name        = var.router_cosmos_db_account
  role_definition_id  = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.router_cosmos_db_rg}/providers/Microsoft.DocumentDB/databaseAccounts/${var.router_cosmos_db_account}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
  principal_id        = azurerm_linux_web_app.router.identity[0].principal_id
  scope               = var.router_cosmos_db_id
}

resource "azurerm_cosmosdb_sql_role_assignment" "pii_webapp_cosmos" {
  resource_group_name = data.azurerm_cosmosdb_account.pii.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.pii.name
  role_definition_id  = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.azurerm_cosmosdb_account.pii.resource_group_name}/providers/Microsoft.DocumentDB/databaseAccounts/${data.azurerm_cosmosdb_account.pii.name}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
  principal_id        = azurerm_linux_web_app.pii.identity[0].principal_id
  scope               = data.azurerm_cosmosdb_account.pii.id
}

resource "azurerm_cosmosdb_sql_role_assignment" "global_func_cosmos" {
  resource_group_name = var.global_cosmos_db_rg
  account_name        = var.global_cosmos_db_account
  role_definition_id  = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.global_cosmos_db_rg}/providers/Microsoft.DocumentDB/databaseAccounts/${var.global_cosmos_db_account}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
  principal_id        = azurerm_linux_function_app.global.identity[0].principal_id
  scope               = var.global_cosmos_db_id
}

resource "azurerm_cosmosdb_sql_role_assignment" "pii_func_cosmos" {
  resource_group_name = data.azurerm_cosmosdb_account.pii.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.pii.name
  role_definition_id  = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.azurerm_cosmosdb_account.pii.resource_group_name}/providers/Microsoft.DocumentDB/databaseAccounts/${data.azurerm_cosmosdb_account.pii.name}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
  principal_id        = azurerm_linux_function_app.pii.identity[0].principal_id
  scope               = data.azurerm_cosmosdb_account.pii.id
}

resource "azurerm_traffic_manager_profile" "pii" {
  name                    = "tm-pii-${var.suffix}"
  resource_group_name     = azurerm_resource_group.main.name
  traffic_routing_method  = "Priority"
  dns_config {
    relative_name = "pii-app-${var.suffix}"
    ttl           = 30
  }
  monitor_config {
    protocol = "HTTP"
    port     = 80
    path     = "/"
  }
  tags = var.tags
}

resource "azurerm_traffic_manager_external_endpoint" "global" {
  name         = "global-endpoint-${var.suffix}"
  profile_id   = var.global_tm_profile_id
  target       = azurerm_static_web_app.static.default_host_name
  geo_mappings = [local.region_to_geo_mapping[var.network.location]]
  depends_on   = [azurerm_static_web_app.static]
}

resource "azurerm_traffic_manager_azure_endpoint" "router" {
  name                = "router-endpoint-${var.suffix}"
  profile_id         = var.router_tm_profile_id
  target_resource_id  = azurerm_linux_web_app.router.id
  geo_mappings        = [local.region_to_geo_mapping[var.network.location]]
}

resource "azurerm_traffic_manager_azure_endpoint" "pii" {
  name               = "pii-endpoint-${var.suffix}"
  profile_id         = azurerm_traffic_manager_profile.pii.id
  target_resource_id = azurerm_linux_web_app.pii.id
  priority           = 1
}

resource "azurerm_static_web_app" "static" {
  name                = "swa-${var.suffix}"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.network.location == "uksouth" ? "westeurope" : var.network.location
  sku_tier            = "Standard"
  tags                = var.tags
}