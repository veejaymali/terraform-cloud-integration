resource "azurerm_linux_virtual_machine" "myvm" {
    count = 2
  name                = "mylinux-vm1-${count.index}"
    location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  size                = "Standard_F2"
  admin_username      = "azureuser"
  network_interface_ids = [
    element(azurerm_network_interface.myvmnic[*].id,count.index),
  ]

  admin_ssh_key {
    username   = "azureuser"
    #cd ./
    #terraform has come up with a argument called as path.module
    public_key = file("${path.module}/key/terraform-azure.pub") 
    #it will always look for the file in current directory  
  }
  os_disk {
    name = "osdisk-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/app/app.sh")
}
