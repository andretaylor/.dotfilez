#!/bin/bash
#-------------------------------------------------------------
# Enable colors
#-------------------------------------------------------------
autoload -U colors && colors

#-------------------------------------------------------------
# Completion
#-------------------------------------------------------------

# Enable completion system, rebuild the cache only if it’s outdated
autoload -U compinit && compinit -C

# Include hidden files in completion suggestions
_comp_options+=(globdots)

#-------------------------------------------------------------
# Options
# https://zsh.sourceforge.io/Doc/Release/Options.html
#-------------------------------------------------------------

# Directory Stack
setopt AUTO_CD           # Change to directory without cd
setopt AUTO_PUSHD        # Push the current directory visited on the stack
setopt PUSHDMINUS        # Use `-` instead of `+` for pushd and popd
setopt PUSHD_IGNORE_DUPS # Do not store duplicates in the stack
setopt PUSHD_SILENT      # Do not print the directory stack after pushd or popd
setopt PUSHD_TO_HOME     # pushd with no arguments goes to $HOME

# Shell Behavior
setopt AUTO_LIST     # Automatically list files when completing
setopt EXTENDED_GLOB # Enable extended globbing
setopt IGNORE_EOF    # Ignore EOF in interactive shell
setopt LOCAL_OPTIONS # Allow functions to have local options
setopt LOCAL_TRAPS   # Allow functions to have local traps
setopt NO_BG_NICE    # Don't nice background tasks
setopt NO_CASE_GLOB  # Case-insensitive globbing
setopt NO_HUP        # Don't kill background jobs on shell exit
setopt NO_LIST_BEEP  # Don't beep on tab completion

# History
setopt APPEND_HISTORY                   # Append history lines to the history file
setopt EXTENDED_HISTORY                 # Add timestamps to history
setopt HIST_IGNORE_ALL_DUPS             # Don't record duplicate entries in history
setopt HIST_REDUCE_BLANKS               # Remove leading/trailing blanks from history
setopt HIST_VERIFY                      # Show command with history expansion to be executed
setopt INC_APPEND_HISTORY SHARE_HISTORY # Incrementally append commands to the history file as they are entered and share it across sessions
setopt SHARE_HISTORY                    # Share history between sessions

# Command Line Editing and Completion
setopt COMPLETE_ALIASES # Don't expand aliases before completion has finished
setopt COMPLETE_IN_WORD # Allow completion in the middle of a word
setopt CORRECT          # Autocorrect typos
setopt PROMPT_SUBST     # Allow command substitution in prompt

#-------------------------------------------------------------
# Keymaps
# https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Keymaps
#-------------------------------------------------------------
bindkey '^[^[[D' backward-word    # Alt + Left
bindkey '^[^[[C' forward-word     # Alt + Right
bindkey '^[[5D' beginning-of-line # Ctrl + Left
bindkey '^[[5C' end-of-line       # Ctrl + Right
bindkey '^[[3~' delete-char       # Delete
bindkey '^?' backward-delete-char # Backspace
