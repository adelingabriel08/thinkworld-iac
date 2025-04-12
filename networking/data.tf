data "azurerm_log_analytics_workspace" "main" {
  name                = "law-${local.monitoring_lifecycle_suffix}"
  resource_group_name = "rg-${local.monitoring_lifecycle_suffix}"
}