[CmdletBinding()]
param ()

function Get-MerakiClient {
    <#
.SYNOPSIS
    Short description
.DESCRIPTION
    Get-MerakiClient Function
.EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    Created on:   	7/19/2018 2:17 PM
    Edited on:      7/19/2018
    Created by:   	AndrewPla
    Organization: 	 
    Filename:     	Get-MerakiClient.ps1

#>
	[CmdletBinding(
				   ConfirmImpact = 'Medium',
				   #HelpUri = 'https://psraw.readthedocs.io/en/latest/Module/Get-MerakiClient',
				   SupportsShouldProcess = $true
				   )]
	[OutputType([PSCustomObject])]
	param
	(
		[parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName, ValueFromPipeline)]
		[string]
		$Serial,
		
		[parameter(Mandatory = $false)]
		[int]
		$Timespan = 86400,
		
	
		[string]
		$ApiKey
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
		
		$uri = $APIUrl + "/devices/$($Serial)/clients?timespan=$($timespan)"
		$Request = Invoke-RestMethod -uri $uri -Method Get -Headers $headers -Verbose
		$Request
		
	}
	end {
		Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
	}
}

