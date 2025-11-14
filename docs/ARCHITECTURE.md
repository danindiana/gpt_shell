# Architecture Documentation

## System Architecture

```mermaid
C4Context
    title System Context Diagram - GPT Shell

    Person(user, "User", "System administrator or developer")
    System(gptshell, "GPT Shell", "Bash history configuration tool")
    System_Ext(bashrc, ".bashrc", "Bash configuration file")
    System_Ext(bash, "Bash Shell", "Command interpreter")

    Rel(user, gptshell, "Runs")
    Rel(gptshell, bashrc, "Reads and modifies")
    Rel(bashrc, bash, "Configures")
    Rel(bash, user, "Provides enhanced history")
```

## Component Architecture

```mermaid
graph TB
    subgraph "GPT Shell System"
        A[histmod.sh] --> B[Configuration Reader]
        A --> C[Backup Manager]
        A --> D[Configuration Writer]
        A --> E[Validator]

        B --> F[sed Commands]
        C --> G[File Operations]
        D --> F
        E --> H[Error Handler]
    end

    subgraph "External Systems"
        I[~/.bashrc]
        J[Bash Shell]
    end

    B -.->|reads| I
    D -.->|writes| I
    I -.->|sources| J

    style A fill:#4A90E2,stroke:#2E5C8A,stroke-width:3px,color:#fff
```

## Data Flow

```mermaid
flowchart LR
    A[User Input] --> B{File Check}
    B -->|Exists| C[Read Current Values]
    B -->|Not Found| D[Error Exit]

    C --> E[Parse HISTSIZE]
    C --> F[Parse HISTFILESIZE]

    E --> G[Apply New Value<br/>HISTSIZE=10000]
    F --> H[Apply New Value<br/>HISTFILESIZE=2000]

    G --> I[Write to File]
    H --> I

    I --> J[Reload Shell Config]
    J --> K[Verify Changes]
    K --> L[Success]

    style A fill:#4A90E2,stroke:#2E5C8A,stroke-width:2px,color:#fff
    style L fill:#7ED321,stroke:#5FA319,stroke-width:2px
    style D fill:#D0021B,stroke:#A00116,stroke-width:2px,color:#fff
```

## Deployment Architecture

```mermaid
graph TB
    subgraph "User System"
        A[Git Clone] --> B[Local Repository]
        B --> C[install.sh]
        C --> D[histmod.sh]

        D --> E[~/.bashrc]
        E --> F[Bash Sessions]

        subgraph "Backup System"
            G[~/.gpt_shell_backups/]
            H[Timestamped Backups]
        end

        C --> G
        G --> H
    end

    style A fill:#4A90E2,stroke:#2E5C8A,stroke-width:2px,color:#fff
    style F fill:#7ED321,stroke:#5FA319,stroke-width:2px
```

## State Machine

```mermaid
stateDiagram-v2
    [*] --> Initialized: Script starts
    Initialized --> CheckingFile: Locate .bashrc
    CheckingFile --> FileFound: File exists
    CheckingFile --> FileNotFound: File missing

    FileNotFound --> [*]: Exit with error

    FileFound --> ReadingConfig: Read current values
    ReadingConfig --> ModifyingValues: Parse configuration
    ModifyingValues --> WritingConfig: Apply new values
    WritingConfig --> ReloadingShell: Write to file
    ReloadingShell --> Completed: source .bashrc
    Completed --> [*]: Exit success

    note right of FileFound
        ~/.bashrc exists
        and is readable
    end note

    note right of ModifyingValues
        HISTSIZE: 1000 → 10000
        HISTFILESIZE: 2000 → 2000
    end note
```

## Class Diagram (Conceptual)

```mermaid
classDiagram
    class HistoryModifier {
        +String bashrcPath
        +Integer newHistSize
        +Integer newHistFileSize
        +checkFile() Boolean
        +readConfig() ConfigValues
        +modifyConfig() Boolean
        +reloadShell() Boolean
        +run() Boolean
    }

    class ConfigValidator {
        +validateFile(path) Boolean
        +validateSize(size) Boolean
        +checkPermissions(path) Boolean
    }

    class BackupManager {
        +String backupDir
        +createBackup(source) String
        +listBackups() Array
        +restoreBackup(backupPath) Boolean
    }

    class ErrorHandler {
        +handleFileNotFound() void
        +handlePermissionDenied() void
        +handleInvalidValue() void
    }

    HistoryModifier --> ConfigValidator: validates
    HistoryModifier --> BackupManager: creates backup
    HistoryModifier --> ErrorHandler: handles errors
```

## Sequence Diagram - Full Flow

```mermaid
sequenceDiagram
    actor User
    participant Script as histmod.sh
    participant Validator
    participant FileSystem
    participant Bash

    User->>Script: Execute ./histmod.sh

    Script->>Validator: Check if ~/.bashrc exists
    Validator->>FileSystem: stat ~/.bashrc
    FileSystem-->>Validator: File info

    alt File exists
        Validator-->>Script: File found
        Script->>User: Print: "Found ~/.bashrc file"

        Script->>FileSystem: Read current config
        FileSystem-->>Script: Current values

        Script->>User: Print: "Modifying values"
        Script->>FileSystem: sed HISTSIZE
        Script->>FileSystem: sed HISTFILESIZE
        FileSystem-->>Script: Write successful

        Script->>User: Print: "Saving and resetting"
        Script->>Bash: source ~/.bashrc
        Bash-->>Script: Config reloaded

        Script->>User: Configuration complete
    else File not found
        Validator-->>Script: File not found
        Script->>User: Print: "~/.bashrc file not found"
        Script->>User: Exit with error
    end
```

## Technology Stack

```mermaid
graph LR
    A[GPT Shell] --> B[Bash Shell]
    A --> C[sed - Stream Editor]
    A --> D[source - Shell Built-in]
    A --> E[File System Operations]

    B --> F[POSIX Compliant]
    C --> G[Pattern Matching]
    D --> H[Configuration Reload]
    E --> I[Read/Write Operations]

    style A fill:#4A90E2,stroke:#2E5C8A,stroke-width:3px,color:#fff
```

## Security Model

```mermaid
graph TB
    subgraph "Security Layers"
        A[Input Validation] --> B[File Permission Check]
        B --> C[Backup Creation]
        C --> D[Atomic Operations]
        D --> E[Error Handling]
    end

    subgraph "Threat Mitigation"
        F[File Not Found] -.->|Handled by| B
        G[Permission Denied] -.->|Handled by| B
        H[Data Loss] -.->|Prevented by| C
        I[Partial Updates] -.->|Prevented by| D
    end

    style A fill:#7ED321,stroke:#5FA319,stroke-width:2px
    style E fill:#7ED321,stroke:#5FA319,stroke-width:2px
```

## Performance Characteristics

```mermaid
graph LR
    A[Execution Time] --> B[< 1 second]
    C[Memory Usage] --> D[Minimal - Shell only]
    E[Disk I/O] --> F[2 reads + 2 writes]
    G[Network] --> H[None required]

    style B fill:#7ED321,stroke:#5FA319,stroke-width:2px
    style D fill:#7ED321,stroke:#5FA319,stroke-width:2px
    style F fill:#7ED321,stroke:#5FA319,stroke-width:2px
    style H fill:#7ED321,stroke:#5FA319,stroke-width:2px
```

## Scalability

The system is designed for single-user, single-system deployment:

- No concurrent access issues
- No database requirements
- No network dependencies
- Minimal resource usage
- Instant execution

## Future Architecture Considerations

```mermaid
mindmap
    root((Future Enhancements))
        Multi-Shell Support
            zsh support
            fish support
            tcsh support
        Configuration Options
            Custom values via CLI
            Configuration file
            Interactive mode
        Advanced Features
            History encryption
            Cloud sync
            History analytics
        Integration
            CI/CD pipelines
            Container support
            Package managers
```
