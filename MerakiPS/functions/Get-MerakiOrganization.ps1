function Get-MerakiOrganization {
    <#
	.SYNOPSIS
		Gets the available organizations
	.DESCRIPTION
		Gets the available organizations for your ApiKey.
	
	.PARAMETER ApiKey
	    Your Meraki Api Key. For access to the API, first enable the API for your organization under Organization > Settings > Dashboard API access.
	.EXAMPLE
		PS C:\> Get-MerakiOrganization -ApiKey $ApiKey
		Gets all organizations

#>
	
    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    param
    (
        [securestring]
        $ApiKey
    )
	
    begin {
        Write-PSFMessage "Function Started" -level Debug

        if (-not $ApiKey) {
            try {
                $ApiKey = Get-PSFConfig MerakiPS.ApiKey -ErrorAction Stop | Select-Object -ExpandProperty Value
            }
            catch {throw 'Unable to detect an api key. Try running Connect-Meraki and try again.'}
        }

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
        $uri = $APIUrl + '/organizations'
        $response = Invoke-RestMethod -uri $uri -Method Get -Headers $headers
        foreach ($res in $response) {
            [PSCustomObject]@{
                ID   = $res.id
                Name = $res.name
            }
        }
    }
        
    end {
        Write-PSFMessage "Function Complete" -level debug
    }
}

