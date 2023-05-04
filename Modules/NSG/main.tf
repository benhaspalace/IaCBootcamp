#Network Security Group
resource "azurerm_network_security_group" "IaCBootcampNSG" {
  name                = var.NSGName
  location            = var.location
  resource_group_name = var.rgName
}

# Network Security Group association with subnet
resource "azurerm_subnet_network_security_group_association" "IaCBootCampNSG-Subnet" {
  subnet_id                 = var.subnetId
  network_security_group_id = azurerm_network_security_group.IaCBootcampNSG.id
}

# Network Security Rules
resource "azurerm_network_security_rule" "IaCBootcampNSGRules" {
  for_each = { for nsg_rule in var.nsg_rules : nsg_rule.name => nsg_rule }

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.rgName
  network_security_group_name = azurerm_network_security_group.IaCBootcampNSG.name
}
