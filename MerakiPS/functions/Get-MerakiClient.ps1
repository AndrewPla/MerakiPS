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
    param
    (
        [parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [string[]]
        $Serial,

        [securestring]$ApiKey,

        [int]$Timespan = 86400,

        [Parameter(ValueFromPipelineByPropertyName, Mandatory)]
        $NetworkId
    )
    begin {
        Write-PSFMessage " Function started" -level debug
        if (-not $ApiKey) { $ApiKey = Get-MerakiApiKey }
        $headers = Get-MerakiHeader $ApiKey
    }

    process {
        foreach ($ser in $Serial) {
            Write-PSFMessage "[$($MyInvocation.MyCommand.Name)] PSBoundParameters: $($PSBoundParameters | Out-String)" -level Debug
            $uri = Get-MerakiUrl "/devices/$($Serial)/clients?timespan=$($Timespan)"
            $response = Invoke-RestMethod -uri $uri -Method Get -Headers $headers
            foreach ($res in $response) {
                [PSCustomObject]@{
                    Usage        = $res.usage
                    ID           = $res.id
                    Description  = $res.description
                    mDNSName     = $res.mdnsname
                    DHCPHostName = $res.dhcphostname
                    MAC          = $res.mac
                    IP           = $res.IP
                    VLAN         = $res.vlan
                    SwitchPort   = $res.switchport
                    NetworkId    = $networkId
                }
            }
        }
    }
    end {
        Write-PSFMessage "Function complete" -Level Debug
    }
}

