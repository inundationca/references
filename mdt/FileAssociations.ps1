# Load Microsoft.SMS.TSEnvironment COM object
try {
    $TSEnvironment = New-Object -ComObject Microsoft.SMS.TSEnvironment -ErrorAction Stop
}
catch [System.Exception] {
    Write-Warning -Message "Unable to construct Microsoft.SMS.TSEnvironment object" ; exit 1
}
try {
    Write-Host -Value "Getting OS Disk Location."
    $OSDisk = $TSEnvironment.Value("OSDISK")

    Write-Host -Value "OS Disk Location. $($OSDisk)"
    Write-Host -Value "Importing Custom File Associations."
    Dism /online /import-defaultappassociations:$($PSScriptRoot)\DefaultFileAssociation.xml
    Write-Host "Successfully Imported Custom File Associations..."
}
catch [System.Exception] {
    Write-Host "FAILED Applying - Importing Custom File Associations. Error message: $($_.Exception.Message)"
}