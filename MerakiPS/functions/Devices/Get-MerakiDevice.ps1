function Get-MerakiDevice {
    <#
	.SYNOPSIS
		Returns devices
	.DESCRIPTION
		Returns devices for the provided Network. See Get-MerakiNetwork
	.PARAMETER NetworkId
		Id of the Network that you want to return the devices for
	.PARAMETER NetworkName
		Name of the network. This field isn't added by the APi, we are enriching the objects so they are more usable by other commands in the pipeline.
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
        [string]
        $NetworkId,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [Alias('Name')]
        [string]
        $NetworkName
    )

    begin {
        Write-PSFMessage " Function started" -level debug
    }
    process {
        Write-PSFMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level InternalComment
        Write-PSFMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level InternalComment
        $uri = "$(Get-MerakiUrl)/networks/$($networkId)/devices"
        $res = Invoke-MerakiMethod -uri $uri
        $res | Add-Member -MemberType NoteProperty -Name NetworkName $NetworkName
        $res

    }
    end {
        Write-PSFMessage "Function Complete" -Level debug
    }
}

