variable "vm_os_simple" {
  default = ""
}

# Definition of the standard OS with "SimpleName" = "publisher,offer,sku"
variable "standard_os" {
  default = {
    "UbuntuServer"  = "Canonical,UbuntuServer,16.04-LTS"
    "WindowsServer" = "MicrosoftWindowsServer,WindowsServer,2016-Datacenter"
    "Desktop"       = "MicrosoftWindowsDesktop,Windows-10,rs5-pro"
    "RHEL"          = "RedHat,RHEL,7.5"
    "openSUSE-Leap" = "SUSE,openSUSE-Leap,42.2"
    "CentOS"        = "OpenLogic,CentOS,7.7"
    "Debian"        = "credativ,Debian,8"
    "CoreOS"        = "CoreOS,CoreOS,Stable"
    "SLES"          = "SUSE,SLES,12-SP2"
  }
}
