# Registry Values Reporting

This powershell script can be used to report on current policies in place based on registry values, regardless of overarching GPOs.  You may need to adjust it to include different registry values based on your needs. 

```powershell```
Write-Host "Running..."

 

$TimeStamp = Get-Date -Format "yyyy-MM-dd_HHmmss"

$OutputFile = Join-Path ([Environment]::GetFolderPath("Desktop")) "Citrix_Session_Time_Limits_$TimeStamp.csv"

 

$Servers = @(

    'server01',
    'server02',
    'server03'
)

 

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"

 

$Results = foreach ($Server in $Servers) {

    Invoke-Command -ComputerName $Server -ScriptBlock {

        param($RegPath)

 

        $Policy = Get-ItemProperty -Path $RegPath -ErrorAction SilentlyContinue

 

        function Convert-RdsTimeout {

            param($Value)

 

            if ($null -eq $Value) {

                return "Not Configured"

            }

 

            $Minutes = $Value / 60000

 

            if ($Minutes -eq 480) {

                return "Never"

            }

 

            return "$Minutes minutes"

        }

 

        [pscustomobject]@{

            ServerName                 = $env:COMPUTERNAME

            DisconnectedSessionsTimeout = Convert-RdsTimeout $Policy.MaxDisconnectionTime

            ActiveButIdleTimeout        = Convert-RdsTimeout $Policy.MaxIdleTime

        }

 

    } -ArgumentList $RegPath

}

 

$Results | Export-Csv -Path $OutputFile -NoTypeInformation

 

Write-Host ""

Write-Host "Report saved to: " -ForegroundColor Green

Write-Host $OutputFile

Read-Host "Press Enter to exit"
```
