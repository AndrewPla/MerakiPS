function Get-MerakiNetworkSyslogServer {
    <#
    .SYNOPSIS
        Returns the syslog servers for a network
    .DESCRIPTION
        Returns the syslog servers for a network
    .PARAMETER NetworkId
    Id of the Network. See Get-MerakiNetwork
    .EXAMPLE
        PS C:\> $network | Get-MerakiNetworkSysloServer
        Returns the syslogs servers for the network in $network
#>
    [CmdletBinding()]
    param
    (
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName
        )]
        [Alias('Id')]
        $NetworkId
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/syslogServers"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

