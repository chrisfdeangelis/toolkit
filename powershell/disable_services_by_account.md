##Script for Services Preview
```powershell
Get-CimInstance Win32_Service |
Where-Object { $_.StartName -eq "am/rt_sbx_pmxadmin" } |
Select-Object Name, DisplayName, State, StartMode, StartName
```

##Script for Services
```powershell
$ServiceAccount = "am/rt_sbx_pmxadmin"

$services = Get-CimInstance Win32_Service |
    Where-Object { $_.StartName -eq $ServiceAccount }

if ($services.Count -eq 0) {
    Write-Host "No services found running as '$ServiceAccount'."
    exit
}

foreach ($service in $services) {
    Write-Host "Processing: $($service.Name)"

    # Stop the service if it's running
    if ($service.State -eq "Running") {
        Stop-Service -Name $service.Name -Force -ErrorAction Continue
    }

    # Disable the service
    Set-Service -Name $service.Name -StartupType Disabled

    Write-Host " -> Disabled"
}

Write-Host "`nCompleted."
```
##Script for Scheduled Tasks Preview
```powershell
$TaskAccount = "am/rt_sbx_pmxadmin"

Get-ScheduledTask |
Where-Object { $_.Principal.UserId -eq $TaskAccount } |
Select-Object TaskName, TaskPath, State,
    @{Name="RunAs";Expression={$_.Principal.UserId}}
```

##Script for Scheduled Tasks
```powershell
$TaskAccount = "am/rt_sbx_pmxadmin"

$tasks = Get-ScheduledTask |
    Where-Object { $_.Principal.UserId -eq $TaskAccount }

if (-not $tasks) {
    Write-Host "No scheduled tasks found running as '$TaskAccount'."
    exit
}

foreach ($task in $tasks) {
    Write-Host "Disabling: $($task.TaskPath)$($task.TaskName)"

    Disable-ScheduledTask -TaskName $task.TaskName -TaskPath $task.TaskPath

    Write-Host " -> Disabled"
}

Write-Host "`nCompleted."
```
