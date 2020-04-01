/*
output "azurerm_resource_group_id" {
  value       = "${module.editorial_networking.azurerm_resource_group_id}"
  description = "The ID of resource group created"
}
*/
output "azurerm_resource_group_name" {
  value       = "${module.editorial_networking.azurerm_resource_group_name}"
  description = "The name of resource group created"
}
output "azurerm_resource_group_location" {
  value       = "${module.editorial_networking.azurerm_resource_group_location}"
  description = "The location/region of resource group created"
}
output "azurerm_virtual_network_id" {
  value       = "${module.editorial_networking.vnet_id}"
  description = "The virtual Network Configuration ID"
}
output "azurerm_virtual_network_name" {
  value       = "${module.editorial_networking.vnet_name}"
  description = "The name of the virtual network"
}

output "azurerm_virtual_network_location" {
  value       = "${module.editorial_networking.vnet_location}"
  description = "The location/region where the virtual network is created"
}
output "azurerm_virtual_network_address_space" {
  value       = "${module.editorial_networking.vnet_address_space}"
  description = "The address space that is used the virtual network"
}
output "azurerm_subnet_ids" {
  value       = "${module.editorial_networking.vnet_subnets}"
  description = "The subnet IDs for the VNET"
}

output "jump_box_virtual_machine_ids" {
  value = "${module.jump_box_deployment.virtual_machine_ids}"
}

output "jump_box_virtual_machine_private_ips" {
  value = "${module.jump_box_deployment.virtual_machine_private_ips}"
}

output "jump_box_virtual_machine_public_ips" {
  value = "${module.jump_box_deployment.virtual_machine_public_ips}"
}

output "jump_box_virtual_machine_public_ip_dns_name" {
  value = "${module.jump_box_deployment.virtual_machine_public_ip_dns_name}"
}

output "media_composer_virtual_machine_ids" {
  value = "${module.media_composer_deployment.virtual_machine_ids}"
}

output "media_composer_virtual_machine_private_ips" {
  value = "${module.media_composer_deployment.virtual_machine_private_ips}"
}

output "media_composer_virtual_machine_public_ips" {
  value = "${module.media_composer_deployment.virtual_machine_public_ips}"
}

output "media_composer_virtual_machine_public_ip_dns_name" {
  value = "${module.media_composer_deployment.virtual_machine_public_ip_dns_name}"
}

output "nexis_virtual_machine_ids" {
  value = "${module.nexis_deployment.virtual_machine_ids}"
}

output "nexis_virtual_machine_private_ips" {
  value = "${module.nexis_deployment.virtual_machine_private_ips}"
}

output "nexis_virtual_machine_public_ips" {
  value = "${module.nexis_deployment.virtual_machine_public_ips}"
}

output "nexis_virtual_machine_public_ip_dns_name" {
  value = "${module.nexis_deployment.virtual_machine_public_ip_dns_name}"
}
