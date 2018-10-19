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


	.PARAMETER NetworkName
		Name of the network. This isn't added by the APi, we are enriching the objects so they are more usable.

	.EXAMPLE
		PS C:\> Get-MerakiOrganization | Get-MerakiNetwork |Get-MerakiDevice
		Gets all devices for all networks in your org

#>

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true)]
        [alias('id')]
        [string[]]
        $Network,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [Alias('Name')]
        [string]
        $NetworkName,

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
        foreach ($net in $network) {
            $uri = Get-MerakiUrl "/networks/$($network)/devices"
            $response = Invoke-RestMethod -uri $uri -Method Get -Headers $headers
            foreach ($res in $response) {
                $res | Add-Member -MemberType NoteProperty -Name NetworkName $NetworkName
                $res
                <#[PSCustomObject]@{
                    LanIP       = $res.LanIP
                    Serial      = $res.serial
                    MAC         = $res.MAC
                    Latitude    = $res.Latitude
                    Longitude   = $res.Longitude
                    Address     = $res.Address
                    Name        = $res.Name
                    Model       = $res.Model
                    NetworkID   = $res.networkID
                    NetworkName = $Name
                }#>
            }
        }
    }
    end {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}

