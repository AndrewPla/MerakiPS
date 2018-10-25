function Get-MerakiClientSecurityEvent {
    <#
    .SYNOPSIS
         Return a client security events
    .DESCRIPTION
         Return a client security events
    .EXAMPLE
        PS C:\> $clients | Get-MerakiClientSecurityEvent
        returns security events for all clients in $clients
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
        $PerPage = 10,

        [int]$Timespan = 7200
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/clients/$ClientId/securityEvents?perPage=$PerPage&timespan=$Timespan"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

