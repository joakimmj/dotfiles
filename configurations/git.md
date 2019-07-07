# Git config

## User
``` tangle:~/.gitconfig
[user]
    email = joakimmyrvoll@gmail.com
    name = joakimmj
```

## Editor
``` tangle:~/.gitconfig
[core]
    editor = vim
```

## Aliases
``` tangle:~/.gitconfig
[alias]
```

### Commands

Some sane commands
``` tangle:~/.gitconfig
    alias        = config --get-regexp alias                 # List all aliases
    changed      = whatchanged --since='2 weeks ago'         # Changes last two weeks
    cleanup      = git gc --prune=now --aggressive           # Cleanup local state
    discard      = checkout -p                               # Discard changes in patches
    discard-all  = checkout .                                # Discard all changes
    last         = log -1 HEAD                               # Show last commit
    last-3       = log -3 HEAD                               # Show last three commits
    log-blame    = log --oneline --graph --decorate --pretty=format:'%C(yellow)%h%C(reset) %C(bold blue)%an%C(reset) %C(green)%cr%C(reset) %C(red)%d%C(reset) %s'
    staged       = diff --staged                             # Show staged changes
    unstage      = reset HEAD --                             # Unstage changes
    unstage-last = reset HEAD~                               # Unstage changes from last commit (used to undo/split commit)
    update       = remote update origin --prune              # Update remote info
```

### Shortcuts

Even shorter aliases for often used commands
``` tangle:~/.gitconfig
    a           = add                                       # Add changes
    aa          = add -A                                    # Add all changes
    ap          = add -p                                    # Add changes in patches
    b           = branch                                    # List local branches
    ba          = branch -a                                 # List both remote-tracking branches and local branches.
    bd          = branch -d                                 # Delete a branch only if it has been merged
    bD          = branch -D                                 # Force delete a branch
    c           = commit -v                                 # Commit you changes (verbose)
    ca          = commit -v --amend                         # Amend commit to previous commit (verbose)
    co          = checkout                                  # Checkout a branch
    cob         = checkout -b                               # Checkout a new not yet existing branch
    cop         = checkout -                                # Checkout previous branch
    d           = diff                                      # Show unstaged changes
    ds          = diff --staged                             # Show staged changes
    l           = log --oneline --graph --decorate          # Changelog
    ll          = log --oneline --graph --decorate --all    # Changelog (all changes)
    p           = pull                                      # Pull your changes to remote
    s           = status -sb                                # Show status (minified)
    ss          = status                                    # Show status
    st          = stash                                     # Stash changes
    stu         = stash -u                                  # Stash changes (also untracked)
    stus        = stash save --keep-index                   # Stash changes (unstaged)
    stp         = stash pop                                 # Pop stashed changes
    u           = remote update origin --prune              # Update remote info
```
