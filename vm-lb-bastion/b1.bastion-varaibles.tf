variable "bastion_subnet_name" {
  type = string
  default = "bastionsubnet"
}

variable "bastion_subnet_address" {
  type = list(string)
  default = [ "10.0.100.0/24" ]
}