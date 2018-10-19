function Get-MerakiApiKey {
    try {Get-PSFConfig MerakiPS.ApiKey -ErrorAction Stop | Select-Object -ExpandProperty Value}
    catch { throw 'Unable to detect an api key. Try running Connect-Meraki and try again.'}
}