# Troubleshooting Guide

## Common Issues and Solutions

```mermaid
graph TD
    A[Issue Encountered] --> B{What's the problem?}

    B -->|File not found| C[.bashrc Missing]
    B -->|Permission denied| D[Access Issues]
    B -->|Changes not applied| E[Configuration Issues]
    B -->|Script won't run| F[Execution Issues]

    C --> C1[Check if .bashrc exists:<br/>ls -la ~/.bashrc]
    C1 --> C2[Create if missing:<br/>touch ~/.bashrc]

    D --> D1[Check permissions:<br/>ls -l ~/.bashrc]
    D1 --> D2[Fix permissions:<br/>chmod 644 ~/.bashrc]

    E --> E1[Verify changes:<br/>grep HISTSIZE ~/.bashrc]
    E1 --> E2[Reload shell:<br/>source ~/.bashrc]

    F --> F1[Make executable:<br/>chmod +x histmod.sh]
    F1 --> F2[Check bash path:<br/>which bash]

    style A fill:#F5A623,stroke:#C98419,stroke-width:3px
    style C fill:#D0021B,stroke:#A00116,stroke-width:2px,color:#fff
    style D fill:#D0021B,stroke:#A00116,stroke-width:2px,color:#fff
    style E fill:#D0021B,stroke:#A00116,stroke-width:2px,color:#fff
    style F fill:#D0021B,stroke:#A00116,stroke-width:2px,color:#fff
```

## Issue 1: ~/.bashrc File Not Found

### Symptoms
```
~/.bashrc file not found
```

### Diagnosis
```bash
ls -la ~/.bashrc
```

### Solution

```mermaid
flowchart LR
    A[Check if file exists] --> B{Exists?}
    B -->|No| C[Create new .bashrc]
    B -->|Yes| D[Check permissions]
    C --> E[Copy from /etc/skel]
    E --> F[Run script again]
    D --> G[Fix permissions if needed]
    G --> F

    style C fill:#7ED321,stroke:#5FA319,stroke-width:2px
```

**Steps:**
1. Check if file exists:
   ```bash
   ls -la ~/.bashrc
   ```

2. If missing, create from template:
   ```bash
   cp /etc/skel/.bashrc ~/.bashrc
   ```

3. Or create a basic one:
   ```bash
   cat > ~/.bashrc << 'EOF'
   # Basic .bashrc
   HISTSIZE=1000
   HISTFILESIZE=2000
   EOF
   ```

4. Run histmod.sh again

## Issue 2: Permission Denied

### Symptoms
```
bash: ./histmod.sh: Permission denied
```

### Diagnosis
```bash
ls -l histmod.sh
```

### Solution

```bash
# Make the script executable
chmod +x histmod.sh

# Verify permissions
ls -l histmod.sh
# Should show: -rwxr-xr-x
```

## Issue 3: Changes Not Applied

### Symptoms
- Script runs successfully
- But HISTSIZE still shows old value

### Diagnosis Flow

```mermaid
sequenceDiagram
    participant User
    participant Terminal
    participant Bashrc as ~/.bashrc
    participant Shell as Shell Session

    User->>Terminal: Run histmod.sh
    Terminal->>Bashrc: Modify values
    Note over Bashrc: Values updated in file
    User->>Shell: echo $HISTSIZE
    Shell-->>User: Shows old value
    Note over User,Shell: Need to reload shell!
```

### Solution

1. Check if changes were written:
   ```bash
   grep -E "HISTSIZE|HISTFILESIZE" ~/.bashrc
   ```

2. Reload the configuration:
   ```bash
   source ~/.bashrc
   ```

3. Verify in current session:
   ```bash
   echo $HISTSIZE
   echo $HISTFILESIZE
   ```

4. If still not working, open a new terminal

## Issue 4: Script Runs But Values Unchanged

### Symptoms
- No error messages
- File modification timestamp doesn't change
- Values remain the same

### Diagnosis

```mermaid
graph TD
    A[Check file] --> B[grep HISTSIZE ~/.bashrc]
    B --> C{Multiple matches?}
    C -->|Yes| D[Problem: Duplicate entries]
    C -->|No| E[Check format]
    E --> F{Correct format?}
    F -->|No| G[Problem: Incorrect format]
    F -->|Yes| H[Check if commented]

    D --> I[Solution: Clean up duplicates]
    G --> J[Solution: Fix format]
    H --> K{Has # prefix?}
    K -->|Yes| L[Solution: Uncomment]

    style D fill:#D0021B,stroke:#A00116,stroke-width:2px,color:#fff
    style G fill:#D0021B,stroke:#A00116,stroke-width:2px,color:#fff
    style L fill:#7ED321,stroke:#5FA319,stroke-width:2px
```

### Solution

1. Check for commented lines:
   ```bash
   grep "^#.*HISTSIZE" ~/.bashrc
   ```

2. If found, uncomment them first:
   ```bash
   sed -i 's/^#\s*HISTSIZE/HISTSIZE/' ~/.bashrc
   sed -i 's/^#\s*HISTFILESIZE/HISTFILESIZE/' ~/.bashrc
   ```

3. Run histmod.sh again

## Issue 5: Backup/Restore Problems

### Creating Manual Backup

```bash
# Create backup directory
mkdir -p ~/.config_backups

# Create timestamped backup
cp ~/.bashrc ~/.config_backups/bashrc_$(date +%Y%m%d_%H%M%S)

# Verify backup
ls -lh ~/.config_backups/
```

### Restoring from Backup

```mermaid
flowchart TD
    A[Need to restore] --> B[List backups]
    B --> C[ls -lh ~/.config_backups/]
    C --> D[Choose backup file]
    D --> E[Copy backup to ~/.bashrc]
    E --> F[Reload configuration]
    F --> G[Verify restoration]

    style A fill:#F5A623,stroke:#C98419,stroke-width:2px
    style G fill:#7ED321,stroke:#5FA319,stroke-width:2px
```

```bash
# List available backups
ls -lh ~/.config_backups/

# Restore specific backup
cp ~/.config_backups/bashrc_YYYYMMDD_HHMMSS ~/.bashrc

# Reload
source ~/.bashrc
```

## Issue 6: sed Command Errors

### Symptoms
```
sed: can't read ~/.bashrc: No such file or directory
```

### Solution Decision Tree

```mermaid
graph TD
    A{sed error?} --> B{File exists?}
    B -->|No| C[Create .bashrc]
    B -->|Yes| D{Permissions OK?}
    D -->|No| E[Fix permissions:<br/>chmod 644 ~/.bashrc]
    D -->|Yes| F{sed installed?}
    F -->|No| G[Install sed]
    F -->|Yes| H[Check sed syntax]

    style A fill:#F5A623,stroke:#C98419,stroke-width:2px
    style C fill:#7ED321,stroke:#5FA319,stroke-width:2px
    style E fill:#7ED321,stroke:#5FA319,stroke-width:2px
    style G fill:#7ED321,stroke:#5FA319,stroke-width:2px
```

## Issue 7: History Not Persisting

### Symptoms
- Script runs successfully
- Settings applied correctly
- But history still clears between sessions

### Diagnosis

```bash
# Check if history is being saved
echo $HISTFILE
# Should show: /home/username/.bash_history

# Check if history file exists and is writable
ls -l ~/.bash_history

# Check for HISTCONTROL settings
grep HISTCONTROL ~/.bashrc
```

### Solution

1. Ensure HISTFILE is set:
   ```bash
   echo 'export HISTFILE=~/.bash_history' >> ~/.bashrc
   ```

2. Check for ignorespace/ignoredups:
   ```bash
   # These settings might be preventing history saving
   grep "HISTCONTROL=ignorespace" ~/.bashrc
   ```

3. Reload and test:
   ```bash
   source ~/.bashrc
   history -a  # Append current session to history file
   ```

## Diagnostic Commands

### Full System Check

```bash
#!/bin/bash
echo "=== GPT Shell Diagnostic Report ==="
echo ""
echo "1. Bash version:"
bash --version | head -1
echo ""
echo "2. .bashrc status:"
ls -lh ~/.bashrc
echo ""
echo "3. Current HIST settings:"
echo "HISTSIZE=$HISTSIZE"
echo "HISTFILESIZE=$HISTFILESIZE"
echo ""
echo "4. .bashrc HIST settings:"
grep -E "^HISTSIZE|^HISTFILESIZE" ~/.bashrc
echo ""
echo "5. History file:"
ls -lh ~/.bash_history
echo ""
echo "6. histmod.sh status:"
ls -l histmod.sh
echo ""
echo "7. Recent history count:"
history | wc -l
echo ""
```

## Getting Help

If issues persist:

```mermaid
graph LR
    A[Still having issues?] --> B[Check documentation]
    B --> C[Search existing issues]
    C --> D{Found solution?}
    D -->|Yes| E[Apply fix]
    D -->|No| F[Create new issue]
    F --> G[Include diagnostic info]
    G --> H[Wait for response]

    style A fill:#F5A623,stroke:#C98419,stroke-width:2px
    style E fill:#7ED321,stroke:#5FA319,stroke-width:2px
```

1. Review this troubleshooting guide
2. Check [GitHub Issues](https://github.com/danindiana/gpt_shell/issues)
3. Create a new issue with:
   - Your OS and bash version
   - Output from diagnostic commands
   - Exact error messages
   - Steps you've already tried

## Prevention Tips

```mermaid
mindmap
    root((Best Practices))
        Before Running
            Create backup
            Review script
            Check permissions
        During Execution
            Watch for errors
            Read output messages
            Verify each step
        After Running
            Test new settings
            Verify history works
            Keep backups
        Regular Maintenance
            Clean old backups
            Update script
            Review settings
```

1. Always backup before running scripts
2. Test in a non-critical environment first
3. Keep multiple backup versions
4. Document any custom modifications
5. Regularly verify your settings
