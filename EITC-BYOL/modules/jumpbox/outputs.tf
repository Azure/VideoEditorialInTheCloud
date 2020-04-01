output "virtual_machine_ids" {
  value = "${module.jump_box.vm_ids}"
}

output "virtual_machine_private_ips" {
  value = "${module.jump_box.network_interface_private_ip}"
}

output "virtual_machine_public_ips" {
  value = "${module.jump_box.public_ip_address}"
}

output "virtual_machine_public_ip_dns_name" {
  value = "${module.jump_box.public_ip_dns_name}"
}
