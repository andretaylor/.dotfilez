#!/bin/bash

# Load powerlevel10k
source ${HOMEBREW_PATH}/share/powerlevel10k/powerlevel10k.zsh-theme

# Load powerlevel10k configuration
if [[ -f ${ZDOTDIR}/.p10k.zsh ]]; then
  source ${ZDOTDIR}/.p10k.zsh
fi
