provider "azurerm" {
  features {}
}

variable "rgs" {
}
  
resource "azurerm_resource_group" "rg" {
  name = each.key
  location = each.value

  for_each = var.rgs
}

# Imported resource
resource "azurerm_storage_account" "newsa" {
    # Fill out with aztf export tool exported configuration
}