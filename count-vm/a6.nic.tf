resource "azurerm_network_interface" "myvmnic" {
    count = 2
  name                = "vm-nic-${count.index}"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
 

  ip_configuration {
    name                          = "internal"
    #private ip address
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    #we will attach a public ip to the nic card
    #this public containes a list
    public_ip_address_id = element(azurerm_public_ip.mypublicip[*].id,count.index)
  }
}
