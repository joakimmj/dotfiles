# Git

## Git config

### User
``` tangle:~/.config/git/config
[user]
    email = joakim+github@myrvoll.dev
    name = joakimmj
```

### Core settings
``` tangle:~/.config/git/config
[core]
```

Set default editor
``` tangle:~/.config/git/config
    editor = vim
```

Keep newlines as in input
``` tangle:~/.config/git/config
    autocrlf = input
```

### Rerere settings

Activate recording of resolved conflicts, so that identical conflict hunks can be resolved automatically, should they be encountered again.
``` tangle:~/.config/git/config
[rerere]
    enabled = true
```

### Column settings

Specify whether supported commands should output in columns. 
``` tangle:~/.config/git/config
[column]
    ui = auto
```

### Branch settings

Order branches based on commit dates
``` tangle:~/.config/git/config
[branch]
    sort = -committerdate
```

### Advice settings

Disable advices for empty add
``` tangle:~/.config/git/config
[advice]
    addEmptyPathspec = false
```

### Init settings

Set default branch name to `main`
``` tangle:~/.config/git/config
[init]
    defaultBranch = main
```

### Status settings

``` tangle:~/.config/git/config
[status]
```

Show branch
``` tangle:~/.config/git/config
    branch = true
```

Use short style (less text)
``` tangle:~/.config/git/config
    short = true
```

Show stash
``` tangle:~/.config/git/config
    showStash = true
```

Show individual untracked files
``` tangle:~/.config/git/config
    showUntrackedFiles = all
```

### Blame settings
``` tangle:~/.config/git/config
[blame]
```

Show relative date
``` tangle:~/.config/git/config
    date = relative
```

Highlight the most recent changes
``` tangle:~/.config/git/config
    coloring = highlightRecent
```

Show email instead of author name
``` tangle:~/.config/git/config
    showEmail = true
```

### Diff settings
``` tangle:~/.config/git/config
[diff]
```

Less context in diffs
``` tangle:~/.config/git/config
    context = 3
```

Detect copies as renames in diffs
``` tangle:~/.config/git/config
    renames = copies
```

Merge near hunks in diffs
``` tangle:~/.config/git/config
    interHunkContext = 10
```

### Log/show/whatchanged settings

The default pretty format for log/show/whatchanged command.
``` tangle:~/.config/git/config
[format]
    pretty = %C(bold blue)%ae%C(reset) %C(green)%cr (%cs)%C(reset) %C(red)%d%C(reset) %n %C(yellow)%h%C(reset) %s
```

### Commit settings

``` tangle:~/.config/git/config
[commit]
    template = ~/.config/git/template
```

### Push settings

Default set upstream when no upstream tracking exists for the current branch
``` tangle:~/.config/git/config
[push]
    autoSetupRemote = true
```

### Rebase settings

``` tangle:~/.config/git/config
[rebase]
```

`--autosquash` by default
``` tangle:~/.config/git/config
    autoSquash = true
```

Stash dirty worktree on rebase (pops stash afterwards)
``` tangle:~/.config/git/config
    autoStash = true
```

### Shortcuts

Add shortcut for github (e.g. `git clone gh:joakimmj/dotfiles`)
``` tangle:~/.config/git/config
[url "git@github.com:"]
    insteadOf = "gh:"
```

Add shortcut for cloning my own repos (e.g. `git clone me:dotfiles`)
``` tangle:~/.config/git/config
[url "git@github.com:joakimmj/"]
    insteadOf = "me:"
```

### Aliases
``` tangle:~/.config/git/config
[alias]
```

#### Commands

Some sane commands
``` tangle:~/.config/git/config
    alias        = config --get-regexp alias                 # List all aliases
    blame-       = blame --color-line --color-by-age         # Blame
    blame-c      = blame -w -C -C -C --color-line --color-by-age # Blame (ignore whitespace and code moves) 
    changed      = whatchanged --since='2 weeks ago'         # Changes last two weeks
    cleanup      = git gc --prune=now --aggressive           # Cleanup local state
    discard      = checkout -p                               # Discard changes in patches
    discard-all  = checkout .                                # Discard all changes
    last         = log -1 HEAD                               # Show last commit
    last-3       = log -3 HEAD                               # Show last three commits
    push-f       = push --force-with-lease                   # Force push if your commit is latest
    remote-diff  = diff @{upstream}                          # Show diff between local and remote
    reset-patch  = restore -p -s HEAD                        # Reset changes (patch version)
    staged       = diff --staged                             # Show staged changes
    unstage      = reset HEAD --                             # Unstage changes
    unstage-last = reset HEAD~                               # Unstage changes from last commit (used to undo/split commit)
    update       = remote update origin --prune              # Update remote info
```

Alias for stashing only untracked files
``` tangle:~/.config/git/config
    stash-untracked = "!f() {       \
        git stash -q;               \
        git stash -uq;              \
        git stash pop stash@{1} -q; \
        git add -A;                 \
        git status -sb;             \
    }; f"
```

#### Shortcuts

Even shorter aliases for often used commands
``` tangle:~/.config/git/config
    a           = add                                       # Add changes
    aa          = add -A                                    # Add all changes
    ap          = add -p                                    # Add changes in patches
    b           = branch -vv                                # List local branches
    ba          = branch -a -vv                             # List both remote-tracking branches and local branches.
    bd          = branch -d                                 # Delete a branch only if it has been merged
    bD          = branch -D                                 # Force delete a branch
    c           = commit -v                                 # Commit you changes (verbose)
    ca          = commit -v --amend                         # Amend commit to previous commit (verbose)
    co          = checkout                                  # Checkout a branch
    cob         = checkout -b                               # Checkout a new not yet existing branch
    cop         = checkout -                                # Checkout previous branch
    d           = diff                                      # Show unstaged changes
    dw          = diff --word-diff                          # Show unstaged changes (by word)
    ds          = diff --staged                             # Show staged changes
    dsw         = diff --staged --word-diff                 # Show staged changes (by word)
    l           = log --graph                               # Changelog
    ll          = log --graph --all                         # Changelog (all changes)
    ms          = maintenance start                         # Cron job that cleans repo (makes git faster)
    p           = pull                                      # Pull your changes to remote
    rd          = diff @{upstream}                          # Show diff between local and remote
    s           = status -sb                                # Show status (minified)
    ss          = status --show-stash                       # Show status
    st          = stash                                     # Stash changes
    stu         = stash -u                                  # Stash changes (also untracked)
    stus        = stash save --keep-index                   # Stash changes (unstaged)
    stp         = stash pop                                 # Pop stashed changes
    u           = remote update origin --prune              # Update remote info
```

## Ignore
Set files to ignore by default.

``` tangle:~/.config/git/ignore
.session.vim
.tmp.*
.factorypath
```

## Template

Commit template
``` tangle:~/.config/git/template

# Semantic commit messages
#   <type>(<scope>): <subject>
#   <summary in present tense>
#
# Types:
# - `feat`: new feature for the user, not a new feature for build script
# - `fix`: bug fix for the user, not a fix to a build script
# - `docs`: changes to the documentation
# - `style`: formatting, missing semi colons, etc; no production code change
# - `refactor`: refactoring production code, eg. renaming a variable
# - `test`: adding missing tests, refactoring tests; no production code change
# - `chore`: updating grunt tasks etc; no production code change
```

