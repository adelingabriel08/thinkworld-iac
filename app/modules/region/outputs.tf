output "global_app_id" {
  value = azurerm_linux_web_app.global.id
}

output "global_app_fqdn" {
  value = azurerm_linux_web_app.global.default_hostname
}


output "router_app_id" {
  value = azurerm_linux_web_app.router.id
}

output "router_app_fqdn" {
  value = azurerm_linux_web_app.router.default_hostname
}

output "pii_app_id" {
  value = azurerm_linux_web_app.pii.id
}

output "pii_app_fqdn" {
  value = azurerm_linux_web_app.pii.default_hostname
}

output "rg_name" {
  value = azurerm_resource_group.main.name
}
