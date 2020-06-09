# Deploy to Azuree


| Module | Compatible Version | ARM Template link |
| ------ | ------------------ | ----------------- |
| Signiant + Nexis (Client) | Install_Signiant_SDCX_Server_v3.3.2.exe | <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbenjamin-ghis%2FVideoEditorialInTheCloud%2Fmaster%2FMediaComposer-BYOL%2FDeploy_Signiant.json" target="_blank"><img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png" /></a> |
| FileCatalyst + Nexis (Client) |  | |
| Media Composer (Nvidia) | Media_Composer_2020.4._Win.zip | <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbenjamin-ghis%2FVideoEditorialInTheCloud%2Fmaster%2FMediaComposer-BYOL%2FDeploy_MediaComposer_NVIDIA.json" target="_blank"><img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png" /></a> |
| Media Composer (Nvidia) | Media_Composer_2018.12.3_Win.zip | <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbenjamin-ghis%2FVideoEditorialInTheCloud%2Fmaster%2FMediaComposer-BYOL%2FmediaComposer%2Fmediacomposerazuredeploy_NVIDIA_2018123.json" target="_blank"><img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png" /></a> |
| Media Composer (AMD) | Media_Composer_2020.4._Win.zip | <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbenjamin-ghis%2FVideoEditorialInTheCloud%2Fmaster%2FMediaComposer-BYOL%2FDeploy_MediaComposer_AMD.json" target="_blank"><img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png" /></a> |
| Nexis | AvidNexisCloud_20.3.2-17.run | <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbenjamin-ghis%2FVideoEditorialInTheCloud%2Fmaster%2FMediaComposer-BYOL%2FDeploy_Nexis.json" target="_blank"><img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png" /></a> |


0) Create New Resource Group.

1) Deploy New Vnet / Subnet (bypass if you already have one): <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbenjamin-ghis%2FVideoEditorialInTheCloud%2Fmaster%2FMediaComposer-BYOL%2FDeploy_Vnet.json" target="_blank"><img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png" /></a>

2) Deploy a transfer solution module:

- Signiant <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbenjamin-ghis%2FVideoEditorialInTheCloud%2Fmaster%2FMediaComposer-BYOL%2FDeploy_Signiant.json" target="_blank"><img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png" /></a>

- FileCatalyst (available soon)

3) Deploy Media Composer module:

- with Nvidia Driver <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbenjamin-ghis%2FVideoEditorialInTheCloud%2Fmaster%2FMediaComposer-BYOL%2FDeploy_MediaComposer_NVIDIA.json" target="_blank"><img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png" /></a>

- With AMD Driver <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbenjamin-ghis%2FVideoEditorialInTheCloud%2Fmaster%2FMediaComposer-BYOL%2FDeploy_MediaComposer_AMD.json" target="_blank"><img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png" /></a>

4) Deploy Nexis module <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fbenjamin-ghis%2FVideoEditorialInTheCloud%2Fmaster%2FMediaComposer-BYOL%2FDeploy_Nexis.json" target="_blank"><img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png" /></a>

# Abstract

This readme file explains the value of video editorial in the cloud using Avid Media Composer and Avid Nexis on Microsoft Azure and summarizes key resources in this repository: a deployment guide and deployment scripts. The deployment guide included in this repository explains, step-by-step, how to deploy these applications into your Azure subscription.  The deployment guide and accompanying scripts are designed for media production companies that want to provide an edit-on-demand deployment experience.

# Summary

The cloud will transform how creatives in the Media and Entertainment Industry produce content and collaborate across teams and geographies.  Despite the dramatic potential of the cloud to transform the industry, many creative individuals, teams and companies are not sure how or where to begin their cloud journey.  Microsoft and Avid Technologies have worked jointly on many cloud editorial projects and projects enabling major media companies to migrate their video production workflows to Azure.  We have found the most empowering approach is to learn by doing, ie. Just start experimenting, hands-on, with how Avid on Azure enables cloud-based content production.

The deployment guide and accompanying scripts in this repository enable that hands-on experimentation.  The deployment guide provides step-by-step guidance for installing and configuring a proof of concept environment for you and or your team to immediately deploy and use Avid’s industry leading products – Media Composer and Nexis – for content editing on the Azure Cloud.

# Capabilities of this Solution

Once you have deployed this solution you can

Upload video content to Nexis on Azure

Edit video content using Media Composer on Azure

Back up your video content to Nexis on Azure.

# What is Deployed as part of this Solution

<img src="./diagram.png" />
