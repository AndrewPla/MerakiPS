function Get-MerakiNetworkSSIDL3FirewallRule {
    <#
    .SYNOPSIS
        Returns L3 Firewall Rules for an SSID
    .DESCRIPTION
        returns L3 Firewall Rules for an SSID
    .EXAMPLE
        PS C:\> $SSID | Get-MerakiNetworkSSIDL3FirewallRule
        returns l3 firewall rules for the SSID in $SSid
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

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('number')]
        $SSIDNumber
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/ssids/$SSIDNumber/l3FirewallRules"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

