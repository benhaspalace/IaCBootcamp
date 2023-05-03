# Virtual network
resource "azurerm_virtual_network" "IaCBootcampVNet" {
  name                = var.VNetName
  location            = var.location
  resource_group_name = var.rgName
  address_space       = var.VNetAddressSpace
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

# Subnet
resource "azurerm_subnet" "IaCBootcampSubnet01" {
  name                 = var.subnetName
  resource_group_name  = var.rgName
  virtual_network_name = azurerm_virtual_network.IaCBootcampVNet.name
  address_prefixes     = var.subnetAddressPrefix
}
