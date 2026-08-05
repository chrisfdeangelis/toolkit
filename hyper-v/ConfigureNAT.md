# Hyper-V NAT Network Setup

## Step 1 – Create Internal Virtual Switch

Open **Hyper-V Manager**.

```text
Virtual Switch Manager
```

Create:

- **Name:** `CyberLab`
- **Type:** `Internal`

Click **Apply**.

---

## Step 2 – Assign Host IP

Open PowerShell as Administrator.

Alternatively Win + R (configure under Properties):

```powershell
ncpa.cpl
```

Configure in

Find the adapter:

```powershell
Get-NetAdapter
```

Locate:

```text
vEthernet (CyberLab)
```

Assign an IP address:

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

Expected output:

```text
vEthernet (CyberLab)

IPv4 Address . . . . : 10.10.10.1
Subnet Mask . . . . : 255.255.255.0
```

---

## Step 3 – Create NAT

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

Expected output:

```text
Name
----
CyberLabNAT
```

---

## Step 4 – Configure Virtual Machines

Each VM connected to the **CyberLab** switch should have a static network configuration similar to the following:

- **IP Address:** `10.10.10.20`
- **Subnet Mask:** `255.255.255.0`
- **Default Gateway:** `10.10.10.1`
- **DNS Server:** `10.10.10.10`
  - or `1.1.1.1` while building the lab

---

## Step 5 – Test Connectivity

Ping the gateway:

```bash
ping 10.10.10.1
```

Ping Cloudflare:

```bash
ping 1.1.1.1
```

Test DNS resolution:

```bash
ping google.com
```

If all three tests succeed, NAT is functioning correctly.

---

## Useful PowerShell Commands

List network adapters:

```powershell
Get-NetAdapter
```

View IP addresses:

```powershell
Get-NetIPAddress
```

View NAT configuration:

```powershell
Get-NetNat
```

Remove the NAT configuration:

```powershell
Remove-NetNat -Name CyberLabNAT
```

View the routing table:

```powershell
route print
```

---

## Troubleshooting

### VM has no internet access

Verify the NAT configuration:

```powershell
Get-NetNat
```

Ensure:

- NAT exists.
- The VM's default gateway is `10.10.10.1`.
- The VM is connected to the **CyberLab** virtual switch.

---

### Host adapter is missing

If the `vEthernet (CyberLab)` adapter doesn't exist:

- Delete the virtual switch.
- Recreate the Internal virtual switch.
- Reboot the host if necessary.

---

### DNS doesn't work

Try using one of the following DNS servers:

```text
1.1.1.1
```

or

```text
8.8.8.8
```

If IP addresses work but hostnames do not, the issue is DNS configuration.

---

### NAT already exists

Check for existing NAT objects:

```powershell
Get-NetNat
```

Delete the existing NAT:

```powershell
Remove-NetNat -Name CyberLabNAT
```

Then recreate it using the commands in **Step 3**.
