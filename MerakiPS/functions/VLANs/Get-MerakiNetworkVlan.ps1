function Get-MerakiNetworkVlan {
    <#
    .SYNOPSIS
        Returns VLANs for a network
    .DESCRIPTION
        Returns VLANs for a network
    .PARAMETER NetworkId
    Id of the Network. See Get-MerakiNetwork
    .EXAMPLE
        PS C:\> $network | Get-MerakiNetworkVlan
        Returns Vlans for the network in $Network
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
        $NetworkId
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/vlans"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

