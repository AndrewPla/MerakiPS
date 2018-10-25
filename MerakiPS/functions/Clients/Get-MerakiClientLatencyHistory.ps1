function Get-MerakiClientLatencyHistory {
    <#
    .SYNOPSIS
        Return the latency history for a client
    .DESCRIPTION
        The latency data is from a sample of 2% of packets and is grouped into 4 traffic categories: background, best effort, video, voice. Within these categories the sampled packet counters are bucketed by latency in milliseconds.
     .PARAMETER NetworkId
        Id of the Network. See Get-MerakiNetwork
    .PARAMETER ClientId
        Id of the Client. See Get-MerakiClient
    .PARAMETER Timespan
        The timespan in seconds for the data t0 The start time, in seconds from epoch, for the data t1 The end time, in seconds from epoch, for the data
    .EXAMPLE
        PS C:\> $clients | Get-MerakiClientLatencyHistory
        Returns the latency history for al clients in $clients. See Get-MerakiClient to get some clients.
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
        $Timespan = 7200
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/clients/$ClientId/latencyHistory?timespan=$Timespan"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

