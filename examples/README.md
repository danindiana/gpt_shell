# Examples Directory

This directory contains example scripts and usage demonstrations for the GPT Shell project.

## Files

### usage_example.sh
A comprehensive walkthrough of how to use `histmod.sh`, including:
- Basic usage examples
- How to check current settings
- How to verify changes
- How to utilize the enhanced history features

### backup_bashrc.sh
A safety-first backup script that:
- Creates timestamped backups of your `.bashrc` file
- Stores backups in `~/.config_backups/`
- Provides restore commands
- Lists all available backups

## Running the Examples

```bash
# Make scripts executable
chmod +x examples/*.sh

# View usage examples
./examples/usage_example.sh

# Create a backup before running histmod.sh
./examples/backup_bashrc.sh

# Then run the main script safely
./histmod.sh
```

## Best Practices

1. Always create a backup before modifying configuration files
2. Review the script output to ensure changes were applied
3. Test in a non-production environment first
4. Keep multiple backup versions for safety

## Workflow Diagram

```mermaid
flowchart LR
    A[Start] --> B[Run backup_bashrc.sh]
    B --> C[Review current settings]
    C --> D[Run histmod.sh]
    D --> E[Verify changes]
    E --> F{Success?}
    F -->|Yes| G[Enjoy enhanced history!]
    F -->|No| H[Restore from backup]
    H --> I[Troubleshoot]
    I --> D

    style A fill:#4A90E2,stroke:#2E5C8A,stroke-width:2px,color:#fff
    style G fill:#7ED321,stroke:#5FA319,stroke-width:2px
    style H fill:#F5A623,stroke:#C98419,stroke-width:2px
```
