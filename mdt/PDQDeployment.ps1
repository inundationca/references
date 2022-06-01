netsh advfirewall set allprofiles state off
ipconfig /registerdns

Invoke-Command -ComputerName INU-S00-MDT01.ad.inundation.ca -ScriptBlock { ipconfig /flushdns; pdqdeploy.exe Deploy -Package "Deployment Package" -Targets $args[0] } -ArgumentList "$env:COMPUTERNAME"

# Give PDQ Deploy a chance to start deploying to the device.
Start-Sleep 30

# Continually check if PDQ Deploy is running on the device. Loop until process is completed.
while(test-path "C:\Windows\AdminArsenal\PDQDeployRunner\service-1.lock") {
Start-Sleep 30
}

# Wait another 30 seconds to allow PDQ Inventory to scan the new device.
Start-Sleep 30