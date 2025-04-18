resource "azurerm_virtual_network" "main" {
  name                = "vnet-${local.suffix}"
  location            = var.location_object.name
  resource_group_name = azurerm_resource_group.main.name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

# resource "azurerm_monitor_diagnostic_setting" "vnet" {
#   name                       = "ds-${local.suffix}-vnet"
#   target_resource_id         = azurerm_virtual_network.main.id
#   log_analytics_workspace_id = var.law_id
#   enabled_log {
#     category_group = "allLogs"
#   }
#   metric {
#     category = "AllMetrics"
#   }
#   lifecycle {
#     ignore_changes = [
#       log_analytics_destination_type, 
#     ]
#   }
# }
