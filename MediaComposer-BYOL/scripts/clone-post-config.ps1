param (
    [Parameter(Mandatory=$true, ParameterSetName="Register")][string]$RegistrationCode
)
Start-Sleep 30
& "C:\Program Files\Teradici\PCoIP Agent\pcoip-register-host.ps1" -RegistrationCode $RegistrationCode
rename-computer (Invoke-RestMethod -Headers @{"Metadata"="true"} -uri "http://169.254.169.254/metadata/instance?api-version=2017-08-01" -method Get).compute.name
Start-Sleep 30
Restart-Computer -Force
