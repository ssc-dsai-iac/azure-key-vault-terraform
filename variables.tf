variable "create_resource_group" {
  description = "Whether to create resource group or not"
  type        = bool
  default     = false
}

variable "enabled_for_deployment" {
  description = "Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault"
  type        = bool
  default     = false
}

variable "enabled_for_disk_encryption" {
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys"
  type        = bool
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault"
  type        = bool
  default     = false
}

variable "enable_purge_protection" {
  description = "Boolean flag whether Purge Protection is enabled for this Key Vault"
  type        = bool
  default     = false
}

variable "enable_rbac_authorization" {
  description = "Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions"
  type        = bool
  default     = false
}

variable "location" {
  description = "The location of the Key Vault (and/or Resource Group) to create in"
  type        = string
  default     = "Canada Central"
}

variable "name" {
  description = "The name of the Key Vault to created"
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "The name of the Resource Group in which to create the Key Vault"
  type        = string
  default     = ""
}

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium."
  type        = string
  default     = "standard"  
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90"
  type        = number
  default     = 7
}

variable "tags" {
  description = "A map of tags to add"
  type        = map(string)
  default     = {}
}