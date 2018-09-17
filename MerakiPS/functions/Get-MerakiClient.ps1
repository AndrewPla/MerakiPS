function Get-MerakiClient {
<#
.SYNOPSIS
    Gets the clients of a device
.DESCRIPTION
    Returns clients of a device, up to a maximum of a month ago.
.PARAMETER Serial
    Serial number of the device that you want to receive the clients of.
.PARAMETER ApiKey
    Your Meraki Api Key. For access to the API, first enable the API for your organization under Organization > Settings > Dashboard API access.
.PARAMETER Timespan
    The number of seconds back in time you want to look for clients. Maximum value: 2592000 (a month) Default value: 86400
.EXAMPLE
    PS C:\> Get-MerakiClient -Serial $Serial -ApiKey $ApiKey -TimeSpan 2592000
    Gets all meraki clients from the device with $serial. It will return all devices from the past month.
.OUTPUTS
    PSCustomObject
#>
    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    param
    (
        [parameter(Mandatory = $true, Position = 0, ValueFromPipeline)]
        [string]
        $Serial,

        [securestring]$ApiKey,

        [int]$Timespan = 86400
    )
    begin {
        Write-PSFMessage "[$($MyInvocation.MyCommand.Name)] Function started" -Level Debug
        $apiUrl = "https://dashboard.meraki.com/api/v0"
        $headers = @{
            "X-Cisco-Meraki-API-Key" = "$ApiKey"
        }
    }
    process {
        Write-PSFMessage "[$($MyInvocation.MyCommand.Name)] PSBoundParameters: $($PSBoundParameters | Out-String)" -level Debug
        $uri = $apiUrl + "/devices/$($Serial)/clients?timespan=$($Timespan)"
        Invoke-RestMethod -uri $uri -Method Get -Headers $headers -Verbose		
    }
    end {
        Write-PSFMessage "Function complete" -Level Debug
    }
}

