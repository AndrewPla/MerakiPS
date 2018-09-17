function Connect-Meraki {
    <#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.PARAMETER ApiKey
    Your Meraki Api Key. For access to the API, first enable the API for your organization under Organization > Settings > Dashboard API access.

.PARAMETER Register
    Determine if you want to save an encrypted version of the apikey to the registry
.EXAMPLE
    PS C:\> Connect-Meraki -ApiKey $ApiKey -Register
    This stores my Apikey to be reused later.
#>
    [CmdletBinding()]
    param(
        [parameter(Mandatory)]
        [securestring]$ApiKey,

        [switch]
        $Register
    )
    Set-PSFConfig -FullName MerakiPS.ApiKey -Value $ApiKey
    if ($Register) {Register-PSFConfig MerakiPS.ApiKey}
}