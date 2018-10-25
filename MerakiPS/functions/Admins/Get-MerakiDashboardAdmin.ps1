function Get-MerakiDashboardAdmin {
    <#
.SYNOPSIS
    Rturns meraki dashboard admins
.DESCRIPTION
    returns a list of dashboard admins
.EXAMPLE
    PS C:\> Get-MerakiOrg | Get-MerakiDashboardAdmin
    Returns dashboard admins for the Org returned with Get-MerakiOrg
#>
    [CmdletBinding()]

    param
    (
        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'OrganizationId',
            ValueFromPipelineByPropertyName
        )]
        [Alias('Id')]
        $OrganizationId
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/organizations/$OrganizationId/admins"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

