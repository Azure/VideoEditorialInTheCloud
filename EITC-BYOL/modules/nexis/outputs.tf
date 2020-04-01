output "virtual_machine_ids" {
  value = "${module.nexis_storage_servers.vm_ids}"
}

output "virtual_machine_private_ips" {
  value = "${module.nexis_storage_servers.network_interface_private_ip}"
}

output "virtual_machine_public_ips" {
  value = "${module.nexis_storage_servers.public_ip_address}"
}

output "virtual_machine_public_ip_dns_name" {
  value = "${module.nexis_storage_servers.public_ip_dns_name}"
}