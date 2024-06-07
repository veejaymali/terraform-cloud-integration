resource "null_resource" "null_copy_ssh_key_to_bastion" {
  depends_on = [ azurerm_linux_virtual_machine.bastionvm ]
  connection {
    type = "ssh" #RDP
    host = azurerm_linux_virtual_machine.bastionvm.public_ip_address
    user = azurerm_linux_virtual_machine.bastionvm.admin_username
    private_key = file("${path.module}/key/terraform-azure.pem") 
  }

  #once it make the connection we need to upload a file 
  provisioner "file" {
    source = "key/terraform-azure.pem"
    destination = "/tmp/terraform-azure.pem"
  }
##once uploaded we want to execute some command in the target system
  provisioner "remote-exec" {
    inline = [ 
        "sudo chmod 400 /tmp/terraform-azure.pem"
        #mysql -u username -p database_name < file.sql

     ]
  }
}

#777
