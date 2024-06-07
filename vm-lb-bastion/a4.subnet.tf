resource "azurerm_subnet" "mysubnet" {
  name                 = "${local.resource_name_prefix}-${var.web_subnet_name}"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.web_subnet_address
}