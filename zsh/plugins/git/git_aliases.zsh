#!/bin/bash

# General Git Commands
alias g='git'                     # Shortcut for git
alias gcf='git config --list'     # List all git configurations
alias gita="alias | grep \=\'git" # List git aliases

# Adding and Staging Changes
alias ga='git add'                        # Stage changes
alias gaa='git add --all'                 # Stage all changes
alias gac='git add -A && git commit -m'   # Stage all changes and commit with message
alias gclean='git clean --interactive -d' # Interactively clean untracked files and directories
alias grm='git rm'                        # Remove files from the working tree and from the index

# Committing Changes
alias gc='git commit --verbose'                                                                                                            # Commit with verbose output
alias gc!='git commit --verbose --amend'                                                                                                   # Amend the last commit with verbose output
alias gca='git commit --verbose --all'                                                                                                     # Commit all changes with verbose output
alias gca!='git commit --verbose --all --amend'                                                                                            # Amend the last commit with all changes and verbose output
alias gcan!='git commit --verbose --all --no-edit --amend'                                                                                 # Amend the last commit with all changes, no edit, and verbose output
alias gcanf!="gcan! && ggff"                                                                                                               # Amend commit no edit and force push with lease
alias gcn='git commit --verbose --no-edit'                                                                                                 # Commit with no edit and verbose output
alias gcn!='git commit --verbose --no-edit --amend'                                                                                        # Amend the last commit with no edit and verbose output
alias gcm='gca -m'                                                                                                                         # Commit all changes with verbose output and message
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"' # Create a WIP commit
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'                                      # Undo the last WIP commit
alias grev='git revert'                                                                                                                    # Revert some existing commits

# Branching
alias gb='git branch'            # List branches
alias gba='git branch --all'     # List all branches (local and remote)
alias gbd='git branch --delete'  # Delete a branch
alias gbl='git blame -w'         # Show what revision and author last modified each line of a file
alias gbm="git branch --merged"  # List branches whose tips are reachable from HEAD
alias gcb='git copy-branch-name' # Copy the current branch name

# Checking Out
alias gco='git checkout'                                    # Switch branches or restore working tree files
alias gcop="git checkout -"                                 # Checkout the previous branch
alias gcor="git checkout -- ."                              # Remove unstaged changes
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"' # Change to the root of the git repository

# Rebasing
alias grb='git rebase'                     # Reapply commits on top of another base tip
alias grba='git rebase --abort'            # Abort the rebase process
alias grbi='git rebase --interactive'      # Start an interactive rebase
alias grbm='git rebase $(git_main_branch)' # Rebase onto the main branch

# Resetting
alias grh='git reset'         # Reset current HEAD to the specified state
alias grhh='git reset --hard' # Hard reset current HEAD to the specified state
alias grhk='git reset --keep' # Reset current HEAD to the specified state, keeping local changes
alias grhs='git reset --soft' # Soft reset current HEAD to the specified state
alias gru='git reset --'      # Unstage changes

# Showing and Logging
alias gsh='git show'                                                                                                                                    # Show various types of objects
alias gsha='git rev-parse --short HEAD'                                                                                                                 # Show the short SHA-1 hash of the current commit
alias gshal='git rev-parse HEAD'                                                                                                                        # Show the SHA-1 hash of the current commit
alias gshav='git rev-parse --short HEAD --verify'                                                                                                       # Verify and show the short SHA-1 hash of the current commit
alias gsps='git show --pretty=short --show-signature'                                                                                                   # Show the commit with signature verification
alias gsso="git show --stat --oneline"                                                                                                                  # Show status of files in HEAD or SHA
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative" # Show log with graph and formatted output
alias gcount='git shortlog --summary --numbered'                                                                                                        # Summarize git log output
alias gbl='git blame -w'                                                                                                                                # Show what revision and author last modified each line of a file

# Stashing
alias gst='git status'                # Show the working tree status
alias gsb='git status -sb'            # Show the working tree status in short format
alias gsta='git stash push'           # Stash the changes in a dirty working directory away
alias gstaa='git stash apply'         # Apply the changes recorded in the stash to the working directory
alias gstall='git stash --all'        # Stash all changes, including untracked files
alias gstc='git stash clear'          # Remove all the stashed entries
alias gstd='git stash drop'           # Remove a single stashed state from the stash list
alias gstl='git stash list'           # List the stashed changes
alias gstm="git stash push -m"        # Stash push with message
alias gstp='git stash pop'            # Apply the changes recorded in the stash to the working directory and remove the latest stash
alias gsts='git stash show --patch'   # Show the changes recorded in the stash as a patch
alias gstu='gsta --include-untracked' # Stash the changes in a dirty working directory away, including untracked files

# Pulling and Pushing
alias gl='git pull --prune'              # Fetch from and integrate with another repository or a local branch
alias gp='git push origin HEAD'          # Push the current branch to origin
alias gpu='git push upstream'            # Push the current branch to upstream
alias ggff="git push --force-with-lease" # Force push with lease
alias gly="gl && yarn"                   # Git latest and run yarn
alias gcp='git cherry-pick'              # Apply the changes introduced by some existing commits

# Diffing
alias gd='git diff'              # Show changes between commits, commit and working tree, etc.
alias gds='git diff --staged'    # Show changes between staged changes and the last commit
alias gdw='git diff --word-diff' # Show changes between commits, commit and working tree, etc., word by word
