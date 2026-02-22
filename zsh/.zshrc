#!/bin/zsh

function configure_shell() {
  # Enable Powerlevel10k instant prompt. Must be sourced before slow operations.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi

  function load_config_files() {
    declare -a config_files

    # Order matters: Load theme first, then aliases, then local configs
    config_files=(
      "${ZSH_PLUGINS_DIR}/theme/theme.zsh"
      "${ZDOTDIR}/config.zsh"
      "${ZSH_PLUGINS_DIR}/git/git_aliases.zsh"
      "${ZDOTDIR}/aliases.zsh"
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

  # Lazy-load NVM
  function load_nvm_after_instant_prompt() {
    if [[ -d "${NVM_DIR}" ]]; then
      _nvm_lazy_load() {
        unfunction _nvm_lazy_load nvm node npm npx yarn pnpm 2>/dev/null
        source "${NVM_DIR}/nvm.sh"
      }
      nvm()  { _nvm_lazy_load; nvm  "$@"; }
      node() { _nvm_lazy_load; node "$@"; }
      npm()  { _nvm_lazy_load; npm  "$@"; }
      npx()  { _nvm_lazy_load; npx  "$@"; }
      yarn() { _nvm_lazy_load; yarn "$@"; }
      pnpm() { _nvm_lazy_load; pnpm "$@"; }
    fi
  }

  load_config_files
  load_nvm_after_instant_prompt
  configure_autoloadable_functions

  # Load direnv hook
  eval "$(direnv hook zsh)" >/dev/null 2>&1

}

configure_shell
