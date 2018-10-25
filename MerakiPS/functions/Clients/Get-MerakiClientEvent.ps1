function Get-MerakiClientEvent {
    <#
    .SYNOPSIS
        Return a client events
    .DESCRIPTION
        Return a client events
    .PARAMETER ClientId
        Id of the Client. See Get-MerakiClient
    .PARAMETER Timespan
        The timespan in seconds for the data t0 The start time, in seconds from epoch, for the data t1 The end time, in seconds from epoch, for the data
    .PARAMETER PerPage
        Specify the number of entries you want returned
    .EXAMPLE
        PS C:\> $clients | Get-MerakiClientEvent
        Returns client events for all clients in $clients
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
        $PerPage = 50
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/clients/$Clientmac/events?perPage=$Perpage"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

