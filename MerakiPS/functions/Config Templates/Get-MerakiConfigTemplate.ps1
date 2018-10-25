function Get-MerakiConfigTemplate {
    <#
    .SYNOPSIS
        List the config templates
    .DESCRIPTION
        Returns config templates for the provided org.
    .PARAMETER OrganizationId
    Id of the Organization. See Get-MerakiOrganization
    .EXAMPLE
        PS C:\> Get-MerakiOrg | Get-MerakiConfigTemplate
        Returns config templates for the org returned.
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
        $uri = "$(Get-MerakiUrl)/organizations/$OrganizationId/configTemplates"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

