function Get-MerakiNetworkBluetoothClient {
    <#
    .SYNOPSIS
        Returns bluetooth clients seen by APs on the Network
    .DESCRIPTION
        Returns bluetooth clients seen by APs on the Network.
    .PARAMETER NetworkId
        Id of the Network that you want Bluetooth clients for. See Get-MerakiNetwork
    .PARAMETER PerPage
        Specify the number of entires you want returned
    .PARAMETER TimeSpan
        The time back, in seconds that you want to look back for bluetooth clients. Default Value 7200
    .EXAMPLE
        PS C:\> MerakiOrg | MerakiNetwork | MerakiBluetoothClient
        Returns all bluetooth clients in all network in all Orgs that you have access to.
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
        $NetworkId,

        [int]
        $PerPage = 50,

        [int]
        $Timespan = 7200,

        [Switch]
        $IncludeConnectivityHistory
    )
    begin {
        Write-PsfMessage "Function started" -level verbose
    }
    process {
        Write-PsfMessage "ParameterSetName: $($PsCmdlet.ParameterSetName)" -level internalcomment
        Write-PSfMessage "PSBoundParameters: $($PSBoundParameters | Out-String)" -level internalcomment

        Write-PsfMessage "Constructing a super long Uri, sorry if somebody has to read it." -Level debug
        $uri = "$(Get-MerakiUrl)/networks/$NetworkId/bluetoothClients?perPage=$PerPage&timespan=$Timespan&includeConnectivityHistory=$($IncludeConnectivityHistory.ToBool().ToString().ToLower())"
        $res = Invoke-MerakiMethod -Uri $uri
        $res
    }
    end {
        Write-PSFMessage "Function Complete" -level verbose
    }
}

