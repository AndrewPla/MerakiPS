function Invoke-MerakiMethod {
    <#
    .SYNOPSIS
        Sends requests to meraki
    .DESCRIPTION
        This is a wrapper for Invoke-RestMethod. This handles construction the Meraki ApiKey header.
	.PARAMETER ContentType
		type of content in the request. default is 'application/json'
	.PARAMETER Uri
		Uri to send the request to
	.PARAMETER Body
		The body of the request
	.PARAMETER Method
		The method that you want to use. Default is GET
    #>
    [Cmdletbinding()]
    param(
        [string]
        $ContentType = 'application/json',

        [uri]
        $Uri,

        $Body,

        [ValidateSet('Get', 'Set', 'Put', 'Patch', 'Delete', 'Post', 'Head', 'Merge', 'Options')]
        [string]
        $Method = 'Get'
    )
    begin {
        Write-PSFMessage " Function started" -level debug
        if (! $script:__MerakiApiKey) { throw 'No Api Key set. Run Connect-Meraki'}
    }
    process {
        Write-PSFMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level InternalComment
        Write-PSFMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level InternalComment
        $headers = @{
            'X-Cisco-Meraki-API-Key' = $script:__MerakiApiKey
        }

        $Params = @{
            'Method' = $Method
            'Uri' = $Uri
            'Headers' = $Headers
            'ContentType' = $ContentType
        }
        if ($Body) { $Params.add('body', $Body) }
        Write-PSFMessage "Params to be passed to IRM: $($params.Keys -join ",")" -Level InternalComment
        Invoke-RestMethod @Params
    }
    end {
        Write-PSFMessage " Function ended" -level debug
    }
}
