# Define input variables
variable "location" {
  type = string
}

variable "rgName" {
  type = string
}

variable "VNetName" {
  type = string
}

variable "VNetAddressSpace" {
  type = list(string)
}

variable "subnetName" {
  type = string
}

variable "subnetAddressPrefix" {
  type = list(string)
}