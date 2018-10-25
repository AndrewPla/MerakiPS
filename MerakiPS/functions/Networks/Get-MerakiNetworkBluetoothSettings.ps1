function Get-MerakiNetworkBluetoothSettings {
    <#
    .SYNOPSIS
        Returns a networks bluetooth settings
    .DESCRIPTION
        Returns a networks bluetooth settings. This will return either true or false for scanningEnabled and advertisingEnabled.
    .PARAMETER NetworkId
    Id of the Network. See Get-MerakiNetwork
    .EXAMPLE
        PS C:\> $network | Get-MerakiNetworkBluetoothSettings
        Returns the bluetooth settings of $network
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
        $NetworkId)
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/bluetoothSettings"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

