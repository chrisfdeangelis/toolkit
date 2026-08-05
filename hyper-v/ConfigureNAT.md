# Hyper-V NAT Network Setup

# Step 1 – Create Internal Virtual Switch



Open \*\*Hyper-V Manager\*\*



```

Virtual Switch Manager

```



Create:



- Name: `CyberLab`

- Type: `Internal`



Apply.



---



# Step 2 – Assign Host IP



Open PowerShell as Administrator.



Find the adapter:



```powershell

Get-NetAdapter

```



Locate:



```

vEthernet (CyberLab)

```



Assign an IP:



```powershell

New-NetIPAddress `

  -IPAddress 10.10.10.1 `

  -PrefixLength 24 `

  -InterfaceAlias "vEthernet (CyberLab)"

```



Verify:



```powershell

ipconfig

```



Expected:



```

vEthernet (CyberLab)



IPv4 Address . . . . : 10.10.10.1

Subnet Mask . . . . : 255.255.255.0

```



---



# Step 3 – Create NAT



Create the NAT object:



```powershell

New-NetNat `

  -Name CyberLabNAT `

  -InternalIPInterfaceAddressPrefix 10.10.10.0/24

```



Verify:



```powershell

Get-NetNat

```



Expected:



```

Name

----

CyberLabNAT

```



---



# Step 4 – Configure Virtual Machines



Each VM connected to the \*\*CyberLab\*\* switch should have:



### Static Example



IP



```

10.10.10.20

```



Subnet



```

255.255.255.0

```



Gateway



```

10.10.10.1

```



DNS



```

10.10.10.10

```



or



```

1.1.1.1

```



---



# Step 5 – Test Connectivity



Ping gateway:



```bash

ping 10.10.10.1

```



Ping Cloudflare:



```bash

ping 1.1.1.1

```



Test DNS:



```bash

ping google.com

```



If all three succeed, NAT is functioning correctly.



---



# Useful PowerShell Commands



List adapters:



```powershell

Get-NetAdapter

```



View IP addresses:



```powershell

Get-NetIPAddress

```



View NAT:



```powershell

Get-NetNat

```



Remove NAT:



```powershell

Remove-NetNat -Name CyberLabNAT

```



View routes:



```powershell

route print

```



---



# Troubleshooting



## VM has no internet



Check:



```powershell

Get-NetNat

```



Ensure:



- NAT exists

- VM gateway is `10.10.10.1`

- VM is connected to the CyberLab switch



---



## Host adapter missing



If the vEthernet adapter doesn't exist:



- Delete the switch

- Recreate the Internal switch

- Reboot if necessary



---



## DNS doesn't work



Try:



```

1.1.1.1

```



or



```

8.8.8.8

```



If IP addresses work but hostnames do not, the issue is DNS configuration.



---



\## NAT already exists



Check:



```powershell

Get-NetNat

```



Delete:



```powershell

Remove-NetNat -Name CyberLabNAT

```



Then recreate it.



---



