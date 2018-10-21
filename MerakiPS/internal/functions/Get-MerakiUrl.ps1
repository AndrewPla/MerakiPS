function Get-MerakiUrl {
    [cmdletbinding()]
    param(
        $MerakiApi = 'https://api.meraki.com/api/v0'
    )
    $MerakiApi
}