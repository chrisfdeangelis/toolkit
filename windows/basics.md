# Windows Basics

A quick reference for common Windows administration tools, commands, and troubleshooting techniques.

---

# System Information

Display the computer name:

```cmd
hostname
```

Display the current user:

```cmd
whoami
```

Display detailed system information:

```cmd
systeminfo
```

Display the Windows version:

```cmd
winver
```

Display environment variables:

```cmd
set
```

---

# File System

List directory contents:

```cmd
dir
```

Change directories:

```cmd
cd C:\Temp
```

Create a directory:

```cmd
mkdir NewFolder
```

Delete a directory:

```cmd
rmdir /s NewFolder
```

Copy a file:

```cmd
copy source.txt destination.txt
```

Move a file:

```cmd
move source.txt destination.txt
```

Delete a file:

```cmd
del file.txt
```

Robust file copy:

```cmd
robocopy C:\Source C:\Destination /E
```

Create a symbolic link:

```cmd
mklink Link.txt Target.txt
```

Create a directory junction:

```cmd
mklink /J C:\LinkFolder C:\TargetFolder
```

---

# Networking

Display IP configuration:

```cmd
ipconfig
```

Display full IP configuration:

```cmd
ipconfig /all
```

Release DHCP lease:

```cmd
ipconfig /release
```

Renew DHCP lease:

```cmd
ipconfig /renew
```

Flush DNS cache:

```cmd
ipconfig /flushdns
```

Display DNS cache:

```cmd
ipconfig /displaydns
```

Test connectivity:

```cmd
ping google.com
```

Trace network path:

```cmd
tracert google.com
```

Extended path analysis:

```cmd
pathping google.com
```

DNS lookup:

```cmd
nslookup google.com
```

Display active connections:

```cmd
netstat -ano
```

Display routing table:

```cmd
route print
```

Display ARP cache:

```cmd
arp -a
```

PowerShell equivalents:

```powershell
Get-NetIPAddress
Get-NetIPConfiguration
Get-NetTCPConnection
Test-NetConnection google.com -Port 443
```

---

# Services

List services:

```cmd
sc query
```

Query a service:

```cmd
sc query Spooler
```

Start a service:

```cmd
sc start Spooler
```

Stop a service:

```cmd
sc stop Spooler
```

Configure startup type:

```cmd
sc config Spooler start= auto
```

PowerShell equivalents:

```powershell
Get-Service
Start-Service
Stop-Service
Restart-Service
Set-Service
```

Open Services console:

```text
services.msc
```

---

# Processes

List running processes:

```cmd
tasklist
```

Terminate a process:

```cmd
taskkill /PID 1234 /F
```

Terminate by name:

```cmd
taskkill /IM notepad.exe /F
```

PowerShell equivalents:

```powershell
Get-Process
Stop-Process
```

Open Task Manager:

```text
taskmgr
```

---

# Scheduled Tasks

List scheduled tasks:

```cmd
schtasks /query
```

Run a scheduled task:

```cmd
schtasks /run /TN "Task Name"
```

Disable a scheduled task:

```cmd
schtasks /change /TN "Task Name" /disable
```

Enable a scheduled task:

```cmd
schtasks /change /TN "Task Name" /enable
```

PowerShell equivalents:

```powershell
Get-ScheduledTask
Enable-ScheduledTask
Disable-ScheduledTask
Start-ScheduledTask
Set-ScheduledTask
```

Open Task Scheduler:

```text
taskschd.msc
```

---

# Event Logs

Open Event Viewer:

```text
eventvwr.msc
```

Query recent events:

```powershell
Get-WinEvent -LogName System -MaxEvents 20
```

Filter Security log:

```powershell
Get-WinEvent -FilterHashtable @{
    LogName = "Security"
    Id = 4625
}
```

Legacy event log command:

```cmd
wevtutil qe System
```

---

# Registry

Open Registry Editor:

```text
regedit
```

Query a registry value:

```cmd
reg query HKLM\Software
```

Add a registry value:

```cmd
reg add HKLM\Software\Test /v Example /t REG_SZ /d Test
```

Delete a registry value:

```cmd
reg delete HKLM\Software\Test /v Example
```

PowerShell equivalents:

```powershell
Get-ItemProperty
Set-ItemProperty
New-Item
Remove-ItemProperty
```

---

# Group Policy

Refresh Group Policy:

```cmd
gpupdate /force
```

Generate an HTML report:

```cmd
gpresult /h report.html
```

Display applied policies:

```cmd
gpresult /r
```

View Resultant Set of Policy:

```text
rsop.msc
```

Edit Local Group Policy:

```text
gpedit.msc
```

---

# Local Users and Groups

List users:

```cmd
net user
```

Display user information:

```cmd
net user username
```

List local groups:

```cmd
net localgroup
```

List Administrators group:

```cmd
net localgroup Administrators
```

PowerShell equivalents:

```powershell
Get-LocalUser
Get-LocalGroup
Get-LocalGroupMember
```

Open Local Users and Groups:

```text
lusrmgr.msc
```

---

# Disk Management

Open Disk Management:

```text
diskmgmt.msc
```

Check disk integrity:

```cmd
chkdsk C:
```

Scan system files:

```cmd
sfc /scannow
```

Repair Windows image:

```cmd
DISM /Online /Cleanup-Image /RestoreHealth
```

---

# Windows Firewall

Open Firewall:

```text
wf.msc
```

Show firewall profiles:

```cmd
netsh advfirewall show allprofiles
```

Enable firewall:

```cmd
netsh advfirewall set allprofiles state on
```

Disable firewall:

```cmd
netsh advfirewall set allprofiles state off
```

---

# Remote Desktop

Launch Remote Desktop:

```text
mstsc
```

List current sessions:

```cmd
query session
```

Log off a session:

```cmd
logoff SESSION_ID
```

---

# Common MMC Consoles

| Console        | Purpose                     |
| -------------- | --------------------------- |
| `compmgmt.msc` | Computer Management         |
| `services.msc` | Services                    |
| `eventvwr.msc` | Event Viewer                |
| `diskmgmt.msc` | Disk Management             |
| `gpedit.msc`   | Local Group Policy          |
| `taskschd.msc` | Task Scheduler              |
| `devmgmt.msc`  | Device Manager              |
| `certlm.msc`   | Local Computer Certificates |
| `certmgr.msc`  | Current User Certificates   |
| `lusrmgr.msc`  | Local Users and Groups      |
| `wf.msc`       | Windows Defender Firewall   |
| `perfmon.msc`  | Performance Monitor         |
| `resmon.exe`   | Resource Monitor            |
| `msconfig`     | System Configuration        |
| `regedit`      | Registry Editor             |

---

# Shutdown Commands

Shutdown immediately:

```cmd
shutdown /s /t 0
```

Restart immediately:

```cmd
shutdown /r /t 0
```

Abort a scheduled shutdown:

```cmd
shutdown /a
```

---

# Useful PowerShell Admin Commands

Display installed Windows services:

```powershell
Get-Service
```

Display running processes:

```powershell
Get-Process
```

Display listening ports:

```powershell
Get-NetTCPConnection -State Listen
```

Display installed software (registry):

```powershell
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
    Select-Object DisplayName, DisplayVersion
```

---

# Common Troubleshooting

## Check Event Viewer

```text
eventvwr.msc
```

---

## Verify applied Group Policies

```cmd
gpresult /h report.html
```

---

## Repair Windows files

```cmd
sfc /scannow
DISM /Online /Cleanup-Image /RestoreHealth
```

---

## Verify network connectivity

```cmd
ipconfig /all
ping
tracert
nslookup
```

---

## Check services

```powershell
Get-Service
```

---

## Check scheduled tasks

```powershell
Get-ScheduledTask
```

---

## Review listening ports

```cmd
netstat -ano
```

or

```powershell
Get-NetTCPConnection
```

---

# Daily Workflow

When troubleshooting a Windows server, my typical workflow is:

1. Verify system information (`hostname`, `whoami`, `systeminfo`)
2. Check network connectivity (`ipconfig`, `ping`, `Test-NetConnection`)
3. Review Event Viewer (`eventvwr.msc`, `Get-WinEvent`)
4. Verify services (`Get-Service`)
5. Check scheduled tasks (`Get-ScheduledTask`)
6. Review applied Group Policies (`gpresult`, `rsop.msc`)
7. Inspect running processes (`Get-Process`, `tasklist`)
8. Repair system files if necessary (`sfc`, `DISM`)

---

# Tips

* Prefer **PowerShell** over Command Prompt for automation and scripting.
* Use `Get-Help` in PowerShell whenever you're unsure of a command.
* Run administrative tools in an elevated terminal when modifying system settings.
* Generate a `gpresult` report before troubleshooting Group Policy issues.
* Check Event Viewer before making assumptions—many Windows issues leave useful logs.
* Use `robocopy` instead of `copy` for large or important file transfers.
* Learn the common `.msc` consoles—they're some of the fastest ways to access Windows management tools.

