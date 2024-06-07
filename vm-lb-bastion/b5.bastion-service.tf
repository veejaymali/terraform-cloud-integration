resource "azurerm_subnet" "bastion_service_subnet" {
  name                 = var.bastion_service_subnet_name
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.bastion_service_address_prefix
}

resource "azurerm_public_ip" "bastion_public_ip" {
   name                = "bastion-public-ip1"

  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  allocation_method   = "Static"
 sku = "Standard"
  tags = local.common_tags
}
#using a bastion host we will login inside the vm
#hi
resource "azurerm_bastion_host" "bastion_host" {
  name = "${local.resource_name_prefix}-bastion-service"
   location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  ip_configuration {
    name = "configuration"
    subnet_id = azurerm_subnet.bastion_service_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_public_ip.id
  }
}