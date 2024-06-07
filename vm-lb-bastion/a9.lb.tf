##load balancer public ip
resource "azurerm_public_ip" "web_lb_publicip" {
    
    
   name                = "${local.resource_name_prefix}-lbpublicip"
  
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  allocation_method   = "Static"
  sku = "Standard" #premium

  tags = local.common_tags
}
#lets create the lb
resource "azurerm_lb" "web_lb" {
  name                = "${local.resource_name_prefix}-weblb"
  
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  sku = "Standard"
  frontend_ip_configuration {
    name = "lb"
    public_ip_address_id = azurerm_public_ip.web_lb_publicip.id
  }
}

#we will create the backend address pool 
resource "azurerm_lb_backend_address_pool" "web_lb_pool" {
  name                = "${local.resource_name_prefix}-backendpool"
  loadbalancer_id = azurerm_lb.web_lb.id 
}

##we will create the probes 
resource "azurerm_lb_probe" "web_lb_probe" {
  name                = "${local.resource_name_prefix}-tcpprobe"
  protocol = "Tcp"
  port = 80
  loadbalancer_id = azurerm_lb.web_lb.id 
}

#we will create lb rule 
resource "azurerm_lb_rule" "web_rule_rule" {
   name                = "${local.resource_name_prefix}-lbrule"
   protocol = "Tcp"
   frontend_port = 80
   backend_port = 80 #application server port number
   frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name 
   backend_address_pool_ids = [azurerm_lb_backend_address_pool.web_lb_pool.id]
   probe_id = azurerm_lb_probe.web_lb_probe.id 
   loadbalancer_id = azurerm_lb.web_lb.id 
}

#once the rule is created we are left with what 
resource "azurerm_network_interface_backend_address_pool_association" "web_lb_association" {
  for_each = var.force_map
  network_interface_id = azurerm_network_interface.myvmnic[each.key].id
  ip_configuration_name = azurerm_network_interface.myvmnic[each.key].ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.web_lb_pool.id 
}