resource "azurerm_linux_virtual_machine" "myvm" {
  for_each            = var.force_map
  name                = "${local.resource_name_prefix}-vm-${each.key}"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  size                = "Standard_F2"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.myvmnic[each.key].id
  ]

  admin_ssh_key {
    username = "azureuser"
    #cd ./
    #terraform has come up with a argument called as path.module
    public_key = file("${path.module}/key/terraform-azure.pub")
    #it will always look for the file in current directory  
  }
  os_disk {
    name                 = "osdisk-${each.key}"
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
