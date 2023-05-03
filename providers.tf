terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "value"
    storage_account_name = "value"
    container_name = "value"
    subscription_id = "value"
    key = "value"
  }
}

provider "azurerm" {
    alias = "prod"
    subscription_id = var.subId
    client_id = var.clientId
    client_secret = var.clientSecret
    tenant_id = var.tenant
    features {
        virtual_machine {
            delete_os_disk_on_deletion = true
        }
        resource_group {
            prevent_deletion_if_contains_resources = true
        }
    }
}