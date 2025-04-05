#!/bin/bash

#-------------------------------------------------------------
# XDG Base Directory
#-------------------------------------------------------------
export XDG_CONFIG_HOME="${HOME}/.config"              # Configuration files
export XDG_DATA_HOME="${XDG_CONFIG_HOME}/local/share" # User data files
export XDG_CACHE_HOME="${XDG_CONFIG_HOME}/cache"      # User cache files

#-------------------------------------------------------------
# Zsh Configuration
#-------------------------------------------------------------
# export HOMEBREW_PATH="$(brew --prefix)"            # Homebrew path
export DOTFILEZ="${XDG_CONFIG_HOME}/.dotfilez"     # Dotfilez directory
export NVM_DIR="${XDG_CONFIG_HOME}/nvm"            # Node Version Manager directory
export ZDOTDIR="${DOTFILEZ}/zsh"                   # Zsh directory
export HISTFILE="${ZDOTDIR}/.zhistory"             # History filepath
export ZSH_FUNCTIONS_DIR="${ZDOTDIR}/functions"    # Zsh functions directory
export ZSH_PLUGINS_DIR="${ZDOTDIR}/plugins"        # Zsh plugins directory

#-------------------------------------------------------------
# History Configuration
#-------------------------------------------------------------
export HISTSIZE=10000                         # Maximum events for internal history
export SAVEHIST=10000                         # Maximum events in history file
export LESSHISTFILE="${ZDOTDIR}/.lesshistory" # Less history filepath
export LESSHISTSIZE=10000                     # Maximum events in less history file

#-------------------------------------------------------------
# Color and Output Configuration
#-------------------------------------------------------------
export LSCOLORS="exfxcxdxbxegedabagacad" # Colorized ls output
export CLICOLOR=true                     # Enable colorized output for ls

#-------------------------------------------------------------
# Miscellaneous Configuration
#-------------------------------------------------------------
export EDITOR="nvim"  # Set default editor to Neovim
export VISUAL="code"  # Set default visual editor to VS Code
export PAGER="less"   # Set default pager to less
export LESS="-R"      # Pass -R option to less
export DIRSTACKSIZE=8 # Directory stack size

# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi