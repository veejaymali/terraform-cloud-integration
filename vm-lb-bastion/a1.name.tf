locals {
  owners = var.business_devision
  environment = var.environment
  resource_name_prefix = "${var.business_devision}-${var.environment}"
  #sap-hr
  common_tags = { #name is comon tag
  #we have define two expression but expression are in key value format
    owners = local.owners
    environment = local.environment
  }
}