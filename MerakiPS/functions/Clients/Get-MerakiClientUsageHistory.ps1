function Get-MerakiClientUsageHistory {
    <#
    .SYNOPSIS
        Return the client's daily usage history. Usage data is in kilobytes.
    .DESCRIPTION
        Return the client's daily usage history. Usage data is in kilobytes.
    .PARAMETER NetworkId
        Id of the Network. See Get-MerakiNetwork
    .PARAMETER ClientId
        Id of the Client. See Get-MerakiClient
    .EXAMPLE
        PS C:\> $Clients | Get-MerakiClientUsageHistory
        Returns the $clients daily usage history
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
        $ClientId
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/clients/$ClientId/usageHistory"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

