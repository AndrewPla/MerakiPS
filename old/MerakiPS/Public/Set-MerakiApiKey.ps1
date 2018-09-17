[CmdletBinding()]
param()

function Set-MerakiApiKey {
    <#
.SYNOPSIS
    Stores the api key in the current session.
.DESCRIPTION
    Stores the api key and allows you to use other commands without having to specify the -apikey parameter.
.EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
.NOTES
    Created on:   	7/30/2018 12:00 PM
    Edited on:      7/30/2018
    Created by:   	AndrewPla
    Organization: 	 
    Filename:     	Set-MerakiApiKey.ps1

#>
    [CmdletBinding(
        ConfirmImpact = 'Low',
        #HelpUri = 'https://psraw.readthedocs.io/en/latest/Module/Set-MerakiApiKey',
        SupportsShouldProcess = $true
    )]
    param
    (
        [Parameter(Mandatory)]
        [SecureString]
        $ApiKey
    )
    begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"
    }
    process {
        Write-DebugMessage "[$($MyInvocation.MyCommand.Name)] ParameterSetName: $($PsCmdlet.ParameterSetName)"
        Write-DebugMessage "[$($MyInvocation.MyCommand.Name)] PSBoundParameters: $($PSBoundParameters | Out-String)"

        if (-not $PSCmdlet.ShouldProcess("Item")) {
            return
        }
        $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($ApiKey)
        $Script:StoredApiKey = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    }
    end {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Complete"
    }
}

