# TMUX

## Configuration

### Options

Change the prefix key to `C-a`
``` tangle:~/.tmux.conf
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix
```

Enable mouse usage
``` tangle:~/.tmux.conf
set -g mouse on
```
No bells
``` tangle:~/.tmux.conf
set -g bell-action none
```

Attach to next session if one session is closed
``` tangle:~/.tmux.conf
set -g detach-on-destroy off
```

### Status line

Add underscore to active window
``` tangle:~/.tmux.conf
set -g window-status-current-style "underscore"
```

Allow longer session names
``` tangle:~/.tmux.conf
set -g status-left-length 20
```

Align windows to center
``` tangle:~/.tmux.conf
set -g status-justify centre
```

Start window index on 1
``` tangle:~/.tmux.conf
set -g base-index 1
```

Format right status
``` tangle:~/.tmux.conf
set -g status-right "%d.%m.%y, %H:%M"
```

### Key tables

#### Change defaults

Remove confirmation before killing window (default: `confirm-before -p "kill-window #W? (y/n)" kill-window`).
``` tangle:~/.tmux.conf
bind-key -T prefix & kill-window
```

Remove confirmation before killing pane (default: `confirm-before -p "kill-pane #P? (y/n)" kill-pane`).
``` tangle:~/.tmux.conf
bind-key -T prefix x kill-pane
```

#### My bindings

Prefixed with `C-q`
``` tangle:~/.tmux.conf
bind-key -T root C-q switch-client -T my-keys
bind-key -T my-keys r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"
bind-key -T my-keys e send-keys "nvim ~/.tmux.conf" Enter
bind-key -T my-keys Space last-window
bind-key -T my-keys t display-popup -E
bind-key -T my-keys f display-popup -E "tmuxs"
bind-key -T my-keys c display-popup -E "cht-sh"
bind-key -T my-keys l display-popup -E "cht-lang"
bind-key -T my-keys u display-popup -E "cht-util"
```

#### Preconfigured sessions

Prefixed with `C-w`
``` tangle:~/.tmux.conf
bind-key -T root C-w switch-client -T my-layouts
bind-key -T my-layouts d source-file ~/.tmux/dev-layout
```

## Layouts

Dev layout
``` tangle:~/.tmux/dev-layout
neww -c "#{pane_current_path}" -n dev nvim .
splitw -c "#{pane_current_path}" -t 0 -l 20
selectp -t 0
```

## Scripts

### TMUX session
> Author: [ThePrimeagen](https://github.com/ThePrimeagen)  
> Source: [tmux-sessionizer](https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer)

Use `tmuxs <directory> (optional)` to start new session.
``` tangle:~/bin/tmuxs
#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
```

If no directory is given we use fuzzy search (`fzf`) the following directories (`~/dev` and `~/dev/private`).
``` tangle:~/bin/tmuxs
else
    selected=$(find -L ~/dev ~/dev/private -mindepth 1 -maxdepth 1 -type d | fzf)
fi
```

If nothing gets selected, we exit the script
``` tangle:~/bin/tmuxs
if [[ -z $selected ]]; then
    exit 0
fi
```

Extract session name based on folder name.
``` tangle:~/bin/tmuxs
selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)
```

Starts a session if tmux is not running.
``` tangle:~/bin/tmuxs
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi
```

If session already exists we switch to it, if not we create it in detached mode, then switches to it.
``` tangle:~/bin/tmuxs
if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name
```
