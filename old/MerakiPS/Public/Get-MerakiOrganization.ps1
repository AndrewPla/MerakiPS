[CmdletBinding()]
param ()

function Get-MerakiOrganization {
    <#
	.SYNOPSIS
		Gets the Organizations available to the provided ApiKey
		.DESCRIPTION
		Gets the Organizations available to the provided ApiKey
	
	.PARAMETER ApiKeY
	A description of the ApiKey parameter
	
	.EXAMPLE
		PS C:\> <example usage>
		Explanation of what the example does
	
	.OUTPUTS
		Output (if any)
	
	.NOTES
		Created on:   	7/18/2018 2:23 PM
		Edited on:      7/18/2018
		Created by:   	AndrewPla
		Organization:
		Filename:     	Get-MerakiOrganization.ps1
	
	.INPUTS
		Inputs (if any)
#>
	
    [CmdletBinding(ConfirmImpact = 'Medium',
        SupportsShouldProcess = $true)]
    [OutputType([PSCustomObject])]
    param
    (
		
        [string]
        $ApiKey,
		
        [string]
        $OrganizationId
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
		
        if ($OrganizationId) {
            $uri = $APIUrl + "/organizations/$($organizationId)"
            $Request = Invoke-RestMethod -uri $uri -Method Get -Headers $headers -Verbose
			
            [pscustomobject]@{
                "OrganizationID"   = $Request.ID
                "OrganizationName" = $Request.Name
            }
        }
        else {
            $uri = $APIUrl + "/organizations"
            $Request = Invoke-RestMethod -uri $uri -Method Get -Headers $headers -Verbose
			
            foreach ($item in $Request) {
                [PSCustomObject]@{
                    "ID"   = $item.ID
                    "Name" = $item.Name
                }
            }
        }
		
		
    }
    end {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}

