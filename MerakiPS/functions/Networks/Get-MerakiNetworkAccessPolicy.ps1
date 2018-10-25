function Get-MerakiNetworkAccessPolicy {
    <#
    .SYNOPSIS
        Returns the access policies (MS)
    .DESCRIPTION
        Returns the access policies (MS)
    .PARAMETER NetworkId
    Id of the Network. See Get-MerakiNetwork
    .EXAMPLE
        PS C:\> $network | Get-MerakiNetworkAccessPolicy
        returns network access policies for $network
#>
    [CmdletBinding()]
    param
    (
        [Parameter(
            Mandatory = $true, ValueFromPipelineByPropertyName
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
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/accessPolicies"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

