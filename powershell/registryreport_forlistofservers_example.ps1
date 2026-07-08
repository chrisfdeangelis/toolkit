Write-Host "Running..."

 

$TimeStamp = Get-Date -Format "yyyy-MM-dd_HHmmss"

$OutputFile = Join-Path ([Environment]::GetFolderPath("Desktop")) "PRD799_Citrix_Session_Time_Limits_$TimeStamp.csv"

 

$Servers = @(

    'rt1prd799c1', 'rt1prd799c2', 'rt1prd799c3', 'rt1prd799c5', 'rt1prd799c6', 'rt1prd799c7', 'rt1prd799c8', 'rt1prd799c9', 'rt1prd799c10', 'rt1prd799c11', 'rt1prd799c12', 'rt1prd799c13', 'rt1prd799c14', 'rt1prd799c15', 'rt1prd799c16', 'rt1prd799c17', 'rt1prd799c18', 'rt1prd799c19', 'rt1prd799c20', 'rt1prd799c21', 'rt1prd799c22', 'rt1prd799c23', 'rt1prd799c24'

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
