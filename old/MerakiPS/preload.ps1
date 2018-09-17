<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2018 v5.5.153
	 Created on:   	7/18/2018 4:37 PM
	 Created by:   	Andrew Pla
	 Organization: 	
	 Filename:     	preload.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

if (-not (Get-Type 'TrustAllCertsPolicy')) {
	add-type @"
using System.Net;
using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {
    public bool CheckValidationResult(
        ServicePoint srvPoint, X509Certificate certificate,
        WebRequest request, int certificateProblem) {
        return true;
    }
}
"@
	$AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
	[System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols
	[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
}