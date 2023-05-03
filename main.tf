# Resource group
resource "azurerm_resource_group" "IaCBootcampRG" {
  name     = var.rgName
  location = local.location
}

# Network interface card
resource "azurerm_network_interface" "IaCBootcampVM01NIC" {
  name                = "IaCBootcampVM01NIC"
  location            = azurerm_resource_group.IaCBootcampRG.location
  resource_group_name = azurerm_resource_group.IaCBootcampRG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.net.subnetId
    private_ip_address_allocation = "Dynamic"
  }
}

# Public IP
resource "azurerm_public_ip" "pip1" {
    name = ""
    allocation_method = local.publicIpAllocation
    resource_group_name = azurerm_resource_group.IaCBootcampRG.name
    location = azurerm_resource_group.IaCBootcampRG.location
    
    count = var.vmCount
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

  count = length(var.vmNames)
module "net" {
  source              = "./Modules/Networking"
  rgName              = azurerm_resource_group.IaCBootcampRG.name
  location            = azurerm_resource_group.IaCBootcampRG.location
  NSGName             = "IaCBootcampNSG"
  VNetName            = "IaCBootcampVNet"
  VNetAddressSpace    = local.VNetAddressSpace
  subnetName          = "IaCBootcampSubnet01"
  subnetAddressPrefix = local.subnetAddressPrefix
}
