#########################
# Input Variables       #
#########################
variable "hostname" {
  description = "description"
}

variable "admin_password" {
  description = "Admin Password for Virtual Machines"
}

variable "admin_username" {
  description = "Admin Username for Virtual Machines"
}

variable "jump_box_vm_number_public_ip" {
  description = "description"
  default = 0
}

variable "jump_box_vm_remote_port" {
  description = "description"
  default = 3389
}

variable "jump_box_vm_instances" {
  description = "description"
}

variable "jump_box_vm_size" {
  description = "description"
}

variable "resource_group_name" {
  description = ""
}

variable "resource_group_location" {
  description = ""
}

variable "subnet_id" {
  description = ""
}

variable "source_address_prefix" {
  description = "CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used."
  default = "*"
}

variable "base_index" {
  description = "Base index"
  default = 0
}

variable "tags" {
  description = "description"
}

#########################
# General Variables     #
#########################
resource "random_string" "mediacomposer" {
    length  = 5
    special = false
    upper   = false
}
