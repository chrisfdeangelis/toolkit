# Git Basics

A quick reference for the Git commands I use most often.

---

# Check Version

```bash
git --version
```

---

# Configure Git

## Set username

```bash
git config --global user.name "Your Name"
```

## Set email

```bash
git config --global user.email "you@example.com"
```

## View configuration

```bash
git config --list
```

---

# Create a Repository

Initialize Git in the current folder.

```bash
git init
```

---

# Clone a Repository

HTTPS

```bash
git clone https://github.com/username/repository.git
```

SSH

```bash
git clone git@github.com:username/repository.git
```

---

# Check Repository Status

```bash
git status
```

Shows:

* Current branch
* Modified files
* Untracked files
* Staged files

---

# Add Files

Stage a single file.

```bash
git add README.md
```

Stage everything.

```bash
git add .
```

---

# Commit Changes

```bash
git commit -m "Describe the changes made"
```

Commit all tracked files without running `git add`.

```bash
git commit -am "Commit message"
```

> Note: `git commit -am` does **not** include new (untracked) files.

---

# View Commit History

Compact history

```bash
git log --oneline
```

Detailed history

```bash
git log
```

Graph view

```bash
git log --oneline --graph --decorate --all
```

---

# Connect to GitHub

View remotes

```bash
git remote -v
```

Add remote

```bash
git remote add origin git@github.com:username/repository.git
```

Change remote

```bash
git remote set-url origin git@github.com:username/repository.git
```

Remove remote

```bash
git remote remove origin
```

---

# Push Changes

First push

```bash
git push -u origin main
```

Subsequent pushes

```bash
git push
```

---

# Pull Changes

Fetch and merge changes from GitHub.

```bash
git pull
```

---

# Fetch Without Merging

```bash
git fetch
```

Downloads remote changes without modifying the current branch.

---

# Branches

List branches

```bash
git branch
```

Create a branch

```bash
git branch feature-name
```

Switch branches

```bash
git switch feature-name
```

Create and switch

```bash
git switch -c feature-name
```

Delete a merged branch

```bash
git branch -d feature-name
```

Force delete

```bash
git branch -D feature-name
```

---

# Restore Files

Discard local changes to a file.

```bash
git restore filename
```

Restore every modified file.

```bash
git restore .
```

---

# Remove a File

Remove from Git and disk.

```bash
git rm filename
```

Remove from Git but keep locally.

```bash
git rm --cached filename
```

---

# Undo Last Commit

Keep changes

```bash
git reset --soft HEAD~1
```

Discard changes

```bash
git reset --hard HEAD~1
```

---

# Stashing

Save work temporarily.

```bash
git stash
```

List stashes.

```bash
git stash list
```

Restore latest stash.

```bash
git stash pop
```

---

# Tags

Create a tag.

```bash
git tag v1.0
```

Push tags.

```bash
git push origin --tags
```

---

# Ignore Files

Create a `.gitignore` file.

Example:

```text
*.log
*.tmp
.env
node_modules/
bin/
obj/
```

---

# Helpful Commands

Show differences

```bash
git diff
```

View staged differences

```bash
git diff --cached
```

Show tracked files

```bash
git ls-files
```

Show current branch

```bash
git branch --show-current
```

---

# Typical Daily Workflow

```bash
git status
git add .
git commit -m "Describe changes"
git push
```

---

# Common Troubleshooting

## Check remote

```bash
git remote -v
```

## Verify SSH authentication

```bash
ssh -T git@github.com
```

## Check current branch

```bash
git branch
```

## Check working tree

```bash
git status
```

## Fetch latest information

```bash
git fetch
```

---

# Useful Tips

* Commit often with meaningful messages.
* Pull before starting new work.
* Use feature branches for larger changes.
* Review `git status` before every commit.
* Never force-push shared branches unless everyone agrees.
* Keep `.gitignore` updated to avoid committing unnecessary files.

