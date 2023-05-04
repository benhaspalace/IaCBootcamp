variable "rgName" {
  type = string
}

variable "vmNames" {
  default = [
    "VM01",
    "VM02",
  ]
}

variable "kvName" {
  type = string
}

variable "kvRG" {
  type = string
}

variable "userNameSecret" {
  type = string
}

variable "passwordSecret" {
  type = string
}

variable "NSGName" {
  type = string
}

variable "VNetName" {
  type = string
}

variable "subnetName" {
  type = string
}

variable "nsg_rules" {
  type = list(object({
    name                       = string
    priority                   = string
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    {
      name                       = "AllowSSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}