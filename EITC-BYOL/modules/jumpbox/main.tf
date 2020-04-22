locals {
}

###################################
# Window VM(s) for Media Composer #
###################################
module "jump_box" {
  source                          = "../azurevm"
  resource_group_name             = var.resource_group_name
  location                        = var.resource_group_location
  vm_hostname                     = var.hostname
  admin_password                  = var.admin_password
  admin_username                  = var.admin_username
  base_index                      = var.base_index
  proximity_placement_group_id    = var.proximity_placement_group_id 
  vm_os_simple                    = "Desktop"
  storage_account_type            = "Standard_LRS"
  nb_public_ip                    = var.jump_box_vm_number_public_ip
  remote_port                     = var.jump_box_vm_remote_port
  nb_instances                    = var.jump_box_vm_instances
  vm_size                         = var.jump_box_vm_size
  vnet_subnet_id                  = var.subnet_id
  boot_diagnostics                = "false"
  delete_os_disk_on_termination   = "true"
  enable_accelerated_networking   = "false"
  is_windows_image                = "true"
  tags                            = var.tags
}
