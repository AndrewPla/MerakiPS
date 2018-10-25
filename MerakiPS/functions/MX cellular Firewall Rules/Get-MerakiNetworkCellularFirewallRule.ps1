function Get-MerakiNetworkCellularFirewallRule {
    <#
    .SYNOPSIS
        Returns cellular Firewall rules
    .DESCRIPTION
        returns cellular firewall rules for a given network
        .PARAMETER NetworkId
        Id of the Network. See Get-MerakiNetwork
    .EXAMPLE
        PS C:\> $network | Get-MerakiNetworkCellularFirewallRules
        returns rules for $network
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
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/cellularFirewallRules"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

