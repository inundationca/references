# Constantin.Lotz@ruv-bkk.de
# Check Storage Spaces Direct Disk
#          
# Dieser Check prüft den Status aller Physical Disks
# und liefert die Summe der gesamten Festplatten
#
# Version 0.2
#
# Changelog: 24.02.2020 -Remove Whitespaces from SerialNumber (by Andreas, afaassl)
# 

# PhysicalDisk
$pdisks = Get-PhysicalDisk | Select FriendlyName, SerialNumber, OperationalStatus, HealthStatus, Usage, Size, AllocatedSize, VirtualDiskFootprint

foreach ($pdisk in $pdisks) {
    if ($pdisk.OperationalStatus -eq "OK" -and $pdisk.HealthStatus -eq "Healthy") {
        # All good
        $status = "0"
        $statusText = "OK - " + $pdisk.SerialNumber + " is in good state. OperationalStatus:" + $pdisk.OperationalStatus + " | HealthStatus:" + $pdisk.HealthStatus + " | SN:" + $pdisk.SerialNumber
    } else {
        $status = "1"
        $statusText = "Warning - " + $pdisk.SerialNumber + " is in unusual state. OperationalStatus:" + $pdisk.OperationalStatus + " | HealthStatus:" + $pdisk.HealthStatus + " | SN:" + $pdisk.SerialNumber
    }
    $perfdataVirtualDisk = "size=" + $pdisk.Size + "|allocatedsize=" + $pdisk.AllocatedSize + "|virtualdiskfootprint=" + $pdisk.VirtualDiskFootprint
    $stringToPost = $status + " S2D_PhysicalDisk_" + $pdisk.SerialNumber + " " + $perfdataVirtualDisk + " " + $statusText
	Write-Host $stringToPost
}