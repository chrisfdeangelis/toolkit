# GitHub SSH Authentication Setup (Linux)

## Purpose

Configure SSH key-based authentication between a Linux system and GitHub to securely clone, pull, and push repositories without using HTTPS credentials.

---

# Prerequisites

- Linux system
- Git installed
- GitHub account
- Internet connectivity

Verify Git is installed:

```bash
git --version
```

If Git is not installed:

### Ubuntu / Debian

```bash
sudo apt update
sudo apt install git
```

### Rocky / RHEL

```bash
sudo dnf install git
```

---

# Configure Git Identity

Configure the name and email address that will be attached to Git commits.

```bash
git config --global user.name "Chris DeAngelis"
git config --global user.email "your-email@example.com"
```

Verify the configuration:

```bash
git config --global --list
```

Example output:

```text
user.name=Chris DeAngelis
user.email=your-email@example.com
```

---

# Generate an SSH Key

Generate a new ED25519 SSH key.

```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
```

When prompted:

```text
Enter file in which to save the key (/home/chris/.ssh/id_ed25519):
```

Press **Enter** to accept the default location.

When prompted for a passphrase:

```text
Enter passphrase (empty for no passphrase):
```

Choose one of the following:

- **Press Enter twice** to leave the key unencrypted (recommended for a personal lab machine).
- Enter a passphrase for additional security.

---

# Display the Public Key

Display the newly generated public key.

```bash
cat ~/.ssh/id_ed25519.pub
```

Example:

```text
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI... your-email@example.com
```

Copy the entire line.

---

# Add the Public Key to GitHub

Navigate to:

```
GitHub
└── Settings
    └── SSH and GPG keys
        └── New SSH key
```

Provide:

| Field | Value |
|-------|-------|
| Title | Ubuntu Lab VM |
| Key Type | Authentication Key |
| Key | Paste contents of `id_ed25519.pub` |

Click **Add SSH key**.

---

# Configure a Repository to Use SSH

Check the current remote.

```bash
git remote -v
```

If the repository is using HTTPS:

```text
origin https://github.com/chrisfdeangelis/repository.git
```

Change it to SSH.

```bash
git remote set-url origin git@github.com:chrisfdeangelis/repository.git
```

Verify:

```bash
git remote -v
```

Expected:

```text
origin git@github.com:chrisfdeangelis/repository.git (fetch)
origin git@github.com:chrisfdeangelis/repository.git (push)
```

---

# Test SSH Authentication

Test the SSH connection.

```bash
ssh -T git@github.com
```

The first connection may ask:

```text
Are you sure you want to continue connecting (yes/no)?
```

Type:

```text
yes
```

Successful authentication should display:

```text
Hi chrisfdeangelis! You've successfully authenticated, but GitHub does not provide shell access.
```

---

# Standard Git Workflow

Check repository status.

```bash
git status
```

Stage changes.

```bash
git add .
```

Commit changes.

```bash
git commit -m "Describe your changes"
```

Push changes.

```bash
git push
```

---

# Verification Checklist

- [ ] Git installed
- [ ] Git identity configured
- [ ] SSH key generated
- [ ] Public key added to GitHub
- [ ] Repository remote uses SSH
- [ ] SSH authentication successful
- [ ] Successfully pushed to GitHub

---

# Optional Configuration

## Use ssh-agent

Most modern Linux distributions can automatically use an unencrypted SSH key stored in `~/.ssh/`. If your key has a passphrase, or you want to cache your credentials for the current session, use `ssh-agent`.

Start the agent:

```bash
eval "$(ssh-agent -s)"
```

Load the key:

```bash
ssh-add ~/.ssh/id_ed25519
```

Verify:

```bash
ssh-add -l
```

Example output:

```text
256 SHA256:... your-email@example.com (ED25519)
```

---

# Troubleshooting

## Permission denied (publickey)

Verify the SSH connection with verbose output.

```bash
ssh -vT git@github.com
```

If using `ssh-agent`, ensure the key is loaded.

```bash
ssh-add -l
```

If no identities are listed:

```bash
ssh-add ~/.ssh/id_ed25519
```

---

## Repository Uses HTTPS Instead of SSH

Check the configured remote.

```bash
git remote -v
```

If it displays:

```text
https://github.com/...
```

Convert it to SSH.

```bash
git remote set-url origin git@github.com:chrisfdeangelis/repository.git
```

---

## View the Current Public Key

```bash
cat ~/.ssh/id_ed25519.pub
```

---

## View Configured Git Identity

```bash
git config --global --list
```

---

## Check the Current Repository Remote

```bash
git remote -v
```

---

# File Locations

| File | Purpose |
|------|---------|
| `~/.ssh/id_ed25519` | Private SSH key (Never share) |
| `~/.ssh/id_ed25519.pub` | Public SSH key (Safe to share with GitHub) |

---

# References

GitHub SSH Documentation

https://docs.github.com/en/authentication/connecting-to-github-with-ssh

OpenSSH Manual

```bash
man ssh
```

```bash
man ssh-keygen
```
