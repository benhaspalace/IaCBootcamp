terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
/*  backend "azurerm" {
    resource_group_name  = var.backendRG
    storage_account_name = var.storageaccount_name
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  } */
}

provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
