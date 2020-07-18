locals {
  mediacomposer_vm_script_url = "${var.software_install_urls["mediacomposer_vm_script_url"]}"
  avid_nexis_client_url       = "${var.software_install_urls["avid_nexis_client_url"]}"
  mediaComposer_url           = "${var.software_install_urls["mediaComposer_url"]}"
  teradici_url                = "${var.software_install_urls["teradici_url"]}"
  nvidia_url                  = "${var.software_install_urls["nvidia_url"]}"
  teradici_key                = "${var.software_install_urls["teradici_key"]}"
}

###################################
# Window VM(s) for Media Composer #
###################################
module "media_composer" {
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
  nb_public_ip                    = var.mediacomposer_vm_number_public_ip
  remote_port                     = var.mediacomposer_vm_remote_port
  nb_instances                    = var.mediacomposer_vm_instances
  vm_size                         = var.mediacomposer_vm_size
  vnet_subnet_id                  = var.subnet_id
  boot_diagnostics                = "false"
  delete_os_disk_on_termination   = "true"
  enable_accelerated_networking   = "false"
  is_windows_image                = "true"
  tags                            = var.tags
}

resource "azurerm_virtual_machine_extension" "media_composer" {
  name                  = format("${var.hostname}-%02.0f",count.index + var.base_index)
  count                 = var.mediacomposer_vm_instances
  virtual_machine_id    = module.media_composer.vm_ids[count.index]
  publisher             = "Microsoft.Compute"
  type                  = "CustomScriptExtension"
  type_handler_version  = "1.9"
  depends_on            = [module.media_composer]
  tags                  = var.tags

  # CustomVMExtension Documetnation: https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-windows
  settings = <<SETTINGS
    {
        "fileUris": ["${local.mediacomposer_vm_script_url}"]
    }
SETTINGS
  protected_settings = <<PROTECTED_SETTINGS
    {
      "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File setupMediaComposer_NVIDIA_20204.ps1 ${local.teradici_key} ${local.mediaComposer_url} ${local.teradici_url} ${local.nvidia_url} ${local.avid_nexis_client_url}"
    }
  PROTECTED_SETTINGS
}
