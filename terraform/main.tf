# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.1"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "927d0301-3031-467c-9b95-a3d0135304a7"
  client_id       = "6d28fbbe-54d5-4540-9241-b218ff1a9a59"
  client_secret   = "e~tD~rjfHWELBfhBKkC1hMCAtNbPNbKAfD"
  tenant_id       = "899789dc-202f-44b4-8472-a6d40f9eb440"
}


# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group

resource "azurerm_resource_group" "rg" {
    name     =  "kubernetes_rg"
    location = var.location

    tags = {
        environment = "CP2"
    }

}

# Storage account
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account

resource "azurerm_storage_account" "stAccount" {
    name                     = var.storage_account 
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"

    tags = {
        environment = "CP2"
    }

}

