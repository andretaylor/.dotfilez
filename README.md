# dotfilez

## Installation
```
git clone https://github.com/andretaylor/.dotfilez.git $HOME/.config/.dotfilez

cd $HOME/.config/.dotfilez &&  ./install
```

### ZSH Configuration Files
Zsh uses several configuration files to set up the shell environment. The following table summarizes the purpose of each file:

| File | Description |
|------|-------------|
| `.zshenv` | Loaded for all shells; defines environment variables, paths, and global settings that should be available everywhere. |
| `.zprofile` | Executed at login before .zshrc; ideal for setting up the login environment and defining session-wide variables. |
| `.zshrc` | The main configuration file loaded in interactive shells; contains aliases, functions, options, prompt settings, and completions. |
| `.zlogin` | Executed at the end of login shell initialization; useful for starting programs that should run once per login. |
| `.zlogout` | Executed when logging out of a login shell; perfect for cleanup tasks or displaying logout messages. |
| `.zshhistory` | Stores command history for the Zsh shell; allows users to recall and reuse previously entered commands. |

## Resources
* https://wiki.archlinux.org/title/Dotfiles
* https://thevaluable.dev/zsh-install-configure-mouseless/
* https://wiki.archlinux.org/title/XDG_Base_Directory