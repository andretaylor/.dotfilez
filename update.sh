#!/bin/bash

function update_dotfilez() {
  clear

  # Define base path
  local DOTFILES_DIR="${HOME}/.config/.dotfilez"

  # Define color variables
  local COLOR_GREEN='\033[0;32m'
  local COLOR_YELLOW='\033[0;33m'
  local COLOR_RED='\033[0;31m'
  local COLOR_PURPLE='\033[0;35m'
  local COLOR_BLUE='\033[0;34m'
  local RESET_COLOR='\033[0m'

  # Define icons
  local SUCCESS_ICON="${COLOR_GREEN}✔${RESET_COLOR}"
  local FAILED_ICON="${COLOR_RED}✖${RESET_COLOR}"
  local UPDATE_ICON="${COLOR_BLUE}↻${RESET_COLOR}"

  # Helper function to display a countdown timer with a message
  function countdown() {
    local seconds=${1:-5}               # Default to 5 seconds if not specified
    local message=${2:-"Continuing in"} # Default message

    print_message "$COLOR_YELLOW" "$message:" ""

    for ((i = seconds; i >= 0; i--)); do
      printf "\r%b%s %d seconds...%b" "$COLOR_YELLOW" "$message" $i "$RESET_COLOR"
      sleep 1
    done

    printf "\n"
  }

  # Helper function to print messages
  function print_message() {
    local color="$1"
    local message="$2"
    local icon="${3:-}"

    # If an icon is provided, print the message with the icon
    if [ -n "$icon" ]; then
      printf "%b%s %b\n" "${color:-$RESET_COLOR}" "$message" "$icon"
    else
      # Otherwise just print the message
      printf "%b%s%b\n" "${color:-$RESET_COLOR}" "$message" "$RESET_COLOR"
    fi
  }

  # Function to handle shell restart
  function handle_shell_restart() {
    # Ask if the user wants to restart the shell
    print_message "$COLOR_YELLOW" "Do you want to restart your shell to apply changes? (y/n)" ""
    read -r restart_shell

    if [[ "$restart_shell" =~ ^[Yy]$ ]]; then
      print_message "$COLOR_GREEN" "Restarting shell..." "$SUCCESS_ICON"
      countdown 3 "Restarting shell in"
      exec $SHELL -l
    else
      print_message "$COLOR_YELLOW" "Changes will be applied on next shell restart" "$UPDATE_ICON"
    fi
  }

  function verify_symlinks() {
    local zshenv_path="${HOME}/.zshenv"
    local zshenv_target="${DOTFILES_DIR}/zsh/.zshenv"

    print_message "$COLOR_YELLOW" "Verifying symlinks..." "$UPDATE_ICON"

    if [ ! -L "$zshenv_path" ] || [ "$(readlink "$zshenv_path")" != "$zshenv_target" ]; then
      print_message "$COLOR_YELLOW" "Fixing symlink for .zshenv" "$UPDATE_ICON"
      [ -L "$zshenv_path" ] && rm "$zshenv_path"
      ln -s "$zshenv_target" "$zshenv_path" && print_message "$COLOR_GREEN" "Symlink fixed" "$SUCCESS_ICON"
    else
      print_message "$COLOR_GREEN" "Symlinks verified" "$SUCCESS_ICON"
    fi
  }

  function update_homebrew() {
    if command -v brew &>/dev/null; then
      print_message "$COLOR_YELLOW" "Updating Homebrew..." "$UPDATE_ICON"
      brew update && brew upgrade && print_message "$COLOR_GREEN" "Homebrew updated" "$SUCCESS_ICON"

      print_message "$COLOR_YELLOW" "Updating Brewfile packages..." "$UPDATE_ICON"
      brew bundle --file="${DOTFILES_DIR}/Brewfile" && print_message "$COLOR_GREEN" "Brewfile packages updated" "$SUCCESS_ICON"

      print_message "$COLOR_YELLOW" "Cleaning up Homebrew..." "$UPDATE_ICON"
      brew cleanup && print_message "$COLOR_GREEN" "Homebrew cleanup complete" "$SUCCESS_ICON"
    else
      print_message "$COLOR_RED" "Homebrew not installed. Run install.sh first." "$FAILED_ICON"
    fi
  }

  function update_dotfilez_repo() {
    # Check if dotfilez is a git repository
    if [ -d "${DOTFILES_DIR}/.git" ]; then
      print_message "$COLOR_YELLOW" "Updating dotfilez repository..." "$UPDATE_ICON"

      # Store current directory and move to dotfilez directory
      local current_dir=$(pwd)
      cd "${DOTFILES_DIR}"

      # Check for uncommitted changes
      if ! git diff --quiet; then
        print_message "$COLOR_YELLOW" "Uncommitted changes detected in dotfilez" "$UPDATE_ICON"
        print_message "$COLOR_YELLOW" "Stashing changes before pulling" "$UPDATE_ICON"
        git stash
      fi

      # Pull latest changes
      if git pull; then
        print_message "$COLOR_GREEN" "Dotfilez repository updated" "$SUCCESS_ICON"
      else
        print_message "$COLOR_RED" "Failed to update dotfilez repository" "$FAILED_ICON"
      fi

      # Return to original directory
      cd "$current_dir"
    else
      print_message "$COLOR_YELLOW" "Dotfilez is not a git repository, skipping updates" "$UPDATE_ICON"
    fi
  }

  print_message "$COLOR_PURPLE" "Starting dotfilez update..." "$UPDATE_ICON"

  update_dotfilez_repo
  verify_symlinks
  update_homebrew

  print_message "$COLOR_GREEN" "Update complete!" "$SUCCESS_ICON"

  handle_shell_restart
}

update_dotfilez
