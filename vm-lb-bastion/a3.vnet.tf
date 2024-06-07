##we will create a vnet
resource "azurerm_virtual_network" "vnet" {
  name                = "${local.resource_name_prefix}-${var.vnet_name}"
  #location and rg name is combination of regroup.label.location and name
  location            = azurerm_resource_group.myrg.location
  #nameoftheresource.label.location
  #from where it will pick up from tfstate file
  resource_group_name = azurerm_resource_group.myrg.name
  address_space       = var.vnet_address_space
 
  tags = local.common_tags
}