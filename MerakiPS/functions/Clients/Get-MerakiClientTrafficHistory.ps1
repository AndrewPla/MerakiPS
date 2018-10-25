function Get-MerakiClientTrafficHistory {
    <#
    .SYNOPSIS
        Return the client's network traffic data over time.
    .DESCRIPTION
        Return the client's network traffic data over time. Usage data is in kilobytes.
    .PARAMETER NetworkId
        Id of the Network. See Get-MerakiNetwork
    .PARAMETER ClientId
        Id of the Client. See Get-MerakiClient
    .PARAMETER PerPage
        Specify the number of entries you want returned
    .EXAMPLE
        PS C:\> $clients | Get-MerakiClientTrafficHistory
        Returns traffic history for all clients in $clients
#>
    [CmdletBinding()]
    param
    (
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName
        )]
        $NetworkId,

        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName
        )]
        [Alias('Id')]
        $ClientId,

        [int]
        $PerPage = 10
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/clients/$ClientId/trafficHistory?perPage=$PerPage"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

