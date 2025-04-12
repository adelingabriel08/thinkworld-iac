resource "azurerm_resource_group" "main" {
  name     = "rg-${local.suffix}"
  location = local.location
  tags     = local.tags
}

# This is the defined purpose of this module, so it's here rather than in modules.tf, which is for external dependecies.
resource "azurerm_log_analytics_workspace" "main" {
  name                = "law-${local.suffix}"
  location            = local.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.tags
}