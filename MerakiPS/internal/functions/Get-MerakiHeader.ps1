function Get-MerakiHeader {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)]
        [securestring]
        $ApiKey,

        $ContentType = 'application/json'
    )
    $convertedKey = (New-Object PSCredential "user", $ApiKey).GetNetworkCredential().Password
    @{
        "X-Cisco-Meraki-API-Key" = "$convertedKey"
        "Content-Type" = "$ContentType"
    }
}
