# Introduction

These templates stand up Video Editorial in the Cloud on Microsoft Azure.  It is intended to give an insight to the look and feel of a Cloud Video Editorial system running in Azure cloud.  

## Fields

| Name | Description |
|---------------------------------|:-----------------------------------------------------:|
| General-Admin Username | The username that will be used as the administrator user on all VMs. Avid NEXIS VM default admin user is avid|
| General-Admin Password |The password that will be used by the administrator user specified above|
| General-Name Prefix |System Name prefix for all VM resources created for Cloud Edition. 3-char min, 7-char max, lower case alphanumeric|
| General-New or Existing Vnet |Determines whether an existing virtual network will be used or if a new virtual network will be created. New is recommended|
| General-Vnet Name |The name of the virtual network. If new this will be used as the name for the generated network. If existing this virtual network must already exist|
| General-Vnet Resource Group |The resource group where the virtual network resides. If new this should be the same as the resource group specified under Basics. If existing this should be the name of the virtual network where the existing virtual network already exists|  
| General-Subnet Name |The name of the subnet inside of the virtual network. If new this will be the name given to the created subnet. If existing this should be the name of an existing subnet inside of the virtual network.|  
| General-Address Space |The address space used by the virtual network. If creating a new virtual network, it is recommended to use the default.|  
| General-Address Subnet |The address space used by the subnet in the virtual network. It must be a subset of the larger block used above. If creating a new virtual network, it is recommended to use the default|
| Media Composer-Vm Size |The size of the VM that will be used for the Media Composer systems. Refer to Appendix A for verification and quota increases|
| Media Composer-Teradici Key |The license key that will be used to activate the Teradici Graphics Agent|
| Media Composer-Instances |The number of Media Composer VMs to be deployed. A minimum of one VM is required|
| Nexis-Address Static |(optional) The private IP address for the Avid NEXIS. If specified this must be in the address space of the subnet specified above. If not specified a static address is assigned during deployment|
| Signiant-Registration Key |The API key that will be used activate and connect the Signiant Media Shuttle to your account. If an invalid key is provided during the setup refer to the Troubleshooting Guide is Appendix C|
| System-Install URL |The URL for the storage account where the product installers are located. Refer Appendix B to more detail|
| System-Media Composer Client |The filename of Media Composer installer ZIP available in installers blob container. The default may differ from what you provide, so you will need to update accordingly|
| System-Teradici Agent |The filename of Teradici Graphics Agent EXE available in installers blob container. The default may differ from what you provide, so you will need to update accordingly|
| System-Nvidia Driver |The filename of Nvidia GRID drivers EXE available in installers blob container. The default may differ from what you provide, so you will need to update accordingly|
| System-Nexis Windows Client |The filename of the Avid NEXIS Windows Client MSI available in the installers blob container. The default may differ from what you provide, so you will need to update accordingly|
| System-Signiant Client |The filename of the Signiant Media Shuttle TAR.GZ available in the installers blob container. The default may differ from what you provide, so you will need to update accordingly|
| System-Avid Nexis Centos Client |The filename of the Avid NEXIS CentOS Client BIN available in the installers blob container. The default may differ from what you provide, so you will need to update accordingly|

## Deploy to Azure

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FVideoEditorialInTheCloud%2Fmaster%2FmasterDeploy.json" target="_blank"><img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png" /></a>
