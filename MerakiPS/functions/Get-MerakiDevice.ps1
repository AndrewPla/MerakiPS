function Get-MerakiDevice {
    <#
	.SYNOPSIS
		Short description
	
	.DESCRIPTION
		Get-MerakiDevices Function
	
	.PARAMETER Network
		A description of the Network parameter.
	
	.PARAMETER ApiKey
        Your Meraki Api Key. For access to the API, first enable the API for your organization under Organization > Settings > Dashboard API access.

	
	.PARAMETER serial
		A description of the serial parameter.
	
	.EXAMPLE
		PS C:\> <example usage>
		Explanation of what the example does

#>
	
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true)]
        [alias('id')]
        [string[]]
        $Network,
		
        [securestring]
        $ApiKey
    )
	
    begin {
        Write-PSFMessage " Function started" -level debug

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
        foreach ($net in $network) {
            $uri = $apiUrl + "/networks/$($Network)/devices"
            $response = Invoke-RestMethod -uri $uri -Method Get -Headers $headers
            foreach ($res in $response) {
                [PSCustomObject]@{
                    LanIP     = $res.LanIP
                    Serial    = $res.serial
                    MAC       = $res.MAC
                    Latitude  = $res.Latitude
                    Longitude = $res.Longitude
                    Address   = $res.Address
                    Name      = $res.Name
                    Model     = $res.Model
                    NetworkID = $res.networkID
                }
            }
        }
    }
    end {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}

