function Get-MerakiUrl {
    [cmdletbinding()]
    param(
        [Parameter(Position = 0, Mandatory)]
        $Endpoint,

        $MerakiApi = 'https://api.meraki.com/api/v0'
    )
    "$MerakiApi" + "$Endpoint"
}