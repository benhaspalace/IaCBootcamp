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

#Network Security Group
resource "azurerm_network_security_group" "IaCBootcampNSG" {
  name                = var.NSGName
  location            = var.location
  resource_group_name = var.rgName
}

resource "azurerm_subnet_network_security_group_association" "IaCBootCampNSG-Subnet01" {
  subnet_id                 = azurerm_subnet.IaCBootcampSubnet01.id
  network_security_group_id = azurerm_network_security_group.IaCBootcampNSG.id
}
