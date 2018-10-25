function Get-MerakiClientGroupPolicy {
    <#
    .SYNOPSIS
        Return the group policy that is assigned to a device in the network
    .DESCRIPTION
        Return the group policy that is assigned to a device in the network
    .PARAMETER NetworkId
        Id of the Network that you want client group policy for. See Get-MerakiNetwork
    .PARAMETER ClientMac
        The MAC address of the client that you want GroupPolicy returned for. See Get-MerakiNetwork
    .PARAMETER TimeSpan
        The timespan for which clients will be fetched. Must be in seconds and less than or equal to a month (2592000 seconds). Default Value is the max value.
    .EXAMPLE
        PS C:\> merakiorg | merakinetwork | MerakiClient | MerakiClientGroupPolicy
        Returns the client group policy for all clients in all networks
#>
    [CmdletBinding()]
    param
    (
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName
        )]
        [Alias('Id')]
        $NetworkId,

        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName
        )]
        [Alias('mac')]
        $ClientMac,

        [int]
        $TimeSpan = 2592000
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/clients/$ClientMac/policy?timespan=$TimeSpan"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

