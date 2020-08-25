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

# Deploy to Azure

1) [Optional] Create Resource Group within your subscription directly within Azure Portal.

<br />

2) [Optional] If you don’t have a Vnet yet, either create one Vnet (with at least one subnet) directly within Azure Portal or click on Deploy New Vnet / Subnet below.

<br />

| Module | Compatible Version | ARM Template link |
| ------ | ------------------ | ----------------- |
| Vnet | n/a | <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Favid-technology%2FVideoEditorialInTheCloud%2Fmaster%2FMediaComposer-BYOL%2Fnetworking%2Fnewvnet.json" target="_blank"><img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png" /></a> |

<br />

3) Choose a file transfer accelerator module: Signiant, FileCatalyst or Aspera

<br />

| Module | Compatible Version | ARM Template link |
| ------ | ------------------ | ----------------- |
| Signiant 3.3.2 + Nexis 20.3.1.14 (Client) | - Install_Signiant_SDCX_Server_v3.3.2.exe <br /> - AvidNEXISClient_Win64_20.3.1.14.msi | <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Favid-technology%2FVideoEditorialInTheCloud%2Fmaster%2FMediaComposer-BYOL%2Fsigniant%2Fsigniantazuredeploy.json" target="_blank"><img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png" /></a> |
| FileCatalyst 3.7.3b38 + Nexis 20.3.1.14 (Client) | - install_fc_server.exe <br /> - AvidNEXISClient_Win64_20.3.1.14.msi | (Coming soon) |
| Aspera + Nexis 20.3.1.14 (Client) | - AvidNEXISClient_Win64_20.3.1.14.msi | (Coming soon) |

<br />

4) Choose a Media Composer module depending on the version and GPU selected.

<br />

| Module | Compatible Version | ARM Template link |
| ------ | ------------------ | ----------------- |
| Media Composer 2018.12.11  / 2019.12 / 2020.4 (Nvidia) | - Media_Composer_2018.12.11_Win.zip, Media_Composer_2019.12_Win.zip, Media_Composer_2020.4._Win.zip <br /> - pcoip-agent-graphics_20.04.0.exe <br /> - 442.06_grid_win10_64bit_international_whql.exe <br /> - AvidNEXISClient_Win64_20.3.1.14.msi | <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Favid-technology%2FVideoEditorialInTheCloud%2Fmaster%2FMediaComposer-BYOL%2Fmediacomposer%2Fmediacomposerazuredeploy_NVIDIA_v2.json" target="_blank"><img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png" /></a> |
| Media Composer 2020.4 / 2019.12 (AMD) | - Media_Composer_2020.4._Win.zip <br /> - pcoip-agent-graphics_20.04.0.exe <br /> - Radeon-Pro-Software-for-Enterprise-GA.exe <br /> - AvidNEXISClient_Win64_20.3.1.14.msi | <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Favid-technology%2FVideoEditorialInTheCloud%2Fmaster%2FMediaComposer-BYOL%2Fmediacomposer%2Fmediacomposerazuredeploy_AMD.json" target="_blank"><img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png" /></a> |

<br />

To duplicate the VM, deploy the following ARM template: 

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Favid-technology%2FVideoEditorialInTheCloud%2Fmaster%2FMediaComposer-BYOL%2Fmediacomposer%2Fmediacomposercloning.json" target="_blank"><img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png" /></a>

<br />

5) Deploy a Nexis storage module.

<br />

| Module | Compatible Version | ARM Template link |
| ------ | ------------------ | ----------------- |
| Nexis 20.3.2 | AvidNexisCloud_20.3.2-17.run | <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fssengreleng.blob.core.windows.net%2Fnexisgold%2F20.3.2%2FAzureProvisioning%2Fnexis.nearline%2Fazuredeploy.json" target="_blank"><img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png" /></a> |

<br />