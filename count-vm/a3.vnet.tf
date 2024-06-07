##we will create a vnet
resource "azurerm_virtual_network" "vnet" {
  name                = "myvnet-1"
  #location and rg name is combination of regroup.label.location and name
  location            = azurerm_resource_group.myrg.location
  #nameoftheresource.label.location
  #from where it will pick up from tfstate file
  resource_group_name = azurerm_resource_group.myrg.name
  address_space       = ["10.0.0.0/16"]
 
  tags = {
    environment = "Production"
  }
}