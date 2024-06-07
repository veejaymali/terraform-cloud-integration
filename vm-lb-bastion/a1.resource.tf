##
#the block start with resource
#type or resource which i want to creater
#label unique
resource "azurerm_resource_group" "myrg" {
  #inside the resource block we provided argument
  name     = "${local.resource_name_prefix}-${var.resource_group_name}"
#sap-hr-rg-default
  ##to call a variable we will use var.nameofthevariables
  location = var.resource_group_location
  tags = local.common_tags
}
