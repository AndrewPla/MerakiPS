function Get-MerakiDevicePerformance {
    <#
    .SYNOPSIS
        Returns the performance score for a device (MX)
    .DESCRIPTION
         Return the performance scorefor a device (MX)
    .PARAMETER NetworkId
    Id of the Network. See Get-MerakiNetwork
    .PARAMETER Serial
        Serial number of the device in the request
    .EXAMPLE
        PS C:\> $devices | Get-MerakiDevicePerformance
        returns the performance score for all devices in $devices
    .Notes
        See https://documentation.meraki.com/MX/Monitoring_and_Reporting/Device_Utilization for more
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
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/devices/$Serial/performance"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

