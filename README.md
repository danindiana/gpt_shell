# GPT Shell - Bash History Modifier

A simple yet powerful bash utility that automatically configures your bash history settings for optimal command retention and shell productivity.

## Overview

This script locates and modifies your `~/.bashrc` file to enhance bash history settings, increasing both `HISTSIZE` (in-memory history) and `HISTFILESIZE` (on-disk history) to retain more command history.

## Features

- Automatically locates `~/.bashrc` configuration file
- Updates `HISTSIZE` to 10,000 commands
- Updates `HISTFILESIZE` to 2,000 lines
- Validates file existence before modification
- Automatically reloads bash configuration after changes
- Safe sed-based modifications

## Repository Structure

```mermaid
graph TD
    A[gpt_shell Repository] --> B[histmod.sh]
    A --> C[LICENSE]
    A --> D[README.md]

    B --> E[Main Script]
    C --> F[GPL v3 License]
    D --> G[Documentation]

    style A fill:#4A90E2,stroke:#2E5C8A,stroke-width:3px,color:#fff
    style B fill:#7ED321,stroke:#5FA319,stroke-width:2px
    style C fill:#F5A623,stroke:#C98419,stroke-width:2px
    style D fill:#50E3C2,stroke:#3DB39E,stroke-width:2px
```

## Script Execution Flow

```mermaid
flowchart TD
    Start([Start Script]) --> Init[Initialize Variables<br/>HISTSIZE=10000<br/>HISTFILESIZE=2000]
    Init --> Check{Check if<br/>~/.bashrc exists?}

    Check -->|Yes| Found[Print: Found ~/.bashrc file]
    Check -->|No| NotFound[Print: ~/.bashrc file not found]

    Found --> Modify[Print: Modifying HISTSIZE and HISTFILESIZE]
    Modify --> Sed1[sed: Replace HISTSIZE line]
    Sed1 --> Sed2[sed: Replace HISTFILESIZE line]
    Sed2 --> Save[Print: Saving and resetting]
    Save --> Source[Execute: source ~/.bashrc]
    Source --> End([End])

    NotFound --> End

    style Start fill:#4A90E2,stroke:#2E5C8A,stroke-width:3px,color:#fff
    style End fill:#4A90E2,stroke:#2E5C8A,stroke-width:3px,color:#fff
    style Check fill:#F5A623,stroke:#C98419,stroke-width:2px
    style Source fill:#7ED321,stroke:#5FA319,stroke-width:2px
    style NotFound fill:#D0021B,stroke:#A00116,stroke-width:2px,color:#fff
```

## Installation & Usage

### Quick Start

```bash
# Clone the repository
git clone https://github.com/danindiana/gpt_shell.git
cd gpt_shell

# Make the script executable
chmod +x histmod.sh

# Run the script
./histmod.sh
```

### Usage Diagram

```mermaid
sequenceDiagram
    participant User
    participant Script as histmod.sh
    participant Bashrc as ~/.bashrc
    participant Shell as Bash Shell

    User->>Script: Execute ./histmod.sh
    Script->>Bashrc: Check file exists

    alt File exists
        Bashrc-->>Script: File found
        Script->>User: Print: Found ~/.bashrc file
        Script->>User: Print: Modifying values
        Script->>Bashrc: sed: Update HISTSIZE
        Script->>Bashrc: sed: Update HISTFILESIZE
        Script->>User: Print: Saving and resetting
        Script->>Shell: source ~/.bashrc
        Shell-->>User: Configuration reloaded
    else File not found
        Bashrc-->>Script: File not found
        Script->>User: Print: ~/.bashrc file not found
    end
```

## Git Workflow

```mermaid
gitGraph
    commit id: "Initial commit"
    commit id: "Create histmod.sh"
    branch feature/docs
    checkout feature/docs
    commit id: "Add README.md"
    commit id: "Add mermaid diagrams"
    commit id: "Add examples"
    checkout main
    merge feature/docs tag: "v1.1.0"
    commit id: "Update histmod.sh"
```

## Configuration Details

### Before Script Execution
```bash
# Typical default values in ~/.bashrc
HISTSIZE=1000
HISTFILESIZE=2000
```

### After Script Execution
```bash
# Enhanced values set by histmod.sh
HISTSIZE=10000      # Stores 10,000 commands in memory
HISTFILESIZE=2000   # Maintains 2,000 lines in ~/.bash_history
```

## System Requirements

```mermaid
mindmap
    root((Requirements))
        Operating System
            Linux
            macOS
            Unix-like systems
        Shell
            Bash 3.0+
            ~/.bashrc file
        Tools
            sed
            source command
        Permissions
            Read access to ~
            Write access to ~/.bashrc
```

## How It Works

### Technical Flow

```mermaid
graph LR
    A[User runs script] --> B{~/.bashrc<br/>exists?}
    B -->|No| C[Error Message]
    B -->|Yes| D[Read current config]
    D --> E[Apply sed substitutions]
    E --> F[HISTSIZE → 10000]
    E --> G[HISTFILESIZE → 2000]
    F --> H[Write to ~/.bashrc]
    G --> H
    H --> I[Reload with source]
    I --> J[Configuration Active]

    style A fill:#4A90E2,stroke:#2E5C8A,stroke-width:2px,color:#fff
    style J fill:#7ED321,stroke:#5FA319,stroke-width:2px
    style C fill:#D0021B,stroke:#A00116,stroke-width:2px,color:#fff
```

### Modification Pattern

The script uses `sed` with the following patterns:

```bash
sed -i "s/HISTSIZE.*/$HISTSIZE/g" ~/.bashrc
sed -i "s/HISTFILESIZE.*/$HISTFILESIZE/g" ~/.bashrc
```

This matches any line starting with `HISTSIZE` or `HISTFILESIZE` and replaces the entire line with the new value.

## Benefits

```mermaid
graph TB
    subgraph Benefits
        A[Enhanced History] --> B[More Commands Stored]
        A --> C[Better Command Recall]
        A --> D[Improved Productivity]

        B --> E[10x memory capacity]
        C --> F[Easy command retrieval]
        D --> G[Less retyping]
    end

    style A fill:#4A90E2,stroke:#2E5C8A,stroke-width:3px,color:#fff
    style B fill:#7ED321,stroke:#5FA319,stroke-width:2px
    style C fill:#7ED321,stroke:#5FA319,stroke-width:2px
    style D fill:#7ED321,stroke:#5FA319,stroke-width:2px
```

## Use Cases

1. **Developers**: Retain complex command sequences and build commands
2. **System Administrators**: Keep track of system maintenance commands
3. **DevOps Engineers**: Maintain history of deployment and configuration commands
4. **Power Users**: Enhanced command line productivity

## Safety Features

- File existence validation before modification
- Non-destructive sed replacements
- Automatic configuration reload
- Clear user feedback at each step

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## Repository Information

```mermaid
graph LR
    A[Repository: gpt_shell] --> B[License: GPL v3]
    A --> C[Language: Bash]
    A --> D[Purpose: Shell Configuration]

    style A fill:#4A90E2,stroke:#2E5C8A,stroke-width:3px,color:#fff
```

## Author

Created and maintained by the GPT Shell project contributors.

## Support

For issues, questions, or contributions, please visit the repository's issue tracker.

---

**Note**: Always backup your `~/.bashrc` file before running scripts that modify it. While this script is designed to be safe, it's good practice to maintain backups of your configuration files.
