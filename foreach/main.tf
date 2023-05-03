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