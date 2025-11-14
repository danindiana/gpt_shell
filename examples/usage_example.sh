#!/bin/bash
# Example Usage of histmod.sh
# This script demonstrates how to use histmod.sh with various scenarios

echo "=== GPT Shell - histmod.sh Usage Examples ==="
echo ""

# Example 1: Basic Usage
echo "Example 1: Basic Usage"
echo "----------------------"
echo "Command: ./histmod.sh"
echo "Description: Run the script directly to modify your ~/.bashrc"
echo ""

# Example 2: Check current history settings
echo "Example 2: Check Current History Settings Before Running"
echo "---------------------------------------------------------"
echo "Command: grep -E 'HISTSIZE|HISTFILESIZE' ~/.bashrc"
echo "Sample Output:"
echo "  HISTSIZE=1000"
echo "  HISTFILESIZE=2000"
echo ""

# Example 3: Run the script
echo "Example 3: Running the Script"
echo "-----------------------------"
echo "Command: ./histmod.sh"
echo "Expected Output:"
echo "  Found ~/.bashrc file"
echo "  Modifying HISTSIZE and HISTFILESIZE values"
echo "  Saving and resetting the ~/.bashrc file"
echo ""

# Example 4: Verify changes
echo "Example 4: Verify Changes After Running"
echo "---------------------------------------"
echo "Command: grep -E 'HISTSIZE|HISTFILESIZE' ~/.bashrc"
echo "Expected Output:"
echo "  HISTSIZE=10000"
echo "  HISTFILESIZE=2000"
echo ""

# Example 5: Check history in current session
echo "Example 5: Verify History Settings in Current Session"
echo "-----------------------------------------------------"
echo "Command: echo \$HISTSIZE"
echo "Expected Output: 10000"
echo ""
echo "Command: echo \$HISTFILESIZE"
echo "Expected Output: 2000"
echo ""

# Example 6: View recent command history
echo "Example 6: View Your Enhanced Command History"
echo "---------------------------------------------"
echo "Command: history | tail -20"
echo "Description: View the last 20 commands in your history"
echo ""

# Example 7: Search command history
echo "Example 7: Search Through Your Command History"
echo "----------------------------------------------"
echo "Command: history | grep 'git'"
echo "Description: Search for all git-related commands in your history"
echo ""

echo "=== End of Examples ==="
