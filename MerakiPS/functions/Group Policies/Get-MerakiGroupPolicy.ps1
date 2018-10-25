function Get-MerakiGroupPolicy {
    <#
    .SYNOPSIS
        Returns group policies
    .DESCRIPTION
        Returns group policies for the provided network
    .PARAMETER NetworkId
        Id of the Network. See Get-MerakiNetwork
    .EXAMPLE
        PS C:\> $Network | Get-MerakiGroupPolicy
        Returns group policeis for $Network
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
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/groupPolicies"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

