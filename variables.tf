variable "rgName" {
  type = string
}

variable "vmNames" {
  default = [
    "IaCBootcampVM01",
    "IaCBootcampVM02",
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