#!/usr/bin/env zsh

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

# Detect actual Homebrew install (prefer native arm64 when both exist)
if [[ -x /opt/homebrew/bin/brew ]]; then
  export HOMEBREW_PREFIX=/opt/homebrew
elif [[ -x /usr/local/bin/brew ]]; then
  export HOMEBREW_PREFIX=/usr/local
fi
export HOMEBREW_PATH="${HOMEBREW_PREFIX}/opt/powerlevel10k"


# Build PATH from a list; only directories that exist are added
path=($path)
dirs=(
  "$HOME/.gem/bin"
  "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  "$ANDROID_HOME/platform-tools"
  "$ANDROID_HOME/emulator"
  "$HOME/.local/bin"
)
for dir in $dirs; do
  [[ -d $dir ]] && path+=("$dir")
done
export PATH="${(j.:.)path}"



# chruby (path derived from HOMEBREW_PREFIX set above)
if [[ -d "${HOMEBREW_PREFIX}/opt/chruby" ]]; then
  source "${HOMEBREW_PREFIX}/opt/chruby/share/chruby/chruby.sh"
  source "${HOMEBREW_PREFIX}/opt/chruby/share/chruby/auto.sh"
fi