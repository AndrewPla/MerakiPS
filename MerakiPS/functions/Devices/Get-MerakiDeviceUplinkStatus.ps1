function Get-MerakiDeviceUplinkStatus {
    <#
    .SYNOPSIS
        Returns device uplink status
    .DESCRIPTION
        Returns device uplink status
    .PARAMETER NetworkId
        Id of the Network. See Get-MerakiNetwork
    .PARAMETER Serial
        Serial number of the device in the request
    .EXAMPLE
        PS C:\> $devices | Get-MerakiDeviceUplinkStatus
        Returns the status of all device in $devices
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

        [Parameter(Mandatory, ValuefromPipelinebypropertyname)]
        $Serial
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/devices/$Serial/uplink"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

