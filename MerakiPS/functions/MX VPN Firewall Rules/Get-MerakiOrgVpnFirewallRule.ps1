function Get-MerakiOrgVpnFirewallRule {
    <#
    .SYNOPSIS
         Return the firewall rules for an organization's site-to-site VPN
    .DESCRIPTION
         Return the firewall rules for an organization's site-to-site VPN
    .PARAMETER OrgId
    Id of the Org. See Get-MerakiOrg
    .EXAMPLE
        PS C:\> Get-MerakiOrg | Get-MerakiOrgVpnFirewallRule
        returns vpn firewall rules for the org
#>
    [CmdletBinding()]
    param
    (
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName
        )]
        [Alias('Id')]
        $OrgId
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/organizations/$OrgId/vpnFirewallRules"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

