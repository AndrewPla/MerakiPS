function Get-MerakiClientDetail {
    <#
    .SYNOPSIS
        Return the client associated with the given identifier.
    .DESCRIPTION
        Return the client associated with the given identifier.
    .PARAMETER NetworkId
        Id of the Network. See Get-MerakiNetwork
    .PARAMETER ClientId
        Id of the Client. See Get-MerakiClient
    .EXAMPLE
        PS C:\> $clients | Get-MerakiClientDetail
        returns additional information for all clients inside $clients
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
        $ClientId)
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/clients/$ClientId"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

