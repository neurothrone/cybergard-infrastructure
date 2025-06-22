output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "web_app_name" {
  value = azurerm_linux_web_app.backend.name
}

output "web_api_url" {
  value = "https://${azurerm_linux_web_app.backend.default_hostname}/api"
}

output "static_site_name" {
  value = azurerm_static_web_app.frontend.name
}

output "static_site_default_hostname" {
  value = azurerm_static_web_app.frontend.default_host_name
}
