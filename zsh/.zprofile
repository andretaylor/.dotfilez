#!/bin/zsh

# .zprofile is a login shell configuration file for zsh that is read at login.
# It's used for setting environment variables, paths, and executing commands
# that should be run only once when you login, not for every new shell.
#
# Typical contents include:
#   - Environment variables (PATH, EDITOR, LANG, etc.)
#   - Login-specific commands that should run once per session
#   - System-wide variables and startup programs

export ANDROID_HOME=$HOME/Library/Android/sdk
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
export HOMEBREW_PATH=$([[ $CPUTYPE == 'arm64' ]] && echo "/opt/homebrew" || echo "/usr/local")

# Derive npm global bin from NVM default alias without loading NVM
_nvm_default=[[ -f "${NVM_DIR}/alias/default" ]] && _nvm_default=$(<"${NVM_DIR}/alias/default")
export NPM_BIN="${NVM_DIR}/versions/node/${_nvm_default}/bin"
unset _nvm_default

# Build PATH from a list; only directories that exist are added
path=($path)
dirs=(
  "$HOME/.gem/bin"
  "$NPM_BIN"
  "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  "$ANDROID_HOME/platform-tools"
  "$ANDROID_HOME/emulator"
  "$HOME/.local/bin"
)
for dir in $dirs; do
  [[ -d $dir ]] && path+=("$dir")
done
export PATH="${(j.:.)path}"
