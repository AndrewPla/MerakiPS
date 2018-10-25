function Get-MerakiDeviceLldpCdp {
    <#
    .SYNOPSIS
        Lists LLDP and CDP information for a device.
    .DESCRIPTION
        Lists LLDP an CDP information for a given device..
    .PARAMETER NetworkId
        Id of the Network. See Get-MerakiNetwork
    .PARAMETER Timespan
        The timespan for which LLDP and CDP information will be fetched. Must be in seconds and less than or equal to a month (2592000 seconds). LLDP and CDP information is sent to the Meraki dashboard every 10 minutes. In instances where this LLDP and CDP information matches an existing entry in the Meraki dashboard, the data is updated once every two hours. Meraki recommends querying LLDP and CDP information at an interval slightly greater than two hours, to ensure that unchanged CDP / LLDP information can be queried consistently.
    .PARAMETER Serial
        Serial number of the device in the request
    .EXAMPLE
        PS C:\> $devices | Get-MerakiDeviceLldpCdp
        Returns results for all devices in $devices
#>
    [CmdletBinding()]
    param
    (
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName
        )]
        [Alias('Id')]
        $NetworkId,

        [ValidateRange(0, 2592000)]
        [int]
        $Timespan = 7200,

        [Parameter(
            Mandatory,
            ValueFromPipelineByPropertyName
        )]
        $Serial
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/devices/$Serial/lldp_cdp?timespan=$Timespan"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

