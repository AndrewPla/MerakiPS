function Get-MerakiClient {
    <#
.SYNOPSIS
    Gets the clients of a device
.DESCRIPTION
    Returns clients of a device, up to a maximum of a month ago.
.PARAMETER Serial
    Serial number of the device that you want to receive the clients of.
.PARAMETER Timespan
    The number of seconds back in time you want to look for clients. Maximum value: 2592000 (a month) Default value: 86400
.PARAMETER NetworkId
Id of the network. This will enrich our output with the NetworkId property. This is meant to be used by the pipeline, rather than set by a user.
.EXAMPLE
    PS C:\> Get-MerakiClient -Serial $Serial -TimeSpan 2592000
    Gets all meraki clients from the device with $serial. It will return all devices from the past month.

#>
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [string]
        $Serial,

        [Parameter(Position = 1)]
        [int]$Timespan = 86400,

        [Parameter(ValueFromPipelineByPropertyName)]
        $NetworkId
    )
    begin {
        Write-PSFMessage " Function started" -level debug
    }

    process {
        foreach ($ser in $Serial) {
            Write-PSFMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level Debug
            $uri = "$(Get-MerakiUrl)/devices/$($Serial)/clients?timespan=$($Timespan)"
            $res = Invoke-MerakiMethod -uri $uri
            $res | Add-Member -MemberType NoteProperty -Name NetworkId -Value $NetworkId
            $res
        }
    }
    end {
        Write-PSFMessage "Function complete" -Level Debug
    }
}

