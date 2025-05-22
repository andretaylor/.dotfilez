#!/bin/bash

function install_dotfilez() {
    clear

    # Define base path
    local DOTFILES_DIR="${HOME}/.config/.dotfilez"

    # Define color variables
    local COLOR_GREEN='\033[0;32m'
    local COLOR_YELLOW='\033[0;33m'
    local COLOR_RED='\033[0;31m'
    local COLOR_PURPLE='\033[0;35m'
    local RESET_COLOR='\033[0m'

    # Define icons
    local SUCCESS_ICON="${COLOR_GREEN}✔${RESET_COLOR}"
    local FAILED_ICON="${COLOR_RED}✖${RESET_COLOR}"

    function countdown_timer_with_message() {
        local seconds=${1:-5}               # Default to 5 seconds if not specified
        local message=${2:-"Continuing in"} # Default message

        print_message "$COLOR_YELLOW" "$message:" ""

        for ((i = seconds; i >= 0; i--)); do
            printf "\r%b%s %d seconds...%b" "$COLOR_YELLOW" "$message" $i "$RESET_COLOR"
            sleep 1
        done

        printf "\n"
    }

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

    function setup_zshenv() {
        local zshenv_path="${HOME}/.zshenv"
        local zshenv_target="${DOTFILES_DIR}/zsh/.zshenv"

        if [ -L "$zshenv_path" ]; then
            print_message "$COLOR_YELLOW" "Removing existing symlink $zshenv_path" "$SUCCESS_ICON"
            rm "$zshenv_path" && print_message "$COLOR_GREEN" "Symlink removed" "$SUCCESS_ICON"
        fi

        print_message "$COLOR_YELLOW" "Creating symlink $zshenv_path -> $zshenv_target" "$SUCCESS_ICON"
        ln -s "$zshenv_target" "$zshenv_path" && print_message "$COLOR_GREEN" "Symlink created" "$SUCCESS_ICON"
    }

    function setup_homebrew() {
        if ! command -v brew &>/dev/null; then
            print_message "$COLOR_YELLOW" "Installing Homebrew..." "$SUCCESS_ICON"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        else
            print_message "$COLOR_RED" "Homebrew already installed." "$FAILED_ICON"
        fi
        print_message "$COLOR_YELLOW" "Updating Homebrew..." "$SUCCESS_ICON"
        brew update && brew upgrade
    }

    function install_brewfile() {
        print_message "$COLOR_YELLOW" "Installing Brewfile..." "$SUCCESS_ICON"
        brew bundle --file="${DOTFILES_DIR}/Brewfile"
    }

    function setup_macos_defaults() {
        print_message "$COLOR_YELLOW" "Setting macOS defaults..." "$SUCCESS_ICON"
        source "${DOTFILES_DIR}/macos/set-defaults.sh"
    }

    function setup_gitconfig() {
        # Set default branch name for new Git repositories
        git config --global init.defaultBranch main
        # Set default editor for Git
        git config --global core.editor "vim"
    }

    print_message "$COLOR_PURPLE" "Setting up dotfilez..." "$SUCCESS_ICON"

    setup_zshenv
    setup_homebrew
    install_brewfile
    setup_macos_defaults
    setup_gitconfig

    print_message "$COLOR_GREEN" "Setup complete." "$SUCCESS_ICON"

    print_message "$COLOR_GREEN" "Restarting shell..." "$SUCCESS_ICON"
    countdown_timer_with_mes 5 "Restarting shell in"
    exec $SHELL -l
}

install_dotfilez
