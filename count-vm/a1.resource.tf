##
#the block start with resource
#type or resource which i want to creater
#label unique
resource "azurerm_resource_group" "myrg" {
  #inside the resource block we provided argument
  name     = "myrg-1" #argument should be in key value format
  location = "eastus"
}
