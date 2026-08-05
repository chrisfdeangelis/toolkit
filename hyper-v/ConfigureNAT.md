\# Hyper-V NAT Network Setup



\## Overview



This guide creates a \*\*private Hyper-V network with NAT\*\*, allowing virtual machines to:



\- Communicate with each other on an isolated network

\- Access the internet through the Windows host

\- Remain inaccessible from the physical LAN unless explicitly forwarded



This is ideal for:



\- Cybersecurity labs

\- Malware analysis

\- Active Directory labs

\- Penetration testing environments



\---



\# Network Topology



```

&#x20;                Internet

&#x20;                    │

&#x20;            Home Router

&#x20;         192.168.4.0/24

&#x20;                    │

&#x20;         Windows Hyper-V Host

&#x20;       External NIC: 192.168.4.x

&#x20;                    │

&#x20;        Hyper-V Internal Switch

&#x20;            "CyberLab"

&#x20;                    │

&#x20;     Host vEthernet Adapter

&#x20;         10.10.10.1/24

&#x20;                    │

&#x20;         Windows NAT Gateway

&#x20;                    │

&#x20;       -----------------------

&#x20;       │          │         │

&#x20;     DC01      Kali      Ubuntu

&#x20;  10.10.10.10  .20        .30

```



\---



\# IP Scheme



| Device | IP |

|---------|-------------|

| Host (vEthernet) | 10.10.10.1 |

| Domain Controller | 10.10.10.10 |

| Windows Client | 10.10.10.11 |

| Kali Linux | 10.10.10.20 |

| Ubuntu | 10.10.10.30 |

| Gateway | 10.10.10.1 |

| DNS | 10.10.10.10 (or 1.1.1.1 while building) |



Subnet:



```

10.10.10.0/24

```



\---



\# Step 1 – Create Internal Virtual Switch



Open \*\*Hyper-V Manager\*\*



```

Virtual Switch Manager

```



Create:



\- Name: `CyberLab`

\- Type: `Internal`



Apply.



\---



\# Step 2 – Assign Host IP



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

&#x20;   -IPAddress 10.10.10.1 `

&#x20;   -PrefixLength 24 `

&#x20;   -InterfaceAlias "vEthernet (CyberLab)"

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



\---



\# Step 3 – Create NAT



Create the NAT object:



```powershell

New-NetNat `

&#x20;   -Name CyberLabNAT `

&#x20;   -InternalIPInterfaceAddressPrefix 10.10.10.0/24

```



Verify:



```powershell

Get-NetNat

```



Expected:



```

Name

\----

CyberLabNAT

```



\---



\# Step 4 – Configure Virtual Machines



Each VM connected to the \*\*CyberLab\*\* switch should have:



\### Static Example



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



\---



\# Step 5 – Test Connectivity



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



\---



\# Useful PowerShell Commands



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



\---



\# Troubleshooting



\## VM has no internet



Check:



```powershell

Get-NetNat

```



Ensure:



\- NAT exists

\- VM gateway is `10.10.10.1`

\- VM is connected to the CyberLab switch



\---



\## Host adapter missing



If the vEthernet adapter doesn't exist:



\- Delete the switch

\- Recreate the Internal switch

\- Reboot if necessary



\---



\## DNS doesn't work



Try:



```

1.1.1.1

```



or



```

8.8.8.8

```



If IP addresses work but hostnames do not, the issue is DNS configuration.



\---



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



\---



\# Security Notes



Using an \*\*Internal\*\* switch with NAT provides several advantages over connecting lab VMs directly to your home network:



\- VMs are isolated from your physical LAN.

\- The host controls outbound internet access.

\- Lab systems are not directly reachable from other devices on your network.

\- Ideal for malware analysis and offensive security labs.



If inbound access is ever required (for example, SSH or RDP into a lab VM), configure explicit port forwarding rather than exposing the entire VM to the LAN.



\---



\# References



\- Hyper-V Internal Virtual Switch

\- Windows NAT (`New-NetNat`)

\- `Get-NetNat`

\- `New-NetIPAddress`

\- `Get-NetAdapter`

