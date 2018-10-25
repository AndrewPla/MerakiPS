function Get-MerakiNetworkAirMarshScan {
    <#
    .SYNOPSIS
        Returns airh marshal scan results for a network
    .DESCRIPTION
        returns air marshal scan results for a network
    .PARAMETER NetworkId
    Id of the Network. See Get-MerakiNetwork
    .PARAMETER Timespan
    The timespan, in seconds, for which results will be fetched. Can't be more than 1 month. Default value is 3600 seconds
    .EXAMPLE
        PS C:\> $network | Get-MerakiNetworkAirMarshScan
        returns the scan results for the network inside $network
#>
    [CmdletBinding()]
    param
    (
        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'NetworkId',
            ValueFromPipelineByPropertyName
        )]
        [Alias('Id')]
        $NetworkId,

        [int]
        $Timespan = 3600
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/airMarshal/?timespan=$Timespan"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

