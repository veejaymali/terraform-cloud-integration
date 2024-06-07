resource "azurerm_subnet" "bastionsubnet" {
  name                 = "${local.resource_name_prefix}-${var.bastion_subnet_name}"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.bastion_subnet_address
}

resource "azurerm_network_security_group" "bastion_subnet_nsg" {
   name                = "${local.resource_name_prefix}-bastionnsg"
  #location and rg name is combination of regroup.label.location and name
  location            = azurerm_resource_group.myrg.location
  #nameoftheresource.label.location
  #from where it will pick up from tfstate file
  resource_group_name = azurerm_resource_group.myrg.name

  tags = local.common_tags
}

#nsg need to be attached with the subnet
resource "azurerm_subnet_network_security_group_association" "bastion_subnet_nsg_association" {
    subnet_id = azurerm_subnet.bastionsubnet.id
    network_security_group_id = azurerm_network_security_group.bastion_subnet_nsg.id 
}

locals {
  bastion_inbound_port = {
    "110" : "22", #but in your express if the value is numeric you will seprate the same using colon symbol
    "120" : "3389"
     }
}

resource "azurerm_network_security_rule" "bastion_nsg_rule_inbound" {
    for_each = local.bastion_inbound_port
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
  network_security_group_name = azurerm_network_security_group.bastion_subnet_nsg.name
}


