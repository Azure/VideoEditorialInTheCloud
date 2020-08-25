locals{
  nexis_storage_vm_script_url         = "${element(split(",", lookup(var.nexis_storage_configuration, var.nexis_storage_type, "")), 0)}"
  nexis_storage_vm_script_name        = "${element(split(",", lookup(var.nexis_storage_configuration, var.nexis_storage_type, "")), 1)}"
  nexis_storage_vm_artifacts_location = "${element(split(",", lookup(var.nexis_storage_configuration, var.nexis_storage_type, "")), 2)}"
  nexis_storage_vm_build              = "${element(split(",", lookup(var.nexis_storage_configuration, var.nexis_storage_type, "")), 3)}"
  nexis_storage_vm_part_number        = "${element(split(",", lookup(var.nexis_storage_configuration, var.nexis_storage_type, "")), 4)}"
  nexis_storage_performance           = "${element(split(",", lookup(var.nexis_storage_account_configuration, var.nexis_storage_type, "")), 0)}"
  nexis_storage_replication           = "${element(split(",", lookup(var.nexis_storage_account_configuration, var.nexis_storage_type, "")), 1)}"
  nexis_storage_account_kind          = "${element(split(",", lookup(var.nexis_storage_account_configuration, var.nexis_storage_type, "")), 2)}"
}

#############################
# Storage Account for Nexis #
#############################
resource "azurerm_storage_account" "nexis_storage_account" {
  name                      = lower("${var.hostname}${random_string.nexis.result}sa")
  resource_group_name       = var.resource_group_name
  location                  = var.resource_group_location
  account_kind              = local.nexis_storage_account_kind
  account_tier              = local.nexis_storage_performance
  account_replication_type  = local.nexis_storage_replication
  tags                      = var.tags
}

resource "azurerm_private_endpoint" "nexis_storage_account" {
  name                = "${var.hostname}${random_string.nexis.result}-pe"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.hostname}${random_string.nexis.result}-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.nexis_storage_account.*.id[0]
    subresource_names              = ["blob"]
  } 
}

module "nexis_storage_servers" {
  source                          = "../azurevm"
  resource_group_name             = var.resource_group_name
  location                        = var.resource_group_location
  vm_hostname                     = var.hostname
  admin_password                  = var.admin_password
  admin_username                  = var.admin_username
  nb_public_ip                    = var.nexis_storage_vm_number_public_ip
  remote_port                     = var.nexis_storage_vm_remote_port
  nb_instances                    = var.nexis_storage_vm_instances
  base_index                      = var.base_index
  proximity_placement_group_id    = var.proximity_placement_group_id 
  vm_os_simple                    = "Debian"
  vm_os_version                   = "latest"
  vm_size                         = var.nexis_storage_vm_size
  vnet_subnet_id                  = var.subnet_id
  boot_diagnostics                = "false"
  delete_os_disk_on_termination   = "true"
  data_disk                       = "true"
  data_disk_size_gb               = "769"
  data_sa_type                    = "Premium_LRS"
  hide_suffix                     = "true"
  tags                            = var.tags
}

resource "azurerm_virtual_machine_extension" "nexis_storage_servers" {
  name                  = var.hostname
  count                 = var.nexis_storage_vm_instances
  virtual_machine_id    = module.nexis_storage_servers.vm_ids[count.index]
  publisher             = "Microsoft.Azure.Extensions"
  type                  = "CustomScript"
  type_handler_version  = "2.0"
  depends_on            = [module.nexis_storage_servers]
  tags                  = var.tags

  settings = <<EOF
    {
       "commandToExecute": "wget '${local.nexis_storage_vm_script_url}' -O ${local.nexis_storage_vm_script_name} && echo ${var.admin_password} | sudo -S /bin/bash ${local.nexis_storage_vm_script_name} ${var.hostname} ${local.nexis_storage_vm_artifacts_location} ${local.nexis_storage_vm_build} ${local.nexis_storage_vm_part_number}" 
    }
  EOF
}