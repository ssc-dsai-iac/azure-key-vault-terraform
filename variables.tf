variable "create_resource_group" {
  description = "Whether to create resource group or not"
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

variable "tags" {
  description = "A map of tags to add"
  type        = map(string)
  default     = {}
}