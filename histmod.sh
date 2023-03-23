##A bash script which locates the ~/.bashrc file and Modifies the ~/.bashrc file values for HISTSIZE to HISTSIZE=10000 and HISTFILESIZE=2000.

#!/bin/bash

# locate the ~/.bashrc file
BASHRC=~/.bashrc

# Modify the values
sed -i 's/HISTSIZE=[0-9]*/HISTSIZE=10000/' $BASHRC
sed -i 's/HISTFILESIZE=[0-9]*/HISTFILESIZE=2000/' $BASHRC
