#Set the terraform required version and the backend
terraform {
}

# Configure the Azure Provider
provider "azurerm" {
  # It is recommended to pin to a given version of the Provider
  #subscription_id = var.subscription_id
  #client_id       = var.client_id
  #client_secret   = var.client_secret
  #tenant_id       = var.tenant_id
  features {}
  version         = "~>2.6"
  #partner_id      = "6ae4d712-3974-76c4-96de-50fc79fa69fc"
}

provider "random" {
  version = "~> 2.2"
}

#############################
# Locals:(Non-Tradional)    #
# Please change the values  # 
# in this section to        #
# customize the setup for   # 
# environment               #
#############################
locals {
  resource_group_name               = "BYOL"
  location                          = "eastus"
  
  admin_username                    = "azureuser"
  admin_password                    = "Password12345"
  
  address_space                     = "10.1.0.0/16"
  subnet_prefixes                   = ["10.1.1.0/24","10.1.2.0/24"]
  dns_servers                       = []
  subnet_names                      = ["default","storage"]
  
  source_address_prefix             = "*"
  
  jump_box_vm_size                  = "Standard_B2ms"
  jump_box_base_index               = 0
  jump_box_vm_instances             = 0
  jump_box_vm_number_public_ip      = 0

  mediacomposer_vm_size             = "Standard_NV12"
  mediacomposer_base_index          = 0
  mediacomposer_vm_instances        = 0
  mediacomposer_vm_number_public_ip = 0

  nexis_vm_size                     = "Standard_DS4_V2"
  nexis_base_index                  = 0
  nexis_instances                   = 0
  nexis_storage_vm_number_public_ip = 0
  nexis_type                        = "CloudNearline" # options "CloudNearline" or "CloudOnline"
   
  azureTags = {
                "environment" = "BYOL"
              }
}

#############################
# Resources                 #
#############################
module "editorial_networking" {
  source              = "./modules/azurenetwork"
  vnet_name           = "${local.resource_group_name}-vnet" 
  resource_group_name = "${local.resource_group_name}-rg" 
  location            = local.location
  address_space       = local.address_space
  dns_servers         = local.dns_servers
  subnet_prefixes     = local.subnet_prefixes
  subnet_names        = local.subnet_names
  allow_rdp_traffic   = true  
  allow_ssh_traffic   = true  
  sg_name             = "${local.resource_group_name}-secgrp"
  tags                = local.azureTags
}

locals {
  stored_resource_group_name      = module.editorial_networking.azurerm_resource_group_name
  stored_resource_group_location  = module.editorial_networking.azurerm_resource_group_location
  stored_subnet_id                = module.editorial_networking.azurerm_subnet_ids
  proximity_placement_group_id    = module.editorial_networking.proximity_placement_group_id
}

resource "random_string" "general" {
  length  = 5
  special = false
  upper   = false
}

module "jump_box_deployment" {
  source                        = "./modules/jumpbox"
  hostname                      = "jumpbox"
  admin_username                = local.admin_username
  admin_password                = local.admin_password
  resource_group_name           = local.stored_resource_group_name
  resource_group_location       = local.stored_resource_group_location
  subnet_id                     = local.stored_subnet_id[0]
  source_address_prefix         = local.source_address_prefix
  base_index                    = local.jump_box_base_index
  proximity_placement_group_id  = local.proximity_placement_group_id  
  jump_box_vm_size              = local.jump_box_vm_size
  jump_box_vm_instances         = local.jump_box_vm_instances
  jump_box_vm_number_public_ip  = local.jump_box_vm_number_public_ip
  tags                          = local.azureTags
}

module "media_composer_deployment" {
  source                            = "./modules/mediacomposer"
  hostname                          = "mcomposer"
  admin_username                    = local.admin_username
  admin_password                    = local.admin_password
  resource_group_name               = local.stored_resource_group_name
  resource_group_location           = local.stored_resource_group_location
  subnet_id                         = local.stored_subnet_id[0]
  source_address_prefix             = local.source_address_prefix
  base_index                        = local.mediacomposer_base_index
  proximity_placement_group_id      = ""  
  mediacomposer_vm_size             = local.mediacomposer_vm_size
  mediacomposer_vm_instances        = local.mediacomposer_vm_instances
  mediacomposer_vm_number_public_ip = local.mediacomposer_vm_number_public_ip
  tags                              = local.azureTags
}

module "nexis_deployment" {
  source                            = "./modules/nexis"
  hostname                          = "nexis"
  admin_password                    = local.admin_password
  resource_group_name               = local.stored_resource_group_name
  resource_group_location           = local.stored_resource_group_location
  subnet_id                         = local.stored_subnet_id[1]
  source_address_prefix             = local.source_address_prefix
  base_index                        = local.nexis_base_index 
  proximity_placement_group_id      = local.proximity_placement_group_id 
  nexis_storage_type                = local.nexis_type
  nexis_storage_vm_size             = local.nexis_vm_size
  nexis_storage_vm_instances        = local.nexis_instances
  nexis_storage_vm_number_public_ip = local.nexis_storage_vm_number_public_ip
  tags                              = local.azureTags
}
