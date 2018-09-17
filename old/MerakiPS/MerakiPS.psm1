$script:PSModuleRoot = $PSScriptRoot
Write-Verbose "PSScriptRoot: $PSScriptRoot"

$functionFolders = @('public', 'private')

& "$PSModuleRoot\preload.ps1"

ForEach ($folder in $FunctionFolders) {
	Write-Verbose "Processing $folder"
	$folderPath = Join-Path -Path $PSScriptRoot -ChildPath $folder
	Write-Verbose "FolderPath = $folderPath"
	if (Test-Path -Path $folderPath) {
		Write-Verbose -Message "Importing from $folder"
		$functions = Get-ChildItem -Path $folderPath -Filter '*.ps1' -Recurse
		foreach ($function in $functions) {
			Write-Verbose -Message "  Importing $($function.fullname)"
			. $function.fullname
		}
		
	}
	else {
		Write-Verbose "$Folderpath doesn't exist"
	}
}
$publicFunctions = (Get-ChildItem -Path "$PSScriptRoot\Public" -Filter '*.ps1').BaseName
Export-ModuleMember -Function $publicFunctions
