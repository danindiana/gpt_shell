#A bash script which locates the ~/.bashrc file. Modifies the ~/.bashrc file values for HISTSIZE to HISTSIZE=10000 and HISTFILESIZE=2000. 
#Saves the file and reset the bashrc by executing source ~/.bashrc in the command line.

#!/bin/bash

#Locate and modify ~/.bashrc
HISTSIZE="HISTSIZE=10000"
HISTFILESIZE="HISTFILESIZE=2000"

if [ -f ~/.bashrc ]; then
    echo "Found ~/.bashrc file"
    echo "Modifying HISTSIZE and HISTFILESIZE values"
    sed -i "s/HISTSIZE.*/$HISTSIZE/g" ~/.bashrc
    sed -i "s/HISTFILESIZE.*/$HISTFILESIZE/g" ~/.bashrc
    echo "Saving and resetting the ~/.bashrc file"
    source ~/.bashrc
else
    echo "~/.bashrc file not found"
fi
