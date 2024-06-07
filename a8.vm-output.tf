/*output "vm_public_ip" {
  description = "this is the public ip of vm"
  value = azurerm_linux_virtual_machine.myvm.public_ip_addresses
}
output "vnet_name" {
  description = "this is the name of the vnet"
  value = azurerm_virtual_network.vnet.name
}*/

output "lb-public-ip" {
  description = "lb public ip"
  value       = azurerm_public_ip.web_lb_publicip.ip_address
}