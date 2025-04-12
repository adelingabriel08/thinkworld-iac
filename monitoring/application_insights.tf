resource "azurerm_application_insights" "main" {
  name                = "appi-${local.suffix}"
  location            = local.location
  resource_group_name = azurerm_resource_group.main.name
  workspace_id        = azurerm_log_analytics_workspace.main.id
  application_type    = "web"
  tags                = local.tags
}