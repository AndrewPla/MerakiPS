# Add all things you want to run before importing the main code
foreach ($file in (Get-ChildItem "$ModuleRoot\internal\scripts\tlssetup.ps1" -ErrorAction Ignore)) {
    . Import-ModuleFile -Path $file.FullName
}