# Resource group
resource "azurerm_resource_group" "IaCBootcampRG" {
  name     = "${local.prefix}-${var.rgName}-${local.suffix}"
  location = local.location
}

# Network interface card
resource "azurerm_network_interface" "IaCBootcampVMNIC" {
  name                = "${local.prefix}-${var.vmNames[count.index]}-NIC-${local.suffix}"
  location            = azurerm_resource_group.IaCBootcampRG.location
  resource_group_name = azurerm_resource_group.IaCBootcampRG.name

  count = length(var.vmNames)

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.net.subnetId
    private_ip_address_allocation = "Dynamic"
  }
}

data "azurerm_key_vault" "IaCBootCampKeyVault" {
  name                = var.kvName
  resource_group_name = var.kvRG
}

data "azurerm_key_vault_secret" "userName" {
  name         = var.userNameSecret
  key_vault_id = data.azurerm_key_vault.IaCBootCampKeyVault.id
}

data "azurerm_key_vault_secret" "password" {
  name         = var.passwordSecret
  key_vault_id = data.azurerm_key_vault.IaCBootCampKeyVault.id
}

# Virtual machine
resource "azurerm_windows_virtual_machine" "IaCBootcampVM01" {
  name                = "${local.prefix}-${var.vmNames[count.index]}-${local.suffix}"
  resource_group_name = azurerm_resource_group.IaCBootcampRG.name
  location            = azurerm_resource_group.IaCBootcampRG.location
  size                = "Standard_B2s"
  admin_username      = data.azurerm_key_vault_secret.userName.value
  admin_password      = data.azurerm_key_vault_secret.password.value
  network_interface_ids = [
    azurerm_network_interface.IaCBootcampVMNIC[count.index].id
  ]

  os_disk {
    name                  = "${var.vmNames[count.index]}-OSDisk"
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
}

module "net" {
  source              = "./Modules/Networking"
  rgName              = azurerm_resource_group.IaCBootcampRG.name
  location            = azurerm_resource_group.IaCBootcampRG.location
  VNetName            = "${local.prefix}-${var.VNetName}-${local.suffix}"
  VNetAddressSpace    = local.VNetAddressSpace
  subnetName          = var.subnetName
  subnetAddressPrefix = local.subnetAddressPrefix
}

module "nsg" {
  source   = "./Modules/NSG"
  rgName   = azurerm_resource_group.IaCBootcampRG.name
  location = azurerm_resource_group.IaCBootcampRG.location
  subnetId = module.net.subnetId

  NSGName = "${local.prefix}-${var.NSGName}-${local.suffix}"

  # Use var.nsg_rules if it has elements else do not pass variable
  nsg_rules = length(var.nsg_rules) > 0 ? var.nsg_rules : null
}
