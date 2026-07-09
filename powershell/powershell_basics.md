# PowerShell Basics

A quick reference for the PowerShell commands I use most often.

---

# Check PowerShell Version

```powershell
$PSVersionTable
```

Show only the version:

```powershell
$PSVersionTable.PSVersion
```

---

# Help System

Get help for a command:

```powershell
Get-Help Get-Process
```

Show examples:

```powershell
Get-Help Get-Process -Examples
```

Open full help:

```powershell
Get-Help Get-Process -Full
```

Update help files:

```powershell
Update-Help
```

---

# Command Discovery

Find commands:

```powershell
Get-Command
```

Find commands containing a word:

```powershell
Get-Command *service*
```

Find commands by verb:

```powershell
Get-Command -Verb Get
```

Find commands by noun:

```powershell
Get-Command -Noun Service
```

---

# Aliases

List aliases:

```powershell
Get-Alias
```

Find what an alias means:

```powershell
Get-Alias ls
```

Common aliases:

```powershell
ls      # Get-ChildItem
cd      # Set-Location
pwd     # Get-Location
cat     # Get-Content
rm      # Remove-Item
cp      # Copy-Item
mv      # Move-Item
```

---

# Navigation

Show current location:

```powershell
Get-Location
```

Change directory:

```powershell
Set-Location C:\Temp
```

Go up one directory:

```powershell
Set-Location ..
```

List files and folders:

```powershell
Get-ChildItem
```

List hidden files:

```powershell
Get-ChildItem -Force
```

---

# Files and Folders

Create a folder:

```powershell
New-Item -ItemType Directory -Path C:\Temp\TestFolder
```

Create a file:

```powershell
New-Item -ItemType File -Path C:\Temp\test.txt
```

Copy a file:

```powershell
Copy-Item C:\Temp\test.txt C:\Backup\
```

Copy a folder recursively:

```powershell
Copy-Item C:\Temp\TestFolder C:\Backup\ -Recurse
```

Move a file:

```powershell
Move-Item C:\Temp\test.txt C:\Backup\
```

Rename a file:

```powershell
Rename-Item C:\Temp\test.txt newname.txt
```

Delete a file:

```powershell
Remove-Item C:\Temp\test.txt
```

Delete a folder recursively:

```powershell
Remove-Item C:\Temp\TestFolder -Recurse
```

---

# Reading and Writing Files

Read a file:

```powershell
Get-Content C:\Temp\test.txt
```

Read the last 20 lines:

```powershell
Get-Content C:\Temp\test.txt -Tail 20
```

Follow a log file live:

```powershell
Get-Content C:\Temp\app.log -Wait
```

Write text to a file:

```powershell
"Hello world" | Out-File C:\Temp\test.txt
```

Append text to a file:

```powershell
"Another line" | Out-File C:\Temp\test.txt -Append
```

Alternative append method:

```powershell
Add-Content C:\Temp\test.txt "Another line"
```

---

# Variables

Create a variable:

```powershell
$name = "Chris"
```

Use a variable:

```powershell
Write-Host "Hello, $name"
```

Numbers:

```powershell
$count = 5
```

Arrays:

```powershell
$servers = @("Server01", "Server02", "Server03")
```

Hash tables:

```powershell
$user = @{
    Name = "Chris"
    Role = "Analyst"
}
```

---

# Objects and Properties

PowerShell works with objects, not just text.

Get services:

```powershell
Get-Service
```

Show only selected properties:

```powershell
Get-Service | Select-Object Name, Status
```

Sort results:

```powershell
Get-Service | Sort-Object Status
```

Filter results:

```powershell
Get-Service | Where-Object { $_.Status -eq "Running" }
```

Format as table:

```powershell
Get-Service | Format-Table Name, Status -AutoSize
```

Format as list:

```powershell
Get-Service | Format-List *
```

---

# Pipeline

Pass output from one command into another:

```powershell
Get-Process | Sort-Object CPU -Descending
```

Example: show top 10 processes by CPU:

```powershell
Get-Process |
    Sort-Object CPU -Descending |
    Select-Object -First 10
```

---

# Filtering

Filter with `Where-Object`:

```powershell
Get-Process | Where-Object { $_.CPU -gt 100 }
```

Shorter syntax:

```powershell
Get-Process | Where-Object CPU -gt 100
```

Common operators:

```powershell
-eq     # equals
-ne     # not equals
-gt     # greater than
-ge     # greater than or equal
-lt     # less than
-le     # less than or equal
-like   # wildcard match
-match  # regex match
-in     # value exists in collection
```

---

# Loops

For each item in a collection:

```powershell
foreach ($server in $servers) {
    Write-Host "Checking $server"
}
```

Pipeline version:

```powershell
$servers | ForEach-Object {
    Write-Host "Checking $_"
}
```

---

# If Statements

```powershell
$service = Get-Service -Name Spooler

if ($service.Status -eq "Running") {
    Write-Host "Service is running"
}
else {
    Write-Host "Service is not running"
}
```

---

# Services

List services:

```powershell
Get-Service
```

Find a service:

```powershell
Get-Service -Name Spooler
```

Start a service:

```powershell
Start-Service -Name Spooler
```

Stop a service:

```powershell
Stop-Service -Name Spooler
```

Restart a service:

```powershell
Restart-Service -Name Spooler
```

Set startup type:

```powershell
Set-Service -Name Spooler -StartupType Automatic
```

---

# Processes

List processes:

```powershell
Get-Process
```

Find a process:

```powershell
Get-Process -Name notepad
```

Stop a process:

```powershell
Stop-Process -Name notepad
```

Stop by process ID:

```powershell
Stop-Process -Id 1234
```

---

# Event Logs

List event logs:

```powershell
Get-EventLog -List
```

Read System log:

```powershell
Get-EventLog -LogName System -Newest 20
```

Read newer Windows event logs:

```powershell
Get-WinEvent -LogName System -MaxEvents 20
```

Filter failed logons:

```powershell
Get-WinEvent -FilterHashtable @{
    LogName = "Security"
    Id = 4625
}
```

---

# Networking

Show IP configuration:

```powershell
Get-NetIPConfiguration
```

Show IP addresses:

```powershell
Get-NetIPAddress
```

Test network connectivity:

```powershell
Test-NetConnection google.com
```

Test specific port:

```powershell
Test-NetConnection server01 -Port 443
```

Show listening TCP ports:

```powershell
Get-NetTCPConnection -State Listen
```

Show established TCP connections:

```powershell
Get-NetTCPConnection -State Established
```

---

# Scheduled Tasks

List scheduled tasks:

```powershell
Get-ScheduledTask
```

Find a task:

```powershell
Get-ScheduledTask -TaskName "TaskName"
```

Start a task:

```powershell
Start-ScheduledTask -TaskName "TaskName"
```

Enable a task:

```powershell
Enable-ScheduledTask -TaskName "TaskName"
```

Disable a task:

```powershell
Disable-ScheduledTask -TaskName "TaskName"
```

---

# Registry

Navigate registry like a file system:

```powershell
Set-Location HKLM:\
```

Read registry key:

```powershell
Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion"
```

Create registry key:

```powershell
New-Item -Path "HKLM:\Software\TestKey"
```

Set registry value:

```powershell
Set-ItemProperty -Path "HKLM:\Software\TestKey" -Name "ExampleValue" -Value "Test"
```

Remove registry value:

```powershell
Remove-ItemProperty -Path "HKLM:\Software\TestKey" -Name "ExampleValue"
```

---

# Remote Commands

Run a command on another computer:

```powershell
Invoke-Command -ComputerName Server01 -ScriptBlock {
    Get-Service
}
```

Start an interactive remote session:

```powershell
Enter-PSSession -ComputerName Server01
```

Exit remote session:

```powershell
Exit-PSSession
```

---

# Credentials

Prompt for credentials:

```powershell
$Credential = Get-Credential
```

Use credentials with a command:

```powershell
Invoke-Command -ComputerName Server01 -Credential $Credential -ScriptBlock {
    hostname
}
```

---

# Execution Policy

View execution policy:

```powershell
Get-ExecutionPolicy
```

View all scopes:

```powershell
Get-ExecutionPolicy -List
```

Set execution policy for current user:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Temporarily bypass execution policy:

```powershell
powershell.exe -ExecutionPolicy Bypass -File .\script.ps1
```

---

# Running Scripts

Run a script from the current directory:

```powershell
.\script.ps1
```

Run PowerShell as administrator when needed.

---

# Script Template

```powershell
# Script Name: example.ps1
# Purpose: Brief description of what this script does
# Author: Chris
# Date: YYYY-MM-DD

Write-Host "Starting script..."

try {
    # Main script logic here
    Write-Host "Script completed successfully."
}
catch {
    Write-Error "An error occurred: $_"
}
```

---

# Commenting

Single-line comment:

```powershell
# This is a comment
```

Multi-line comment:

```powershell
<#
This is a
multi-line comment
#>
```

---

# Error Handling

Basic try/catch:

```powershell
try {
    Get-Item C:\DoesNotExist -ErrorAction Stop
}
catch {
    Write-Error "Failed: $_"
}
```

---

# Exporting Data

Export to CSV:

```powershell
Get-Service | Export-Csv C:\Temp\services.csv -NoTypeInformation
```

Import from CSV:

```powershell
Import-Csv C:\Temp\services.csv
```

Export to text:

```powershell
Get-Service | Out-File C:\Temp\services.txt
```

Export to JSON:

```powershell
Get-Service | ConvertTo-Json | Out-File C:\Temp\services.json
```

---

# Useful Admin Commands

Show computer name:

```powershell
hostname
```

Show logged-in user:

```powershell
whoami
```

Show local users:

```powershell
Get-LocalUser
```

Show local groups:

```powershell
Get-LocalGroup
```

Show group members:

```powershell
Get-LocalGroupMember Administrators
```

Show installed programs from registry:

```powershell
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
    Select-Object DisplayName, DisplayVersion, Publisher, InstallDate
```

---

# Useful Patterns

## Confirm before destructive action

```powershell
Remove-Item C:\Temp\TestFolder -Recurse -Confirm
```

## Preview what would happen

```powershell
Remove-Item C:\Temp\TestFolder -Recurse -WhatIf
```

## Save command output to a variable

```powershell
$services = Get-Service
```

## Count results

```powershell
(Get-Service).Count
```

## Search text in files

```powershell
Select-String -Path C:\Temp\*.log -Pattern "error"
```

## Recursively search files

```powershell
Get-ChildItem C:\Temp -Recurse -File |
    Select-String -Pattern "error"
```

---

# Common Troubleshooting

## Script will not run

Check execution policy:

```powershell
Get-ExecutionPolicy -List
```

Temporarily bypass:

```powershell
powershell.exe -ExecutionPolicy Bypass -File .\script.ps1
```

## Command not recognized

Check whether the command exists:

```powershell
Get-Command CommandName
```

## Access denied

Try running PowerShell as Administrator.

## See full error details

```powershell
$error[0] | Format-List * -Force
```

## Check module availability

```powershell
Get-Module -ListAvailable
```

## Import a module

```powershell
Import-Module ModuleName
```

---

# Daily Workflow Examples

## Check a service

```powershell
Get-Service -Name Spooler
```

## Restart a service

```powershell
Restart-Service -Name Spooler
```

## Check whether a port is open

```powershell
Test-NetConnection server01 -Port 443
```

## Search recent System events

```powershell
Get-WinEvent -LogName System -MaxEvents 50
```

## Search logs for errors

```powershell
Select-String -Path C:\Logs\*.log -Pattern "error"
```

---

# Tips

* Use `Get-Help` when unsure about a command.
* Use `Get-Command` to discover commands.
* Use `Get-Member` to inspect object properties and methods.
* Use `-WhatIf` before running risky commands.
* Use `-Confirm` when deleting or modifying important data.
* Prefer full command names in scripts instead of aliases.
* Run PowerShell as Administrator when modifying services, registry, scheduled tasks, or system settings.

