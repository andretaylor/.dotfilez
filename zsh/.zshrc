#!/bin/bash

function configure_shell() {
  function load_config_files() {
    declare -a config_files

    # Order matters: Load theme first, then aliases, then local configs
    config_files=(
      "${ZSH_PLUGINS_DIR}/theme.zsh"
      "${ZDOTDIR}/config.zsh"
      "${ZSH_PLUGINS_DIR}/git/git_aliases.zsh"
      "${ZDOTDIR}/aliases.zsh"
      "${NVM_DIR}/nvm.sh"
      "${HOMEBREW_PATH}/opt/chruby/share/chruby/chruby.sh"
      "${HOMEBREW_PATH}/opt/chruby/share/chruby/auto.sh"
      "${ZDOTDIR}/.zlocal.zsh" # Local configs not stored on github
    )

    # Load each configuration file
    for file in "${config_files[@]}"; do
      if [[ -f "$file" ]]; then
        source "${file}"
      fi
    done
  }

  function configure_autoloadable_functions() {
    declare -a function_dirs

    # List of directories containing autoloadable functions
    function_dirs=(
      "$ZSH_FUNCTIONS_DIR"
      "$ZSH_PLUGINS_DIR/git/functions"
    )

    # Add each directory to fpath and autoload functions
    for dir in "${function_dirs[@]}"; do
      fpath=($dir $fpath)
      for func in $dir/*(.N); do
        autoload -Uz ${func:t:r}
      done
    done
  }

  load_config_files
  configure_autoloadable_functions
}

configure_shell
