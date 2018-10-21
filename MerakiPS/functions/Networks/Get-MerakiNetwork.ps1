function Get-MerakiNetwork {
    <#
	.SYNOPSIS
		Returns Meraki networks
	.DESCRIPTION
		Returns Meraki networks
	.PARAMETER Organization
		Organization that contains the Network/s that you want.
	.EXAMPLE
        PS C:\> Get-MerakiOrg | Get-MerakiNetwork
        Grabs all networks inside the organization returned via Get-MerakiOrg
#>

    [CmdletBinding()]
    param
    (

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [Alias("id")]
        $OrganizationID
    )

    begin {
        Write-PSFMessage " Function started" -level debug
    }
    process {
        Write-PSFMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level Debug
        Write-PSFMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level Debug
        $uri = "$(Get-MerakiUrl)/organizations/$OrganizationID/networks"
        $res = Invoke-MerakiMethod -uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -Level Debug
    }
}
