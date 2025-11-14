#!/bin/bash
# Installation script for GPT Shell - Bash History Modifier
# This script provides a safe, guided installation process

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Banner
echo -e "${BLUE}"
cat << "EOF"
   ____ ____ _____   ____  _          _ _
  / ___|  _ \_   _| / ___|| |__   ___| | |
 | |  _| |_) || |   \___ \| '_ \ / __| | |
 | |_| |  __/ | |    ___) | | | |  __| | |
  \____|_|    |_|   |____/|_| |_|\___|_|_|

  Bash History Modifier - Installation
EOF
echo -e "${NC}"

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}Warning: This script should not be run as root.${NC}"
    echo -e "${YELLOW}Please run as a regular user.${NC}"
    exit 1
fi

# Check if ~/.bashrc exists
if [ ! -f "$HOME/.bashrc" ]; then
    echo -e "${RED}Error: ~/.bashrc not found${NC}"
    echo "This script requires a ~/.bashrc file to modify."
    exit 1
fi

echo -e "${GREEN}Installation Process${NC}"
echo "===================="
echo ""

# Step 1: Show current settings
echo -e "${BLUE}Step 1: Current History Settings${NC}"
echo "--------------------------------"
CURRENT_HISTSIZE=$(grep "^HISTSIZE=" ~/.bashrc 2>/dev/null | head -1 || echo "HISTSIZE=not set")
CURRENT_HISTFILESIZE=$(grep "^HISTFILESIZE=" ~/.bashrc 2>/dev/null | head -1 || echo "HISTFILESIZE=not set")
echo "Current settings in ~/.bashrc:"
echo "  $CURRENT_HISTSIZE"
echo "  $CURRENT_HISTFILESIZE"
echo ""

# Step 2: Backup
echo -e "${BLUE}Step 2: Creating Backup${NC}"
echo "----------------------"
BACKUP_DIR="$HOME/.gpt_shell_backups"
mkdir -p "$BACKUP_DIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/bashrc_backup_$TIMESTAMP"
cp "$HOME/.bashrc" "$BACKUP_FILE"
echo -e "${GREEN}✓ Backup created: $BACKUP_FILE${NC}"
echo ""

# Step 3: Confirm installation
echo -e "${BLUE}Step 3: Confirm Installation${NC}"
echo "---------------------------"
echo "This script will modify your ~/.bashrc to set:"
echo "  HISTSIZE=10000 (from $(echo $CURRENT_HISTSIZE | cut -d'=' -f2))"
echo "  HISTFILESIZE=2000 (from $(echo $CURRENT_HISTFILESIZE | cut -d'=' -f2))"
echo ""
read -p "Do you want to proceed? (y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Installation cancelled.${NC}"
    exit 0
fi

# Step 4: Make histmod.sh executable
echo -e "${BLUE}Step 4: Preparing Script${NC}"
echo "----------------------"
if [ -f "./histmod.sh" ]; then
    chmod +x ./histmod.sh
    echo -e "${GREEN}✓ Made histmod.sh executable${NC}"
else
    echo -e "${RED}Error: histmod.sh not found in current directory${NC}"
    exit 1
fi
echo ""

# Step 5: Run histmod.sh
echo -e "${BLUE}Step 5: Applying Changes${NC}"
echo "----------------------"
./histmod.sh
echo ""

# Step 6: Verify installation
echo -e "${BLUE}Step 6: Verifying Installation${NC}"
echo "-----------------------------"
NEW_HISTSIZE=$(grep "^HISTSIZE=" ~/.bashrc 2>/dev/null | head -1)
NEW_HISTFILESIZE=$(grep "^HISTFILESIZE=" ~/.bashrc 2>/dev/null | head -1)
echo "New settings in ~/.bashrc:"
echo "  $NEW_HISTSIZE"
echo "  $NEW_HISTFILESIZE"
echo ""

# Check if changes were applied
if [[ "$NEW_HISTSIZE" == "HISTSIZE=10000" ]] && [[ "$NEW_HISTFILESIZE" == "HISTFILESIZE=2000" ]]; then
    echo -e "${GREEN}✓ Installation successful!${NC}"
    echo ""
    echo -e "${GREEN}Your bash history settings have been enhanced.${NC}"
    echo ""
    echo "The changes are now active in your current shell."
    echo "New terminal sessions will automatically use these settings."
else
    echo -e "${RED}✗ Installation verification failed${NC}"
    echo "Some settings may not have been applied correctly."
    echo "You can restore your original settings with:"
    echo "  cp $BACKUP_FILE ~/.bashrc && source ~/.bashrc"
    exit 1
fi

# Step 7: Post-installation info
echo ""
echo -e "${BLUE}Additional Information${NC}"
echo "---------------------"
echo "Backup location: $BACKUP_FILE"
echo ""
echo "To restore your original settings:"
echo "  cp $BACKUP_FILE ~/.bashrc && source ~/.bashrc"
echo ""
echo "To view all backups:"
echo "  ls -lh $BACKUP_DIR/"
echo ""
echo -e "${GREEN}Thank you for using GPT Shell!${NC}"
