<# Custom Script for Windows to install a file from Azure Storage using the staging folder created by the deployment script #>
param (
    [ValidateNotNullOrEmpty()]
    $SigniantMediaShuttleURL,
    [ValidateNotNullOrEmpty()]
    $AvidNEXISClientURL
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
Install-NexisClient {
   
    Write-Log "downloading Nexus Client"
    $NexisDestinationPath = "D:\AzureData\AvidNEXISClient.msi"
    Write-Log $DestinationPath
    DownloadFileOverHttp $AvidNEXISClientURL $NexisDestinationPath

    Start-Process -FilePath $NexisDestinationPath -ArgumentList "/quiet", "/passive", "/norestart" -Wait
    
}

function 
Install-SigniantMediaShuttle {
   
    Write-Log "downloading Signiant Media Shuttle"
    $SigniantDestinationPath = "C:\Users\Public\Desktop\Install_Signiant_Media_Shuttle.exe"

    Write-Log $SigniantDestinationPath
    DownloadFileOverHttp $SigniantMediaShuttleURL $SigniantDestinationPath

}

try {
    $dest = "D:\AzureData"
    New-Item -Path $dest -ItemType directory -Force
    
    Write-Log "Call Install-NexisCLient"
    Install-NexisClient

    Write-Log "Call Install-SigniantMediaShuttle"
    Install-SigniantMediaShuttle
}
catch {
    Write-Error $_
}

