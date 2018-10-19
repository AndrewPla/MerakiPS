function Get-MerakiOrganization {
    <#
	.SYNOPSIS
		Gets the available organizations
	.DESCRIPTION
		Gets the available organizations for your ApiKey.
	.PARAMETER ApiKey
	    Secure string containing your Meraki Api Key. For access to the API, first enable the API for your organization under Organization > Settings > Dashboard API access.
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
        Write-PSFMessage " Function started" -level debug
        if (-not $ApiKey) { $ApiKey = Get-MerakiApiKey }
        $headers = Get-MerakiHeader $ApiKey
    }
    process {
        Write-PSFMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level InternalComment
        Write-PSFMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level InternalComment
        $uri = Get-MerakiUrl '/organizations'
        $res = Invoke-RestMethod -uri $uri -Method Get -Headers $headers
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level debug
    }
}

