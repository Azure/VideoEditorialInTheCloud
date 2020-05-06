#Azure Generic vNet Module
resource "azurerm_resource_group" "network" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name  
  location            = var.location
  address_space       = [var.address_space]
  resource_group_name = azurerm_resource_group.network.name
  dns_servers         = var.dns_servers
  tags                = var.tags
}



resource "azurerm_subnet" "subnet" {
  name                                            = var.subnet_names[count.index]
  virtual_network_name                            = azurerm_virtual_network.vnet.name
  resource_group_name                             = azurerm_resource_group.network.name
  address_prefixes                                = [var.subnet_prefixes[count.index]]
  enforce_private_link_endpoint_network_policies  = (var.subnet_names[count.index] == "storage") ? true : false
  enforce_private_link_service_network_policies   = (var.subnet_names[count.index] == "storage") ? true : false
  count                                           =  length(var.subnet_names)
}

locals {
  subnet_ids = azurerm_subnet.subnet.*.id
}

resource "azurerm_proximity_placement_group" "proximity" {
  name                = "${azurerm_resource_group.network.name}-proximity-group"
  location            = var.location
  resource_group_name = azurerm_resource_group.network.name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "security_group_association" {
  subnet_id                 = local.subnet_ids[0]
  network_security_group_id = azurerm_network_security_group.security_group.id
}

resource "azurerm_network_security_group" "security_group" {
  name                  = var.sg_name 
  location              = var.location
  resource_group_name   = azurerm_resource_group.network.name
  tags                  = var.tags
}

resource "azurerm_network_security_rule" "security_rule_rdp" {
  count                       = var.allow_rdp_traffic ? 1 : 0 
  name                        = "rdp"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.network.name
  network_security_group_name = azurerm_network_security_group.security_group.name
}

resource "azurerm_network_security_rule" "security_rule_ssh" {
  count                       = var.allow_ssh_traffic ? 1 : 0 
  name                        = "ssh"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = var.source_address_prefix
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.network.name
  network_security_group_name = azurerm_network_security_group.security_group.name
}

resource "azurerm_network_security_rule" "security_rule_80" {
  count                       = "1"
  name                        = "http"
  priority                    = 103
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = var.source_address_prefix
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.network.name
  network_security_group_name = azurerm_network_security_group.security_group.name
}

resource "azurerm_network_security_rule" "security_rule_443" {
  count                       = "1"
  name                        = "443"
  priority                    = 104
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = var.source_address_prefix
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.network.name
  network_security_group_name = azurerm_network_security_group.security_group.name
}