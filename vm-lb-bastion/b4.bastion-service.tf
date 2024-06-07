variable "bastion_service_subnet_name" {
  default = "AzureBastionSubnet"
}

variable "bastion_service_address_prefix" {
  default = ["10.0.101.0/27"]
}