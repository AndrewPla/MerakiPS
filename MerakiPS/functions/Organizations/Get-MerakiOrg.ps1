function Get-MerakiOrg {
    <#
	.SYNOPSIS
		Gets the available organizations
	.DESCRIPTION
		Gets the available organizations for your ApiKey.
	.PARAMETER ApiKey
	    Secure string containing your Meraki Api Key. For access to the API, first enable the API for your organization under Organization > Settings > Dashboard API access.
	.EXAMPLE
		PS C:\> Get-MerakiOrg -ApiKey $ApiKey
		Gets all organizations

#>

    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    param
    (
    )

    begin {
        Write-PSFMessage " Function started" -level debug

    }
    process {
        Write-PSFMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level InternalComment
        Write-PSFMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level InternalComment
        $uri = "$(Get-MerakiUrl)/organizations"
        $res = Invoke-MerakiMethod -uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level debug
    }
}

