function Get-MerakiNetworkSitetoSiteVpn {
    <#
    .SYNOPSIS
        returns site-to-site VPN settings
    .DESCRIPTION
        returns site-to-site VPN
    .PARAMETER NetworkId
    Id of the Network. See Get-MerakiNetwork
    .EXAMPLE
        PS C:\> Get-MerakiNetwork | Get-MerakiNetworkSitetoSiteVpn
        returns site-to-site vpn settings for all networks
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
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/siteToSiteVpn"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}
