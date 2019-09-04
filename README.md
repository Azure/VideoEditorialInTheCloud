# Introduction

TODO: Give a short introduction of your project. Let this section explain the objectives or the motivation behind this project.

## Getting Started

TODO: Guide users through getting your code up and running on their own system. In this section you can talk about:

1. Installation process
2. Software dependencies
3. Latest releases
4. API references

## Build and Test

TODO: Describe and show how to build your code and run the tests.

## Fields

| Name | Description |
|-----------|:-----------:|
| Resource Group | You can create a new one or use an existing group |
| General Admin Username | You can create a new one or use an existing group |
| General Admin Password | Password for the Administrator account of the NEXIS system |
| General Name Prefix | Specify Avid NEXIS system name. The following constraints applied: between 3 - 8 characters lowercase alphanumeric |
| General New Or Existing Vnet | New if you choose to create a new Virtual Network. Existing if you choose to use Virtual Network that has already been created. (To create a Vnet outside of this form, please go to the Azure portal and create a VNET under the resource group) |
| General Vnet Name | Name of the new or existing Virtual Network (depending on choice above). If you chose Existing above, the name of the Vnet you enter here must match an existing Vnet, or deployment will fail |
| General Vnet Resource Group | Name of the Resource Group where the existing Vnet is deployed. If you chose Existing above, this field must match the name of an existing resource group that contains the Vnet specified in the "Vnet Name" field. If you chose New, enter the name of the Resource Group that you're deploying to. |
| General Subnet Name | If you chose New Vnet above, this will be the name of the new subnet in the new Vnet. If you chose Existing Vnet above, this name should match the existing subnet in that Vnet to which the Media Packs VMs should be deployed, or deployment will fail |
| General Address Space | If you chose New Vnet above, this will be the address space for the Vnet in the form X.X.X.X/Y, with Y as the subnet mask. If you chose Existing Vnet, you can ignore this field |
| General Address Subnet | If you chose New Vnet above, this will be the address subnet for the Vnet in the form X.X.X.X/Y, with Y as the subnet mask. It must be within the Address Space you configured above, or deployment will fail. If you chose Existing Vnet, you can ignore this field |
| Media Composer Vm Size | Size of Media Composer Client VM. (Standard_NV12) |
| Media Composer Teradici Key | Teradici key to activate agent |
| Media Composer Instances | Number of MediaComposer VMs to deploy |
| Nexis Media Pack Count | Number of Mediapack VMs to be created in cluster (Min=1, Max=31) |
| Nexis Storage Account Type | Type of new Storage Accounts (Standard_LRS or Premium_LRS) to be created to store VM disks |
| Nexis Media Disk Size | The size (in GB) of each Media Disk |
| Nexis Private Address Type | (optional) Static |
| Nexis Static Private IP Address | (optional) The static private IP address for the SD. If not specified, it will use whatever address assigned by Azure and make that static. |
| Nexis Deploy Public IPs | Select whether or not you want to deploy resources with Public IP addresses |
| Signiant Vm Size | Size of Signiant Client VM. (Standard_D8_v3) |
| Signiant Registration Key | Signiant Registration Key |
| System Artifacts Location | (optional) Location of the deployment templates |
| System Install Location | (optional) URL to the Avid installation scripts |
| System Nexis Build | (optional) Use default or specify custom Nexis build number |

## Deploy to Azure

Deploy <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FVideoEditorialInTheCloud%2Fmaster%2FmasterDeploy.json" target="_blank"><img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png" /></a>
