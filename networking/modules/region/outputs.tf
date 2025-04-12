output "resource_group_name" {
  description = "The name of the regional resource group."
  value       = azurerm_resource_group.main.name
}

output "resource_group_location" {
  description = "The name of the regional resource group."
  value       = azurerm_resource_group.main.location
}

output "virtual_network_id" {
  description = "The ID of the regional virtual network."
  value       = azurerm_virtual_network.main.id
}

output "virtual_network_name" {
  description = "The name of the regional virtual network."
  value       = azurerm_virtual_network.main.name
}

output "suffix" {
  value = local.suffix
}
