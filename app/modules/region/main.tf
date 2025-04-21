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