function Get-MerakiNetworkStaticRoute {
    <#
    .SYNOPSIS
        Returns static routes
    .DESCRIPTION
        Returns static routes for a given network.
    .PARAMETER NetworkId
    Id of the Network. See Get-MerakiNetwork
    .EXAMPLE
        PS C:\> $Network | Get-MerakiNEtworktaticRoute
        Returns all static routes for the network in $network
#>
    [CmdletBinding()]
    param
    (
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName
        )]
        [Alias('Id')]
        $NetworkId
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/staticRoutes"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

