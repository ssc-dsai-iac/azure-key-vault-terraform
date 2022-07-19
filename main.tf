locals {
  resource_group_name = element(coalescelist(data.azurerm_resource_group.rgrp.*.name, azurerm_resource_group.rg.*.name, [""]), 0)
  location            = element(coalescelist(data.azurerm_resource_group.rgrp.*.location, azurerm_resource_group.rg.*.location, [""]), 0)
}

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

data "azurerm_client_config" "current" {}

# ---------------------------------------------------------------------------------------------------------------------
# Creating Azure Key Vault
# ---------------------------------------------------------------------------------------------------------------------

resource "azurerm_key_vault" "this" {
  name                            = var.name
  location                        = local.location
  resource_group_name             = local.resource_group_name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = var.sku_name
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  soft_delete_retention_days      = var.soft_delete_retention_days
  enable_rbac_authorization       = var.enable_rbac_authorization
  purge_protection_enabled        = var.enable_purge_protection
  
  tags                            = var.tags

}

# ---------------------------------------------------------------------------------------------------------------------
# Creating Azure Key Vault Access Policy
# ---------------------------------------------------------------------------------------------------------------------
# Will be created based on the value of the "create_current_user_access_policy" variable

resource "azurerm_key_vault_access_policy" "this" {
  count = var.create_current_user_access_policy ? 1 : 0

  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get",
  ]

  secret_permissions = [
    "Get", "Backup", "Delete", "List", "Purge", "Recover", "Restore", "Set",
  ]

  storage_permissions = [
    "Get",
  ]
}