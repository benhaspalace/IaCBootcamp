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
 default = [ {
    name                       = "AllowSSH"
     priority                   = 100
     direction                  = "Inbound"
     access                     = "Allow"
     protocol                   = "Tcp"
     source_port_range          = "*"
     destination_port_range     = "22"
     source_address_prefix      = "*"
     destination_address_prefix = "*"
 } ]
}

variable "rgName" {
  type = string
}

variable "location" {
  type = string
}

variable "subnetId" {
  type = string
}