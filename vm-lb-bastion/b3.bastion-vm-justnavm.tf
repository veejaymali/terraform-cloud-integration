resource "azurerm_public_ip" "bastionpublicip" {
    
   name                = "mypublicip-1-bastionpublic"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}
#using a bastion host we will login inside the vm


resource "azurerm_network_interface" "bastionvmnic" {
  
  name                = "${local.resource_name_prefix}-bastionnic"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
 

  ip_configuration {
    name                          = "internal"
    #private ip address
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    #we will attach a public ip to the nic card
    #this public containes a list
    public_ip_address_id = azurerm_public_ip.bastionpublicip.id 
  }
}

resource "azurerm_linux_virtual_machine" "bastionvm" {
 
  name                = "${local.resource_name_prefix}-bastionvm"
    location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  size                = "Standard_F2"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.bastionvmnic.id 
  ]

  admin_ssh_key {
    username   = "azureuser"
    #cd ./
    #terraform has come up with a argument called as path.module
    public_key = file("${path.module}/key/terraform-azure.pub") 
    #it will always look for the file in current directory  
  }
  os_disk {
    name = "obastiondisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
 # custom_data = filebase64("${path.module}/app/app.sh")
}
