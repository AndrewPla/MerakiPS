function Get-MerakiNetwork {
    <#
	.SYNOPSIS
		Returns Meraki networks
	
	.DESCRIPTION
		Returns Meraki networks 
	
	.PARAMETER ApiKey
		Your Meraki Api Key. For access to the API, first enable the API for your organization under Organization > Settings > Dashboard API access.
	
	.PARAMETER Organization
		Organization that contains the Network/s that you want.

	.EXAMPLE
        PS C:\> Get-MerakiNetwork -OrganizationID $OrgID
        Grabs all networks inside the organization specified within $OrgID
		Explanation of what the example does
#>
	
    [CmdletBinding()]
    
    param
    (
        [securestring]
        $ApiKey,
		
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [Alias("ID")]
        $OrganizationID
    )
	
    begin {
        Write-PSFMessage "Function Started" -Level Debug

        if (-not $ApiKey) {
            try {
                $ApiKey = Get-PSFConfig MerakiPS.ApiKey -ErrorAction Stop | Select-Object -ExpandProperty Value
            }
            catch {throw 'Unable to detect an api key. Try running Connect-Meraki and try again.'}
        }

        $apiUrl = "https://api.meraki.com/api/v0/"
        $convertedKey = (New-Object PSCredential "user", $ApiKey).GetNetworkCredential().Password
        $headers = @{
            "X-Cisco-Meraki-API-Key" = "$convertedKey"
            "Content-Type"           = 'application/json'
        }
    }
    process {
        Write-PSFMessage "[$($MyInvocation.MyCommand.Name)] ParameterSetName: $($PsCmdlet.ParameterSetName)" -level Debug
        Write-PSFMessage "[$($MyInvocation.MyCommand.Name)] PSBoundParameters: $($PSBoundParameters | Out-String)" -level Debug
        $uri = $apiUrl + "/organizations/$OrganizationID/networks"
        $response = Invoke-RestMethod -uri $uri -Method Get -Headers $headers
        foreach($res in $response){
            [PSCustomObject]@{
                ID = $res.id
                OrganizationID = $res.OrganizationID
                Name = $res.Name
                Timezone = $res.Timezone
                Tags = $res.Tags
                Type = $res.Type
                DisableMyMerakiCom = $res.disableMyMerakiCom
            }
        }
    }
    end {
        Write-PSFMessage "Function Complete" -Level Debug
    }
}
