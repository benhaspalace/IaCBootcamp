terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    # TODO: find an alternative way to use variables here (maybe ENV vars?)
    resource_group_name  = "IaCBootcampBackendRG1"
    storage_account_name = "iacbootcamptfstatesa01"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
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
