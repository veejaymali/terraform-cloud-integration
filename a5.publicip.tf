/*resource "azurerm_public_ip" "mypublicip" {
    count = 2
    depends_on = [ azurerm_virtual_network.vnet,azurerm_subnet.mysubnet ]
   name                = "mypublicip-1-${count.index}"
   #mypublicip-1-0
   #mypublicip-1-1
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}*/
#using a bastion host we will login inside the vm

