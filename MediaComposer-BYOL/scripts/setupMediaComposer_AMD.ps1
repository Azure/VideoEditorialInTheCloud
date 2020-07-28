<#
    .SYNOPSIS
        Configure Windows 10 Workstation with Avid Media Composer.

    .DESCRIPTION
        Configure Windows 10 Workstation with Avid Media Composer.

        Example command line: .\setupMachine.ps1 Avid Media Composer
#>
[CmdletBinding(DefaultParameterSetName = "Standard")]
param(
    [string]
    [ValidateNotNullOrEmpty()]
    $TeradiciKey,
    [ValidateNotNullOrEmpty()]
    $MediaComposerURL,
    [ValidateNotNullOrEmpty()]
    $TeradiciURL,
    [ValidateNotNullOrEmpty()]
    $AvidNEXISClientURL
)

# the windows packages we want to remove
$global:AppxPkgs = @(
    "*windowscommunicationsapps*"
    "*windowsstore*"
)

filter Timestamp {"$(Get-Date -Format o): $_"}

function
Write-Log($message) {
    $msg = $message | Timestamp
    Write-Output $msg
}

function
DownloadFileOverHttp($Url, $DestinationPath) {
    $secureProtocols = @()
    $insecureProtocols = @([System.Net.SecurityProtocolType]::SystemDefault, [System.Net.SecurityProtocolType]::Ssl3)

    foreach ($protocol in [System.Enum]::GetValues([System.Net.SecurityProtocolType])) {
        if ($insecureProtocols -notcontains $protocol) {
            $secureProtocols += $protocol
        }
    }
    [System.Net.ServicePointManager]::SecurityProtocol = $secureProtocols

    # make Invoke-WebRequest go fast: https://stackoverflow.com/questions/14202054/why-is-this-powershell-code-invoke-webrequest-getelementsbytagname-so-incred
    $ProgressPreference = "SilentlyContinue"
    Invoke-WebRequest $Url -UseBasicParsing -OutFile $DestinationPath -Verbose
    Write-Log "$DestinationPath updated"
}

function
Remove-WindowsApps($UserPath) {
    ForEach ($app in $global:AppxPkgs) {
        Get-AppxPackage -Name $app | Remove-AppxPackage -ErrorAction SilentlyContinue
    }
    try {
        ForEach ($app in $global:AppxPkgs) {
            Get-AppxPackage -Name $app | Remove-AppxPackage -User $UserPath -ErrorAction SilentlyContinue
        }
    }
    catch {
        # the user may not be created yet, but in case it is we want to remove the app
    }
    
    #Remove-Item "c:\Users\Public\Desktop\Short_survey_to_provide_input_on_this_VM..url"
}

function
Install-ChocolatyAndPackages {
    
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
           
    Write-Log "choco Install Quicktime"
    choco install -y quicktime

    Write-Log "choco install -y 7zip.install"
    choco install -y 7zip.install

    Write-Log "choco Install Microsoft C++ Redistributions"
    choco install -y vcredist2008
    choco install -y vcredist2012
    choco install -y vcredist2013
    choco install -y vcredist2017

    Write-Log "choco Install Google Chrome"
    choco install -y googlechrome -ignore-checksum

    Write-Log "Enable the Audio service for Windows Server"
    Set-Service Audiosrv -StartupType Automatic
    Start-Service Audiosrv

    Write-Log "Disable ServerManager on Windows Server"
    Get-ScheduledTask -TaskName ServerManager | Disable-ScheduledTask -Verbose
}

function
Install-MediaComposer {
    
    Write-Log "downloading Media Composer"
    # TODO: dynamically generate names based on download usrl
    $DestinationPath = "D:\AzureData\Media_Composer.zip"
    Write-Log $DestinationPath
    DownloadFileOverHttp $MediaComposerURL $DestinationPath
   
    # unzip media composer first
    Write-Log "unzip media composer first"
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory($DestinationPath, "D:\AzureData\")
        
    #PreReqBasePath
    $PreReqBasePath = "D:\AzureData\MediaComposer\Installers\MediaComposer\ISSetupPrerequisites"
                      
    #Install PACE License Support
    Write-Log "Installing PACE License Support"
    New-Item -ItemType Directory -Force -Path "$PreReqBasePath\pace"
    $PaceLicenseSupportExe = "$PreReqBasePath\PACE License Support 5.0.3\License Support Win64.exe"
    Start-Process -FilePath $PaceLicenseSupportExe -ArgumentList "/s", "/x", "/b$PreReqBasePath\pace", "/v/qn" -Wait
    Start-Process -FilePath "$PreReqBasePath\pace\PACE License Support Win64.msi" -ArgumentList "/quiet", "/passive", "/norestart" -Wait

    #Install Sentinel USB Driver
    Write-Log "Installing Sentinel USB Driver"
    New-Item -ItemType Directory -Force -Path "$PreReqBasePath\sentinel"
    Start-Process -FilePath "$PreReqBasePath\Sentinel USB 7.6.9 Driver\Sentinel Protection Installer 7.6.9.exe" -ArgumentList "/s", "/x", "/b$PreReqBasePath\sentinel", "/v/qn" -Wait
    Start-Process -FilePath "$PreReqBasePath\sentinel\Sentinel Protection Installer 7.6.9.msi" -ArgumentList "/quiet", "/passive", "/norestart" -Wait

    #Install Avid Cloud Client Services
    Write-Log "Installing Avid Cloud Client Services"   
    New-Item -ItemType Directory -Force -Path "$PreReqBasePath\avidcloudclientservices"
    Start-Process -FilePath "$PreReqBasePath\Avid Cloud Client Services\Avid_Cloud_Client_Services.exe" -ArgumentList "/s", "/x", "/b$PreReqBasePath\avidcloudclientservices", "/v/qn" -Wait
    Start-Process -FilePath "$PreReqBasePath\avidcloudclientservices\Avid Cloud Client Services.msi" -ArgumentList "/quiet", "/passive", "/norestart" -Wait

    #Install AvidLink
    Write-Log "Installing AvidLink"   
    New-Item -ItemType Directory -Force -Path "$PreReqBasePath\avidlinksetup"
    Start-Process -FilePath "$PreReqBasePath\AvidLink\AvidLinkSetup.exe" -ArgumentList "/s", "/x", "/b$PreReqBasePath\avidlinksetup", "/v/qn" -Wait
    Start-Process -FilePath "$PreReqBasePath\avidlinksetup\Avid Link.msi" -ArgumentList "/quiet", "/passive", "/norestart" -Wait

    #Install media composer first
    Write-Log "Install Media Composer"
    Start-Process -FilePath "D:\AzureData\MediaComposer\Installers\MediaComposer\Avid Media Composer.msi" -ArgumentList "/quiet", "/passive", "/norestart" -Wait
    Write-Log "Finished Installing Media Composer"
}

function
Install-Teradici {
    
    Set-Location -Path "C:\AzureData"
        
    Write-Log "Downloading Teradici"
    $TeradiciDestinationPath = "C:\Users\Public\Desktop\PCoIP_agent_release_installer_graphic.exe"


    Write-Log $DestinationPath
    DownloadFileOverHttp $TeradiciURL $TeradiciDestinationPath   
    
    #Write-Log "Install Teradici"
    #Start-Process -FilePath $TeradiciDestinationPath -ArgumentList "/S", "/NoPostReboot" -Verb RunAs -Wait
    
    #cd "C:\Program Files (x86)\Teradici\PCoIP Agent"

    #Write-Log "Register Teradici"   
    #& .\pcoip-register-host.ps1 -RegistrationCode $TeradiciKey

    #& .\pcoip-validate-license.ps1

    #Write-Log "Restart Teradici Service" 
    #restart-service -name PCoIPAgent
}

function 
Install-NexisClient {
   
    Write-Log "downloading Nexus Client"
    $NexisDestinationPath = "D:\AzureData\AvidNEXISClient.msi"
    Write-Log $DestinationPath
    DownloadFileOverHttp $AvidNEXISClientURL $NexisDestinationPath

    Start-Process -FilePath $NexisDestinationPath -ArgumentList "/quiet", "/passive", "/norestart" -Wait
    
}

try {
    # Set to false for debugging.  This will output the start script to
    # c:\AzureData\CustomDataSetupScript.log, and then you can RDP
    # to the windows machine, and run the script manually to watch
    # the output.
    if ($true) 
    {
        Write-Log("clean-up windows apps")
        Remove-WindowsApps $UserName

        try {
            Write-Log "Installing chocolaty and packages"
            Install-ChocolatyAndPackages
        }
        catch {
            # chocolaty is best effort
        }

        Write-Log "Create Download folder"
        mkdir D:\AzureData

        Write-Log "Call Install-Teradici"
        Install-Teradici

        Write-Log "Call Install-NexisCLient"
        Install-NexisClient

        Write-Log "Call Install-MediaComposer"
        Install-MediaComposer

        Write-Log "Cleanup"
        Remove-Item D:\AzureData -Force  -Recurse -ErrorAction SilentlyContinue
        
        Write-Log "Complete"
 
    }
    else {
        # keep for debugging purposes
        Write-Log "Set-ExecutionPolicy -ExecutionPolicy Unrestricted"
        Write-Log ".\CustomDataSetupScript.ps1 -TeradiciKey $TeradiciKey"
    }
}
catch {
    Write-Error $_
}
