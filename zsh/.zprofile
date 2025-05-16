#!/bin/zsh

# .zprofile is a login shell configuration file for zsh that is read at login.
# It's used for setting environment variables, paths, and executing commands
# that should be run only once when you login, not for every new shell.
#
# Typical contents include:
#   - Environment variables (PATH, EDITOR, LANG, etc.)
#   - Login-specific commands that should run once per session
#   - System-wide variables and startup programs

export HOMEBREW_PATH=$(brew --prefix)
export PATH="${PATH}":"${HOME}/.gem/bin":"/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
