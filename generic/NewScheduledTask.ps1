$Action = New-ScheduledTaskAction -Execute Powershell.exe  -Argument "PowerShell.exe -ExecutionPolicy Bypass -NoProfile -File \\file\location.ps1"
$Trigger = New-ScheduledTaskTrigger -Weekly -WeeksInterval 1 -DaysOfWeek Monday -At 9am
$Principal = New-ScheduledTaskPrincipal -UserID [username] -LogonType Password
Register-ScheduledTask -TaskName TaskName –Action $Action –Trigger $Trigger –Principal $Principal