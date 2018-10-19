function Get-MerakiHeader {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)]
        [securestring]
        $ApiKey
    )
    $convertedKey = (New-Object PSCredential "user", $ApiKey).GetNetworkCredential().Password
    @{
        "X-Cisco-Meraki-API-Key" = "$convertedKey"
        "Content-Type" = 'application/json'
    }
}
