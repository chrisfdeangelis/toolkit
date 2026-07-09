##Preview
```powershell
Get-CimInstance Win32_Service |
Where-Object { $_.StartName -eq "am/rt_sbx_pmxadmin" } |
Select-Object Name, DisplayName, State, StartMode, StartName
```

##Script
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
