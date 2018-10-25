function Get-MerakiNetworkTraffic {
    <#
    .SYNOPSIS
        Returns traffic ananlysis for a network
    .DESCRIPTION
        Returns a traffic analysis for the provided device type in the given time frame.
    .EXAMPLE
        PS C:\> $Network | Get-MerakiNetworkTraffic
        returns a traffic analysis for the network in $network
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

        [ValidateRange(0, 44640)]
        $Timespan = 7200,

        [ValidateSet('combined', 'wireless', 'switch', 'appliance')]
        $DeviceType = 'combined'
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/traffic?timespan=$Timespan&deviceType=$DeviceType"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

