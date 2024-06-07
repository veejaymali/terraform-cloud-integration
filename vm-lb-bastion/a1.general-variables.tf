#to define input varaible
variable "resource_group_name" {
  description = "this contains rg name"
  type = string #list string array map number
  default = "rg-default"
}

#hr-sap-rg-default
#name to an expression

variable "resource_group_location" {
  description = "this is the resource group location"
  type = string
  default = "eastus"
}

variable "business_devision" {
    #if you do not define type it will always take the type as 
  type = string 
  default = "sap"
}

variable "environment" {
  type = string 
  default = "hr"
}