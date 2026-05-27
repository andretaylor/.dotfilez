#!/usr/bin/env zsh

# Powerlevel10k instant prompt — must come before slow operations
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Order matters: theme → config → git aliases → aliases → local (not in git)
for file in \
  "${ZSH_PLUGINS_DIR}/theme/theme.zsh" \
  "${ZDOTDIR}/config.zsh" \
  "${ZSH_PLUGINS_DIR}/git/git_aliases.zsh" \
  "${ZDOTDIR}/aliases.zsh" \
  "${ZDOTDIR}/.zlocal.zsh"; do
  [[ -f "$file" ]] && source "$file"
done

# Autoload functions
for dir in "$ZSH_FUNCTIONS_DIR" "$ZSH_PLUGINS_DIR/git/functions"; do
  fpath=($dir $fpath)
  for func in $dir/*(.N); do
    autoload -Uz ${func:t:r}
  done
done

# Lazy-load fnm — stubs replaced on first invocation
if command -v fnm >/dev/null; then
  _fnm_lazy_load() {
    unfunction _fnm_lazy_load fnm node npm npx yarn pnpm 2>/dev/null
    eval "$(fnm env --use-on-cd)"
  }
  fnm()  { _fnm_lazy_load; fnm  "$@"; }
  node() { _fnm_lazy_load; node "$@"; }
  npm()  { _fnm_lazy_load; npm  "$@"; }
  npx()  { _fnm_lazy_load; npx  "$@"; }
  yarn() { _fnm_lazy_load; yarn "$@"; }
  pnpm() { _fnm_lazy_load; pnpm "$@"; }
fi

# direnv hook (safe-if-missing)
command -v direnv >/dev/null && eval "$(direnv hook zsh)"
