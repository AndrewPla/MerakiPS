function Connect-Meraki {
    <#
.SYNOPSIS
    Prepares PowerShell to use the Meraki api
.DESCRIPTION
    Creates the header to be used by all other commands.
.PARAMETER ApiKey
    Your Meraki Api Key. For access to the API, first enable the API for your organization under Organization > Settings > Dashboard API access.
.EXAMPLE
    PS C:\> Connect-Meraki -ApiKey $ApiKey
    This stores my Apikey to be reused later.
#>
    [CmdletBinding()]
    param(
        [parameter(Mandatory)]
        [securestring]$ApiKey
    )
    $cred = New-Object System.Management.Automation.PSCredential ("username", $ApiKey)
    $Script:__MerakiApiKey = "$($cred.GetNetworkCredential().password)"
}
