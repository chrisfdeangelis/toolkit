# Understanding Windows Group Policy vs. Registry

## Overview

When troubleshooting Windows Group Policy, it is important to understand the relationship between:

- Local Group Policy (`gpedit.msc`)
- Domain Group Policy (GPMC)
- Effective Policy (Registry)
- Resultant Set of Policy (RSoP)

These components serve different purposes and should not be confused.

---

## Group Policy Processing

```
              Domain GPOs
                   │
              Local GPO
                   │
        Group Policy Engine
                   │
                   ▼
HKLM\SOFTWARE\Policies\...
                   │
                   ▼
         Windows Uses These Values
```

The registry under the **Policies** key is what Windows ultimately reads when enforcing Administrative Template policies.

---

## Local Group Policy (gpedit.msc)

`gpedit.msc` edits the **Local Group Policy Object (LGPO)**.

It **does not** display:

- Domain GPO settings
- Effective policy
- Registry values written by other management tools

Example:

```
Computer Configuration
    Administrative Templates
        Windows Components
```

If a policy shows **Not Configured** in gpedit, that only means the **local** policy is not configuring it.

---

## Domain Group Policy

Domain Group Policies are processed after the Local GPO according to Group Policy precedence.

The winning settings are written into:

```
HKLM\SOFTWARE\Policies\
```

Windows does not read the GPO directly—it reads the resulting registry values.

---

## Effective Policy

Administrative Template policies are typically stored under:

```
HKLM\SOFTWARE\Policies\
```

Example:

```
HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services
```

Relevant RDS timeout values:

| Registry Value | Policy |
|---------------|--------|
| MaxDisconnectionTime | Set time limit for disconnected sessions |
| MaxIdleTime | Set time limit for active but idle sessions |
| MaxConnectionTime | Set time limit for active sessions |

Example PowerShell:

```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
```

---

## Verifying Which GPO Applied a Setting

### Generate an HTML report

```cmd
gpresult /scope computer /h C:\Temp\GPReport.html
```

Open:

```
C:\Temp\GPReport.html
```

Search for:

```
Set time limit for disconnected sessions
```

If configured, the report shows:

- configured value
- winning GPO

---

### Resultant Set of Policy

```
rsop.msc
```

Navigate to:

```
Computer Configuration
    Administrative Templates
        Windows Components
            Remote Desktop Services
                Remote Desktop Session Host
                    Session Time Limits
```

RSoP displays the **effective Group Policy configuration**.

---

## Possible Troubleshooting Scenarios

| gpedit | gpresult / RSoP | Registry | Interpretation |
|---------|-----------------|----------|----------------|
| Not Configured | 30 minutes | 30 minutes | Domain GPO configured the setting |
| 30 minutes | 30 minutes | 30 minutes | Local GPO configured the setting |
| Not Configured | Not Configured | Value exists | Possible stale registry value or manually configured registry |
| Not Configured | Not Configured | No value | Policy truly not configured |

---

## Registry Values Can Become Orphaned

One interesting discovery:

A registry value can remain under:

```
HKLM\SOFTWARE\Policies\
```

even though:

- Local GPO shows **Not Configured**
- Domain GPO no longer configures the setting
- `gpresult` does not list the policy

Possible causes include:

- Previous GPO configuration
- Manual registry edits
- Third-party management software
- Incomplete cleanup after policy removal

For this reason, **do not assume every registry value under `Policies` is currently being enforced by Group Policy.**

---

## Troubleshooting Checklist

### 1. Check the registry

```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
```

### 2. Generate a Group Policy report

```cmd
gpresult /scope computer /h C:\Temp\GPReport.html
```

### 3. Review effective policy

```cmd
rsop.msc
```

### 4. Refresh policy

```cmd
gpupdate /force
```

### 5. Recheck the registry

If a registry value remains after:

- gpupdate
- gpresult shows no configuring GPO
- RSoP shows Not Configured

then the value is likely orphaned or was written outside of Group Policy.

---

## Lessons Learned

- Windows enforces Administrative Template policies from the **registry**, not directly from GPO files.
- `gpedit.msc` only edits the Local Group Policy.
- `gpresult` and `rsop.msc` show what Group Policy believes should be applied.
- Registry values can occasionally remain after a policy is removed, so discrepancies should be investigated rather than assumed to be active policy.
