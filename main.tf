# Resource group
resource "azurerm_resource_group" "IaCBootcampRG" {
  name     = "IaCBootcampRG"
  location = "North Europe"
}

#Network Security Group
resource "azurerm_network_security_group" "IaCBootcampNSG" {
  name                = "IaCBootcampNSG"
  location            = azurerm_resource_group.IaCBootcampRG.location
  resource_group_name = azurerm_resource_group.IaCBootcampRG.name
}

# Virtual network
resource "azurerm_virtual_network" "IaCBootcampVNet" {
  name                = "IaCBootcampVNet"
  location            = azurerm_resource_group.IaCBootcampRG.location
  resource_group_name = azurerm_resource_group.IaCBootcampRG.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

# Subnet
resource "azurerm_subnet" "IaCBootcampSubnet01" {
  name                 = "IaCBootcampSubnet01"
  resource_group_name  = azurerm_resource_group.IaCBootcampRG.name
  virtual_network_name = azurerm_virtual_network.IaCBootcampVNet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Network interface card
resource "azurerm_network_interface" "IaCBootcampVM01NIC" {
  name                = "IaCBootcampVM01NIC"
  location            = azurerm_resource_group.IaCBootcampRG.location
  resource_group_name = azurerm_resource_group.IaCBootcampRG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.IaCBootcampSubnet01.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Virtual machine
resource "azurerm_windows_virtual_machine" "IaCBootcampVM01" {
  name                = "IaCBootcampVM01"
  resource_group_name = azurerm_resource_group.IaCBootcampRG.name
  location            = azurerm_resource_group.IaCBootcampRG.location
  size                = "Standard_B2s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.IaCBootcampVM01NIC.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}