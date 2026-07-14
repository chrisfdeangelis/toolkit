---

# Creating a New Repository from Scratch

This is the typical workflow for creating a brand-new Git repository on your local machine and publishing it to GitHub.

## 1. Create the Project Directory

Create a folder for your new project and navigate into it.

```bash
mkdir my-project
cd my-project
```

At this point, the directory is just a normal folder.

---

## 2. Initialize Git

Initialize the repository.

```bash
git init
```

Git creates a hidden `.git` directory inside the project.

```text
my-project/
└── .git/
```

The `.git` folder contains everything Git needs to track the project, including:

* Commit history
* Branch information
* Repository configuration
* Object database
* Tags
* References
* Staging area (index)

> **Note:** `git init` creates a **local** Git repository only. Nothing is uploaded to GitHub.

---

## 3. Add Project Files

Create your project files.

Example:

```text
my-project/
├── README.md
├── basics.md
├── script.ps1
└── .git/
```

Check the repository status.

```bash
git status
```

Git will report the files as **Untracked** because they have not yet been added to version control.

---

## 4. Stage Files

Stage the files that should be included in the next commit.

Stage everything:

```bash
git add .
```

Stage an individual file:

```bash
git add README.md
```

The files are now in Git's **staging area**, waiting to be committed.

---

## 5. Create the Initial Commit

Save the staged changes to the repository history.

```bash
git commit -m "Initial commit"
```

A commit records:

* File contents
* Folder structure
* Author
* Timestamp
* Commit message
* Reference to the previous commit

Think of a commit as a snapshot of your project at a specific point in time.

---

## 6. Create a GitHub Repository

On GitHub:

1. Click **New Repository**
2. Choose a repository name
3. Leave the repository empty
4. Do **not** initialize it with:

   * README
   * .gitignore
   * License

Since these files already exist locally, starting with an empty repository avoids merge conflicts.

---

## 7. Connect the Local Repository to GitHub

SSH:

```bash
git remote add origin git@github.com:username/my-project.git
```

HTTPS:

```bash
git remote add origin https://github.com/username/my-project.git
```

Verify the remote:

```bash
git remote -v
```

Example output:

```text
origin  git@github.com:username/my-project.git (fetch)
origin  git@github.com:username/my-project.git (push)
```

`origin` is simply the conventional name for the primary remote repository.

---

## 8. Push to GitHub

Upload the local commits.

```bash
git push -u origin main
```

The `-u` (`--set-upstream`) flag tells Git to associate the local `main` branch with the remote `origin/main` branch.

Future pushes only require:

```bash
git push
```

Future pulls only require:

```bash
git pull
```

---

# Git Workflow Overview

```text
Working Directory
        │
        │ git add
        ▼
Staging Area (Index)
        │
        │ git commit
        ▼
Local Git Repository (.git)
        │
        │ git push
        ▼
Remote Repository (GitHub)
```

Each stage serves a specific purpose:

| Stage             | Purpose                                                             |
| ----------------- | ------------------------------------------------------------------- |
| Working Directory | Files you're actively editing                                       |
| Staging Area      | Selects exactly what will be included in the next commit            |
| Local Repository  | Stores the complete project history in the `.git` directory         |
| Remote Repository | Stores a copy of the repository online for backup and collaboration |

---

# Typical Daily Workflow

Once the repository has been created, the daily workflow is usually:

```bash
git status
git add .
git commit -m "Describe the changes"
git push
```

This sequence checks the repository, stages changes, creates a new snapshot, and uploads it to the remote repository.

