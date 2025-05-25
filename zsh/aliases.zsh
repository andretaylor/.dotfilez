#!/bin/bash

#-------------------------------------------------------------
# Filesystem operations
# --------------------------------------------------------------
alias cp="cp -iR"                    # Recursive copy directory entries. Prompt for confirmation
alias df="df -kh"                    # Displays free disk space
alias du="du -kh"                    # Displays disk usage stats in more readable output
alias md='mkdir -p'                  # Create directory with parents
alias mv="mv -i"                     # Move directory entries. Prompt for confirmation
alias path='echo -e ${PATH//:/\\\n}' # Pretty-print of PATH variables
alias rd="rmdir"                     # Remove directory
alias rm="rm -i"                     # Remove directory entries. Prompt for confirmation
alias rmf="rm -Rf"                   # Recursive remove directory entries with force
alias which="type -a"                # Locate a program in user path

# --------------------------------------------------------------
# Shell
# --------------------------------------------------------------
alias c="clear"                  # Clear screen
alias hh="history"               # CL history
alias reload="clear && exec zsh" # Restart zsh shell
alias grep='grep --color=auto'   # Colorize grep output

# --------------------------------------------------------------
# System
# --------------------------------------------------------------
alias ip="curl -s http://whatismyip.akamai.com/; echo"                                      # Display external IP address
alias localip="ipconfig getifaddr en0"                                                      # Display internal IP address
alias pm="sudo powermetrics"                                                                # Display system power metrics
alias pmct='sudo powermetrics -s smc | grep -i "CPU die temperature"'                       # Display CPU temperature
alias pmtl="pmset -g thermlog"                                                              # Display thermal log
alias pmtp="sudo powermetrics -s thermal | grep -A2 -i thermal"                             # Display thermal pressure
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'" # Pipe my public key to my clipboard
alias ds='date +%m%d%Y-%H%M%S'                                                              # Get the current date and time in a string format
alias myps='ps -u $USER -o pid,%cpu,%mem,command'                                           # Show My Processes
alias o="open ."                                                                            #Opens current directory in Finder
alias p="ps aux | grep -v grep | grep -i"                                                   # Search for a process
alias ports="lsof -i -P | grep -i listen"                                                   # List open ports

# --------------------------------------------------------------
# Directory navigation
# --------------------------------------------------------------
alias -g ..='cd ..'
alias -g ...='cd ../..'
alias -g ....='cd ../../..'
alias -g .....='cd ../../../..'
alias -g ......='cd ../../../../..'
alias dl='cd ${HOME}/Downloads'
alias docs="cd ~/Documents"
alias dt='cd ${HOME}/Desktop'
alias h='cd ~'
alias prj='cd ${HOME}/Documents/projects'

# --------------------------------------------------------------
# Directory stack
# --------------------------------------------------------------
alias d="dirs -v" # List directory stack
compdef _dirs d

# Create an alias to change directory to a specific location in the directory stack
for directory_index in {1..9}; do
  alias "$directory_index'='cd +${directory_index}"
done
unset directory_index

# --------------------------------------------------------------
# List directory contents
# --------------------------------------------------------------
alias ls="ls -G"    # Use colorized output for ls
alias l='ls -lAh'   # List all files, long format, human-readable sizes, including hidden files
alias lc="ll -tcr"  # Sort by/show change time, most recent last
alias lf="ls -1"    # List just filenames, 1 per line
alias lk="ll -Sr"   # Sort by size, biggest last
alias ll='ls -lh'   # List all files, long format, human-readable sizes
alias lll="ls -al"  # List all files
alias lsa='ls -lah' # List all files, long format, human-readable sizes
alias lt="ll -tr"   # Sort by date, most recent last
alias lu="ll -tur"  # Sort by/show access time, most recent last

# --------------------------------------------------------------
# Applications
# --------------------------------------------------------------
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'                 # Open Google Chrome
alias canary='/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary' # Open Google Chrome Canary
