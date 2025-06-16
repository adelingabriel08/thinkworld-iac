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


  site_config {}
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


  site_config {}
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


  site_config {}
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

# Role assignments for web apps and function apps to Cosmos DB
resource "azurerm_role_assignment" "global_webapp_cosmos" {
  scope                = var.global_cosmos_db_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_linux_web_app.global.identity[0].principal_id
}

resource "azurerm_role_assignment" "router_webapp_cosmos" {
  scope                = var.router_cosmos_db_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_linux_web_app.router.identity[0].principal_id
}

resource "azurerm_role_assignment" "pii_webapp_cosmos" {
  scope                = data.azurerm_cosmosdb_account.pii.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_linux_web_app.pii.identity[0].principal_id
}

resource "azurerm_role_assignment" "global_func_cosmos" {
  scope                = var.global_cosmos_db_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_linux_function_app.global.identity[0].principal_id
}

resource "azurerm_role_assignment" "pii_func_cosmos" {
  scope                = data.azurerm_cosmosdb_account.pii.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_linux_function_app.pii.identity[0].principal_id
}

resource "azurerm_traffic_manager_azure_endpoint" "global" {
  name                = "global-endpoint-${var.suffix}"
  profile_id         = var.global_tm_profile_id
  target_resource_id  = azurerm_linux_web_app.global.id
  geo_mappings        = ["WORLD"]
}

resource "azurerm_traffic_manager_azure_endpoint" "router" {
  name                = "router-endpoint-${var.suffix}"
  profile_id         = var.router_tm_profile_id
  target_resource_id  = azurerm_linux_web_app.router.id
  geo_mappings        = ["WORLD"]
}