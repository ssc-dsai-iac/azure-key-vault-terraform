# Azure Key Vault Terraform Module

Terraform Module to create an Azure Key Vault.



## Module Usage

```hcl
# Azure Provider configuration
provider "azurerm" {
  features {}
}


module "key_vault" {
  source  = "github.com/ssc-dsai-iac/azure-key-vault-terraform"

  # By default, this module will not create a resource group
  # provide a name to use an existing resource group, specify the existing resource group name,
  # and set the argument to `create_resource_group = false`. Location will be same as existing RG.
  create_resource_group = false

  name                = "${var.prefix}CSV-${var.group}-${var.user_defined}-kv"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location

  tags = {
    env        = var.env
    costcenter = var.costcenter
    ssn        = var.ssn
    subowner   = var.subowner
  }

}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14 |
| azurerm | >= 2.82.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 2.82.0 |

## Inputs

Name | Description | Type | Default
---- | ----------- | ---- | -------
`create_resource_group`|Whether to create resource group or not|bool|`false`
`location`|The location of the Key Vault (and/or Resource Group) to create in|string| `"Canada Central"`
`name`|The name of the Key Vault to created|string|`""`
`resource_group_name`|The name of the resource group in which to create the Key Vault|string|`""`
`sku_name`|The Name of the SKU used for this Key Vault. Possible values are standard and premium|string|`"standard"`
`Tags`|A map of tags to add to all resources|map|`{}`

## Outputs

Name | Description
---- | -----------
`key_vault_id`|Value of the Key Vault ID
`key_vault_uri`|Value of the Key Vault URI
`name`|Value of the Key Vault name
