# Steps for Service Account PW Rotation
___

## 1 - Disable All Services running as service account

### Preview services

```powershell
Get-CimInstance Win32_Service |
Where-Object { $_.StartName -eq "AM\rt_sbx_pmxadmin" } |
Select-Object Name, DisplayName, State, StartMode, StartName
```

### Disable services

```powershell
$ServiceAccount = "AM\rt_sbx_pmxadmin"

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

### Process Refuses to stop

```powershell
Get-CimInstance Win32_Service |
Where-Object Name -eq "MatrikonOPC Tunneller SSC" |
Select-Object Name, ProcessId, State
```
```powershell
Stop-Process -Id <PID> -Force
```
___

## 2 - Disable scheduled tasks

### Preview scheduled tasks

```powershell
$TaskAccount = "AM\rt_sbx_pmxadmin"

Get-ScheduledTask |
Where-Object { $_.Principal.UserId -eq $TaskAccount } |
Select-Object TaskName, TaskPath, State,
    @{Name="RunAs";Expression={$_.Principal.UserId}}
```

### Disable scheduled tasks

```powershell
$TaskAccount = "AM\rt_sbx_pmxadmin"

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
___

## 4 - Enable All Services running as service account

### Preview services

```powershell
Get-CimInstance Win32_Service |
Where-Object { $_.StartName -eq "AM\rt_sbx_pmxadmin" } |
Select-Object Name, DisplayName, State, StartMode, StartName
```

### Enable services

```powershell
$ServiceAccount = "AM\rt_sbx_pmxadmin"

# Prompt once for the new password
$Credential = Get-Credential -UserName $ServiceAccount -Message "Enter the NEW password for the service account"

$Password = $Credential.GetNetworkCredential().Password

$services = Get-CimInstance Win32_Service |
    Where-Object { $_.StartName -eq $ServiceAccount }

if ($services.Count -eq 0) {
    Write-Host "No services found running as '$ServiceAccount'."
    exit
}

foreach ($service in $services) {
    Write-Host "Processing: $($service.Name)"

    # Update the stored service credentials
    Invoke-CimMethod -InputObject $service -MethodName Change -Arguments @{
        StartName = $ServiceAccount
        StartPassword = $Password
    } | Out-Null

    # Re-enable the service
    Set-Service -Name $service.Name -StartupType Automatic

    # Start the service
    Start-Service -Name $service.Name -ErrorAction Continue

    Write-Host " -> Password updated, enabled, and started"
}

Write-Host "`nCompleted."
```
___

## 5 - Enable scheduled tasks

### Preview scheduled tasks

```powershell
$TaskAccount = "AM\rt_sbx_pmxadmin"

Get-ScheduledTask |
Where-Object { $_.Principal.UserId -eq $TaskAccount } |
Select-Object TaskName, TaskPath, State,
    @{Name="RunAs";Expression={$_.Principal.UserId}}
```

### Enable schedule tasks

```powershell
$TaskAccount = "AM\rt_sbx_pmxadmin"

$Credential = Get-Credential -UserName $TaskAccount -Message "Enter the NEW password for the scheduled task account"
$Password = $Credential.GetNetworkCredential().Password

$tasks = Get-ScheduledTask |
    Where-Object { $_.Principal.UserId -eq $TaskAccount }

if (-not $tasks) {
    Write-Host "No scheduled tasks found running as '$TaskAccount'."
    exit
}

foreach ($task in $tasks) {
    Write-Host "Processing: $($task.TaskPath)$($task.TaskName)"

    Set-ScheduledTask `
        -TaskName $task.TaskName `
        -TaskPath $task.TaskPath `
        -User $TaskAccount `
        -Password $Password

    Enable-ScheduledTask `
        -TaskName $task.TaskName `
        -TaskPath $task.TaskPath

    Write-Host " -> Password updated and enabled"
}

Write-Host "`nCompleted."
```
