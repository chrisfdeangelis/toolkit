# Linux Basics

A quick reference for common Linux commands, administration tasks, and troubleshooting techniques.

---

# System Information

Show hostname:

```bash
hostname
```

Show current user:

```bash
whoami
```

Show current working directory:

```bash
pwd
```

Show kernel version:

```bash
uname -r
```

Show all system information:

```bash
uname -a
```

Display OS information:

```bash
cat /etc/os-release
```

Show uptime:

```bash
uptime
```

Show logged in users:

```bash
who
```

Display current date and time:

```bash
date
```

---

# Navigation

Show current directory:

```bash
pwd
```

List files:

```bash
ls
```

Detailed listing:

```bash
ls -l
```

Show hidden files:

```bash
ls -la
```

Change directory:

```bash
cd /path/to/directory
```

Go to home directory:

```bash
cd ~
```

Go up one directory:

```bash
cd ..
```

Go to previous directory:

```bash
cd -
```

Display directory tree:

```bash
tree
```

---

# Files and Directories

Create a directory:

```bash
mkdir myfolder
```

Create nested directories:

```bash
mkdir -p projects/docker/app
```

Create an empty file:

```bash
touch file.txt
```

Copy a file:

```bash
cp file.txt backup.txt
```

Copy a directory:

```bash
cp -r source destination
```

Move or rename:

```bash
mv oldname.txt newname.txt
```

Delete a file:

```bash
rm file.txt
```

Delete a directory:

```bash
rm -r directory
```

Delete recursively without prompts:

```bash
rm -rf directory
```

Create a symbolic link:

```bash
ln -s target linkname
```

---

# Viewing Files

Display file contents:

```bash
cat file.txt
```

View one page at a time:

```bash
less file.txt
```

Show first 10 lines:

```bash
head file.txt
```

Show last 10 lines:

```bash
tail file.txt
```

Follow a growing log:

```bash
tail -f /var/log/syslog
```

Count lines, words, and bytes:

```bash
wc file.txt
```

---

# Searching

Find files:

```bash
find /home -name "*.log"
```

Search text inside files:

```bash
grep "error" logfile.log
```

Recursive search:

```bash
grep -r "password" .
```

Ignore case:

```bash
grep -i "warning" logfile.log
```

Locate installed commands:

```bash
which docker
```

Find executable and man page:

```bash
whereis ssh
```

Locate files (database required):

```bash
locate filename
```

---

# Permissions

View permissions:

```bash
ls -l
```

Change permissions:

```bash
chmod 755 script.sh
```

Make a script executable:

```bash
chmod +x script.sh
```

Change owner:

```bash
sudo chown user:user file.txt
```

Change owner recursively:

```bash
sudo chown -R user:user directory
```

Display current umask:

```bash
umask
```

---

# Processes

View running processes:

```bash
ps
```

Detailed process list:

```bash
ps aux
```

Interactive process viewer:

```bash
top
```

Improved process viewer:

```bash
htop
```

Kill by PID:

```bash
kill 1234
```

Force kill:

```bash
kill -9 1234
```

Kill by name:

```bash
pkill nginx
```

---

# Services (systemd)

View service status:

```bash
systemctl status nginx
```

Start a service:

```bash
sudo systemctl start nginx
```

Stop a service:

```bash
sudo systemctl stop nginx
```

Restart a service:

```bash
sudo systemctl restart nginx
```

Reload configuration:

```bash
sudo systemctl reload nginx
```

Enable at boot:

```bash
sudo systemctl enable nginx
```

Disable at boot:

```bash
sudo systemctl disable nginx
```

List running services:

```bash
systemctl list-units --type=service
```

---

# Logs

View system journal:

```bash
journalctl
```

View recent logs:

```bash
journalctl -n 50
```

Follow logs live:

```bash
journalctl -f
```

Logs for a specific service:

```bash
journalctl -u nginx
```

Logs since boot:

```bash
journalctl -b
```

---

# Networking

Display IP addresses:

```bash
ip addr
```

Show interfaces:

```bash
ip link
```

Display routing table:

```bash
ip route
```

Test connectivity:

```bash
ping google.com
```

DNS lookup:

```bash
dig google.com
```

Alternative DNS lookup:

```bash
nslookup google.com
```

Download a file:

```bash
wget https://example.com/file.zip
```

HTTP request:

```bash
curl https://example.com
```

Check listening ports:

```bash
ss -tuln
```

Legacy alternative:

```bash
netstat -tuln
```

Trace route:

```bash
traceroute google.com
```

---

# SSH

Connect to a remote system:

```bash
ssh user@server
```

Copy a file:

```bash
scp file.txt user@server:/home/user
```

Copy a directory:

```bash
scp -r folder user@server:/home/user
```

Generate an SSH key:

```bash
ssh-keygen -t ed25519
```

View loaded SSH keys:

```bash
ssh-add -l
```

---

# Disk Management

Show mounted disks:

```bash
lsblk
```

Display disk usage:

```bash
df -h
```

Show directory sizes:

```bash
du -sh *
```

Show filesystem UUIDs:

```bash
blkid
```

Mount a filesystem:

```bash
sudo mount /dev/sdb1 /mnt
```

Unmount a filesystem:

```bash
sudo umount /mnt
```

---

# Compression

Create a tar archive:

```bash
tar -cvf archive.tar folder
```

Extract a tar archive:

```bash
tar -xvf archive.tar
```

Create gzip archive:

```bash
tar -czvf archive.tar.gz folder
```

Extract gzip archive:

```bash
tar -xzvf archive.tar.gz
```

Create zip archive:

```bash
zip -r archive.zip folder
```

Extract zip archive:

```bash
unzip archive.zip
```

---

# Package Management

## Ubuntu / Debian

Update package lists:

```bash
sudo apt update
```

Upgrade packages:

```bash
sudo apt upgrade
```

Install a package:

```bash
sudo apt install docker.io
```

Remove a package:

```bash
sudo apt remove docker.io
```

Search for a package:

```bash
apt search docker
```

---

## Rocky / RHEL / Fedora

Update packages:

```bash
sudo dnf update
```

Install a package:

```bash
sudo dnf install docker
```

Remove a package:

```bash
sudo dnf remove docker
```

Search for packages:

```bash
dnf search docker
```

---

# Environment Variables

Display PATH:

```bash
echo $PATH
```

Display all environment variables:

```bash
env
```

Create a variable:

```bash
export NAME=Chris
```

Display a variable:

```bash
echo $NAME
```

---

# File Permissions

Show file owner:

```bash
ls -l
```

Show inode information:

```bash
stat file.txt
```

---

# Users

Display current user ID:

```bash
id
```

Switch users:

```bash
su username
```

Run a command as root:

```bash
sudo command
```

Change a password:

```bash
passwd
```

---

# System Monitoring

CPU usage:

```bash
top
```

Memory usage:

```bash
free -h
```

Disk usage:

```bash
df -h
```

Disk usage by directory:

```bash
du -sh *
```

View running processes:

```bash
ps aux
```

---

# Useful One-Liners

Find all log files:

```bash
find . -name "*.log"
```

Find large files:

```bash
find / -type f -size +500M
```

Search recursively:

```bash
grep -r "error" .
```

Display the ten largest directories:

```bash
du -sh * | sort -hr | head
```

Follow a log:

```bash
tail -f /var/log/syslog
```

Display open ports:

```bash
ss -tuln
```

Display Docker containers:

```bash
docker ps
```

---

# Common Troubleshooting

## Check disk space

```bash
df -h
```

---

## Check memory

```bash
free -h
```

---

## Check running processes

```bash
ps aux
```

or

```bash
top
```

---

## Check logs

```bash
journalctl -xe
```

or

```bash
tail -f /var/log/syslog
```

---

## Check service status

```bash
systemctl status service_name
```

---

## Check network connectivity

```bash
ping
curl
ip addr
ss -tuln
```

---

## Verify DNS

```bash
dig google.com
```

or

```bash
nslookup google.com
```

---

## Find a command

```bash
which command
```

---

## Find a file

```bash
find / -name filename
```

---

# Daily Workflow

When troubleshooting a Linux server, my typical workflow is:

1. Verify system information (`hostname`, `uname`, `cat /etc/os-release`)
2. Check resource usage (`top`, `free`, `df`)
3. Verify network connectivity (`ip addr`, `ping`, `curl`)
4. Review service status (`systemctl status`)
5. Review logs (`journalctl`)
6. Check processes (`ps aux`)
7. Inspect listening ports (`ss -tuln`)
8. Verify file permissions (`ls -l`, `stat`)

---

# Tips

* Prefer `systemctl` over older `service` commands.
* Learn `grep`, `find`, and `journalctl` thoroughly—they're some of the most useful troubleshooting tools.
* Use `less` instead of `cat` for large files.
* Be cautious with `sudo rm -rf`.
* Use SSH keys instead of passwords whenever possible.
* Check logs before restarting services.
* Use tab completion to speed up navigation and reduce typing errors.
* Keep your system updated with your distribution's package manager.

