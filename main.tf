# ---------------------------------------------------------------------------------------------------------------------
# Azure Resource Group Creation or selection - Default is "false"
# ---------------------------------------------------------------------------------------------------------------------
data "azurerm_resource_group" "this" {
  count = var.create_resource_group == false ? 1 : 0
  name  = var.resource_group_name
}

resource "azurerm_resource_group" "this" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# ---------------------------------------------------------------------------------------------------------------------
# Creating Azure Key Vault
# ---------------------------------------------------------------------------------------------------------------------
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                      = var.name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  sku_name                  = var.sku_name
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  soft_delete_enabled       = true
  purge_protection_enabled  = true
  tags                      = var.tags

  network_acls {
    default_action = "Deny"
    bypass = "AzureServices"
  }
  
  # This will add the current logged in az user
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "get", "backup", "delete", "list", "purge", "recover", "restore", "set",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}