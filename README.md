# Jaewoong Linux Tools

[![Test](https://github.com/jwhan0301/jaewoong-linux-tools/actions/workflows/test.yml/badge.svg)](https://github.com/jwhan0301/jaewoong-linux-tools/actions/workflows/test.yml)

A collection of small Bash command-line tools created as a project-based way to learn Linux, shell scripting, Git, automated testing, and GitHub Actions.

Rather than only memorizing commands, I developed and tested tools that I could use directly in a Linux environment.

## Tools

This repository contains three command-line tools:

```bash
jcheck
jgrep
jnote
```

### `jcheck`

Displays a quick overview of the current system.

```bash
jcheck
```

It shows information such as:

- Current user
- Hostname
- Date
- Disk usage
- Memory usage
- IP address
- Top processes

### `jgrep`

Searches for a keyword in a file without case sensitivity and reports the number of matching lines.

```bash
jgrep error app.log
```

Features:

- Case-insensitive search
- Line-number display
- Match count

### `jnote`

A personal command-line note manager.

#### Basic commands

```bash
jnote add "Study Linux commands"
jnote list
jnote show 1
jnote search Linux
jnote count
```

#### Edit and delete notes

```bash
jnote edit 1 "Updated note"
jnote delete 1
jnote clear
jnote clear --yes
```

#### Export, import, and backup

```bash
jnote export notes-backup.txt
jnote import notes-backup.txt
jnote backup
```

Importing the same file multiple times may create duplicate notes.

#### View notes by date

```bash
jnote today
jnote recent
jnote recent 10
```

When no number is provided, `jnote recent` displays the five most recent notes.

#### Archive and restore

```bash
jnote archive 2
jnote archived
jnote restore 1
```

#### Undo

```bash
jnote undo
```

`jnote undo` restores the state before the most recent modifying operation.

Supported operations include:

- `add`
- `edit`
- `delete`
- `clear`
- `import`
- `archive`
- `restore`

The current implementation supports one-level undo only.

## Installation

Clone the repository:

```bash
git clone https://github.com/jwhan0301/jaewoong-linux-tools.git
cd jaewoong-linux-tools
```

Install the commands into `~/bin`:

```bash
./install.sh
```

After installation, the tools can be used from any directory:

```bash
jcheck
jgrep
jnote
```

Check the installed command locations:

```bash
command -v jcheck
command -v jgrep
command -v jnote
```

## Uninstallation

Remove the installed commands from `~/bin`:

```bash
./uninstall.sh
```

To remove them without a confirmation prompt:

```bash
./uninstall.sh --yes
```

## Testing

Run the complete test script:

```bash
./test.sh
```

The test suite checks:

- Bash syntax
- Installation and uninstallation
- `jgrep` searches
- Basic `jnote` commands
- Editing, deletion, and clearing
- Exporting and importing
- Recent notes and daily notes
- Backups
- Archiving and restoring
- One-level undo

The tests use a temporary directory as a separate `HOME` environment so that real personal notes are not modified during testing.

A successful test run ends with:

```text
All tests passed.
```

GitHub Actions automatically runs the test suite when changes are pushed to the repository.

## Development Approach

This project was developed with AI-assisted coding.

I used OpenAI Codex to help draft and modify code while focusing on:

- Understanding the purpose of each command
- Running the scripts in a Linux environment
- Testing expected and unexpected behavior
- Identifying and debugging errors
- Adding features incrementally
- Managing changes with Git branches and commits
- Verifying the project with automated tests

The code was not written entirely from scratch without assistance. This repository documents my process of learning Linux and development workflows through hands-on experimentation.

## What I Learned

Through this project, I practiced:

- Linux command-line fundamentals
- File and directory management
- Bash variables, conditions, loops, functions, and `case`
- Commands such as `grep`, `find`, `head`, and `tail`
- Script permissions and `PATH`
- Installation and uninstallation scripts
- Bash syntax checking and debugging
- Isolated test environments
- Git commits, branches, merges, and tags
- GitHub repositories and remote pushes
- Continuous integration with GitHub Actions

## Limitations

This is a personal learning project rather than a production-ready command-line application.

The tools were primarily developed and tested in WSL Ubuntu, and behavior may vary in other environments.

## Changelog

Version history is available in [CHANGELOG.md](CHANGELOG.md).

## Project Goal

The goal of this repository is to learn Linux and development workflows by building, testing, and improving small tools instead of only memorizing commands.
