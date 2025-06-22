variable "subscription_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type        = string
  default     = "swedencentral"
  description = "Resource group location"
}

variable "service_plan_name" {
  type    = string
  default = "cybergard-backend-plan"
}

variable "app_service_name" {
  type    = string
  default = "cybergard-backend"
}

variable "mongodb_connection_string" {
  type        = string
  description = "MongoDB connection string, including username, password, host, port, and database name"
}

variable "mongodb_database_name" {
  type        = string
  description = "MongoDB database name"
  default     = "CybergardDB"
}

variable "static_site_name" {
  type    = string
  default = "cybergard-frontend"
}

variable "static_site_location" {
  type    = string
  default = "westeurope"
}
