function Get-MerakiNetworkL3FirewallRule {
    <#
    .SYNOPSIS
        Return L3 Firewall Rules
    .DESCRIPTION
        Return L3 Firewall Rules for a given network
    .PARAMETER NetworkId
        Id of the Network. See Get-MerakiNetwork
    .EXAMPLE
        PS C:\> $network | Get-MerakiNetworkL3FirewallRule
        Returns L3 Firewall Rule for the network in $network
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
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/l3FirewallRules"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}
