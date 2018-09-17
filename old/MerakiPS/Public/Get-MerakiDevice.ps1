[CmdletBinding()]
param ()

function Get-MerakiDevice {
    <#
	.SYNOPSIS
		Short description
	
	.DESCRIPTION
		Get-MerakiDevices Function
	
	.PARAMETER Network
		A description of the Network parameter.
	
	.PARAMETER apikey
		A description of the apikey parameter.
	
	.PARAMETER serial
		A description of the serial parameter.
	
	.EXAMPLE
		PS C:\> <example usage>
		Explanation of what the example does
	
	.OUTPUTS
		Output (if any)
	
	.NOTES
		Created on:   	7/18/2018 3:00 PM
		Edited on:      7/18/2018
		Created by:   	AndrewPla
		Organization:
		Filename:     	Get-MerakiDevices.ps1
	
	.INPUTS
		Inputs (if any)
#>
	
    [CmdletBinding(ConfirmImpact = 'Medium',
        SupportsShouldProcess = $true)]
    [OutputType([PSCustomObject])]
    param
    (
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true)]
				   [alias('id')]
        [pscustomobject]
        $Network,
		
        [string]
        $ApiKey,
		
        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [string]
        $Serial
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
		
        if ($Serial) {
            $uri = $APIUrl + "/networks/$($Network)/devices/$($serial)"
            $Request = Invoke-RestMethod -uri $uri -Method Get -Headers $headers -Verbose
        }
        else {
            $uri = $APIUrl + "/networks/$($Network)/devices"
            $Request = Invoke-RestMethod -uri $uri -Method Get -Headers $headers -Verbose
        }
		
        $Request | Add-Member -MemberType NoteProperty -Name 'NetworkName' -Value $Network.Name
        $Request
    }
    end {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}

