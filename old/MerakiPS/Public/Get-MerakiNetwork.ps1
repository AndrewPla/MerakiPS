[CmdletBinding()]
param ()

function Get-MerakiNetwork {
<#
	.SYNOPSIS
		Short description
	
	.DESCRIPTION
		Get-MerakiNetworks Function
	
	.PARAMETER ApiKey
		A description of the ApiKey parameter.
	
	.PARAMETER Organization
		Organization that contains the Network/s that you want.
	
	.PARAMETER NetworkId
		A description of the NetworkId parameter.
	
	.EXAMPLE
		PS C:\> <example usage>
		Explanation of what the example does
	
	.OUTPUTS
		Output (if any)
	
	.NOTES
		Created on:   	7/18/2018 2:37 PM
		Edited on:      7/18/2018
		Created by:   	AndrewPla
		Organization:
		Filename:     	Get-MerakiNetworks.ps1
	
	.INPUTS
		Inputs (if any)
#>
	
	[CmdletBinding(DefaultParameterSetName = 'NetworkId',
				   ConfirmImpact = 'Medium',
				   SupportsShouldProcess = $true)]
	[OutputType([pscustomobject], ParameterSetName = 'NetworkId')]
	[OutputType([PSCustomObject])]
	param
	(
		[string]
		$ApiKey,
		
		[Parameter(Mandatory = $false,
				   ValueFromPipeline = $true,
				   ValueFromPipelineByPropertyName = $false)]
		[pscustomobject]
		$Organization,
		
		[Parameter(ParameterSetName = 'NetworkId',
				   Mandatory = $false,
				   ValueFromPipelineByPropertyName = $true)]
		[string]
		$NetworkId
	)
	
	begin {
		Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
        if (-not $ApiKey) {
            if ($Script:StoredApiKey) {
                $ApiKey = $script:StoredApiKey
            }
            else {
                throw 'You must specify an apikey using the apikey parameter or Set-MerakiApiKey'
            }
        }
		$APIUrl = "https://dashboard.meraki.com/api/v0"
		
		$headers = @{
			"X-Cisco-Meraki-API-Key" = "$ApiKey"
		}
	}
	process {
		Write-DebugMessage "[$($MyInvocation.MyCommand.Name)] ParameterSetName: $($PsCmdlet.ParameterSetName)"
		Write-DebugMessage "[$($MyInvocation.MyCommand.Name)] PSBoundParameters: $($PSBoundParameters | Out-String)"
		
		if (-not $PSCmdlet.ShouldProcess("Item")) {
			return
		}
		
		if ($networkId) {
			$uri = $APIUrl + "/networks/$($NetworkId)"
			$Request = Invoke-RestMethod -uri $uri -Method Get -Headers $headers -Verbose
		}
		else {
			$uri = $APIUrl + "/organizations/$($Organization.ID)/networks"
			$Request = Invoke-RestMethod -uri $uri -Method Get -Headers $headers -Verbose
		}
		
		$Request
	}
	end {
		Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
	}
}

