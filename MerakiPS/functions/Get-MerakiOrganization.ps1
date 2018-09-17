
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
		
        [securestring]
        $ApiKey,
		
        [string]
        $OrganizationId
    )
	
    begin {
        Write-PSFMessage "Function Started" -level Debug
        $apiUrl = "https://api.meraki.com/api/v0"
        $convertedKey = (New-Object PSCredential "user", $ApiKey).GetNetworkCredential().Password
        $headers = @{
            "X-Cisco-Meraki-API-Key" = "$convertedKey"
            "Content-Type"           = 'application/json'
        }
    }

    process {
        Write-PSFMessage "[$($MyInvocation.MyCommand.Name)] ParameterSetName: $($PsCmdlet.ParameterSetName)" -level Debug
        Write-PSFMessage "[$($MyInvocation.MyCommand.Name)] PSBoundParameters: $($PSBoundParameters | Out-String)" -level Debug
		
        if ($OrganizationId) {
            $uri = $APIUrl + "/organizations/$($organizationId)"
            $Request = Invoke-RestMethod -uri $uri -Method Get -Headers $headers -Verbose
            [pscustomobject]@{
                "ID"   = $Request.ID
                "Name" = $Request.Name
            }
        }
        else {
            $uri = $apiUrl + "/organizations"
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
        Write-PSFMessage "Function Complete" -level debug
    }
}

