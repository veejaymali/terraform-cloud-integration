##we will create an nsg
resource "azurerm_network_security_group" "web_subnet_nsg" {
   name                = "${local.resource_name_prefix}-nsg"
  #location and rg name is combination of regroup.label.location and name
  location            = azurerm_resource_group.myrg.location
  #nameoftheresource.label.location
  #from where it will pick up from tfstate file
  resource_group_name = azurerm_resource_group.myrg.name

  tags = local.common_tags
}

#nsg need to be attached with the subnet
resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_association" {
    subnet_id = azurerm_subnet.mysubnet.id 
    network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}

locals {
  web_inbound_port = {
    "110" : "80", #but in your express if the value is numeric you will seprate the same using colon symbol
    "120" : "22",
    "130" : "443"
     }
}

resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
    for_each = local.web_inbound_port
  name                        = "Rule-Port-${each.value}" #Rule-Port-80
  priority                    = each.key #110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*" #0.0.0.0/0 :00
  destination_port_range      = each.value #80
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
 resource_group_name = azurerm_resource_group.myrg.name
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
}

