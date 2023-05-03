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
