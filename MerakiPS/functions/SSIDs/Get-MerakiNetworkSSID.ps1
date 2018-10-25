function Get-MerakiNetworkSSID {
    <#
    .SYNOPSIS
        Returns the SSIDs in a network
    .DESCRIPTION
        Returns the SSIDs in a network
        .PARAMETER NetworkId
        Id of the Network. See Get-MerakiNetwork
    .EXAMPLE
        PS C:\> $network | Get-MerakiNetworkSSID
        returns the SSIDs in $network
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

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('name')]
        $NetworkName
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/ssids"
        $res = Invoke-MerakiMethod -Uri $uri
        $res | Add-Member -MemberType NoteProperty -Name NetworkName -Value $NetworkName
        $res | Add-Member -MemberType NoteProperty -Name NetworkId -Value $NetworkId

        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

