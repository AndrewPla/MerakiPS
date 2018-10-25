function Get-MerakiClientSplashAuthorization {
    <#
    .SYNOPSIS
         Return the splash authorization for a client
    .DESCRIPTION
        Return the splash authorization for a client, for each SSID they've associated with
    .PARAMETER NetworkId
        Id of the Network. See Get-MerakiNetwork
    .PARAMETER ClientMac
        The MAC address of the client that you want GroupPolicy returned for. See Get-MerakiNetwork
    .EXAMPLE
        PS C:\> $clients | Get-MerakiClientSplashAuthorization
        returns the splath authorization for the clients in $clients.
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

        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName
        )]
        [Alias('mac')]
        $ClientMac
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/clients/$ClientMac/splashAuthorizationStatus"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

