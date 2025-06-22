terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "plan" {
  name                = var.service_plan_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  os_type  = "Linux"
  sku_name = "B1"

  depends_on = [azurerm_resource_group.rg]
}

resource "azurerm_linux_web_app" "backend" {
  name                = var.app_service_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    always_on                = false

    application_stack {
      dotnet_version = "8.0"
    }

    cors {
      allowed_origins = [
        # "http://localhost:5173", # Local development URL for the frontend
        # "https://${azurerm_static_web_app.frontend.default_host_name}"
      ]
    }
  }

  app_settings = {
    "ASPNETCORE_ENVIRONMENT" = "Production"
    "MongoDB__ConnectionString" = var.mongodb_connection_string
    "MongoDB__DatabaseName"    = var.mongodb_database_name
  }

  depends_on = [
    azurerm_resource_group.rg,
    azurerm_service_plan.plan
  ]
}

resource "azurerm_static_web_app" "frontend" {
  name                = var.static_site_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.static_site_location
  sku_tier            = "Free"
  sku_size            = "Free"

  depends_on = [
    azurerm_resource_group.rg
  ]
}
