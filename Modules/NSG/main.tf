#Network Security Group
resource "azurerm_network_security_group" "IaCBootcampNSG" {
  name                = var.NSGName
  location            = var.location
  resource_group_name = var.rgName

  security_rule = var.nsg_rules
}

# Network Security Group association with subnet
resource "azurerm_subnet_network_security_group_association" "IaCBootCampNSG-Subnet01" {
  subnet_id                 = var.subnetId
  network_security_group_id = azurerm_network_security_group.IaCBootcampNSG.id
}