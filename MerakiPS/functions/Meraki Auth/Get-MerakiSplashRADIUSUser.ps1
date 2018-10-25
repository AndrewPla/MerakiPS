function Get-MerakiSplashRADIUSUser {
    <#
    .SYNOPSIS
        returns splash or RADIUS users
    .DESCRIPTION
        returns splash or RADIUS users
        .PARAMETER NetworkId
        Id of the Network. See Get-MerakiNetwork
    .EXAMPLE
        PS C:\> $networks | Get-MerakiSplashRADIUSUser
        Returns splash and RADIUS users for all networks in $networks
#>
    [CmdletBinding()]
    param
    (
        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'NetworkId',
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
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/merakiAuthUsers"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

