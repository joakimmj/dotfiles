# TMUX

## Configuration

### Options

Enable mouse usage
``` tangle:~/.tmux.conf
set -g mouse on
```

Zero-out escape time delay
``` tangle:~/.tmux.conf
set -g escape-time 0
```

Increase history size (from 2,000)
``` tangle:~/.tmux.conf
set -g history-limit 1000000
```

Use system clipboard
``` tangle:~/.tmux.conf
set -g set-clipboard on
```

Change the default $TERM to tmux-256color
``` tangle:~/.tmux.conf
set-option -g default-terminal 'screen-254color'
set-option -g terminal-overrides ',xterm-256color:RGB'
set -g default-terminal "${TERM}"
```

No bells
``` tangle:~/.tmux.conf
set -g bell-action none
```

Attach to next session if one session is closed
``` tangle:~/.tmux.conf
set -g detach-on-destroy off
```

Use `vi` mode
``` tangle:~/.tmux.conf
set -g mode-keys vi
```

### Status line

Move status line to top
``` tangle:~/.tmux.conf
set -g status-position top
```

Style status line
``` tangle:~/.tmux.conf
set -g window-status-current-style bg="#2E3434",fg="#A6E3A1"
set -g status-bg "#A6E3A1"
set -g status-fg "#2E3434"
set -g window-status-style "underscore"
```

Allow longer session names
``` tangle:~/.tmux.conf
set -g status-left-length 30
```

Align windows to center
``` tangle:~/.tmux.conf
set -g status-justify centre
```

Start window index on 1
``` tangle:~/.tmux.conf
set -g base-index 1
```

Re-number all windows when any window is closed
``` tangle:~/.tmux.conf
set -g renumber-windows on
```

Format right status
``` tangle:~/.tmux.conf
set -g status-right "%d.%m.%y, %H:%M"
```

### Key tables

#### Change defaults

Remove confirmation before killing window (default: `confirm-before -p "kill-window #W? (y/n)" kill-window`).
``` tangle:~/.tmux.conf
#bind-key -T prefix -N "Kill the current window" & kill-window
```

Remove confirmation before killing pane (default: `confirm-before -p "kill-pane #P? (y/n)" kill-pane`).
``` tangle:~/.tmux.conf
#bind-key -T prefix -N "Kill the current pane" x kill-pane
```

Show keybindings in popup (default: `list-keys -N`).
``` tangle:~/.tmux.conf
bind-key -T prefix -N "List all key bindings" ? display-popup -E "(echo 'My keys'; tmux list-keys -N -T my-keys -P 'C-a '; printf '\nCheatsheets\n'; tmux list-keys -N -T cheatsheets -P 'C-a c '; printf '\nLayouts\n'; tmux list-keys -N -T my-layouts -P 'C-a l '; printf '\nBuilt in\n'; tmux list-keys -N) | less"
```

Vim-like pane switching. The only default this changes is for selecting previously current window (`C-b l`).
``` tangle:~/.tmux.conf
bind-key -T prefix -r -N "Select the previously current window" ^ last-window
bind-key -T prefix -r -N "Select the pane above the active pane" k select-pane -U
bind-key -T prefix -r -N "Select the pane below the active pane" j select-pane -D
bind-key -T prefix -r -N "Select the pane to the right of the active pane" h select-pane -L
bind-key -T prefix -r -N "Select the pane to the left of the active pane" l select-pane -R
```

#### My bindings

Prefixed with `C-a`
``` tangle:~/.tmux.conf
bind-key -T root C-a switch-client -T my-keys
bind-key -T my-keys -N "Reload config" r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"
bind-key -T my-keys -N "Edit config" e send-keys "nvim ~/.tmux.conf" Enter
bind-key -T my-keys -N "Jump to last window" Space last-window
bind-key -T my-keys -N "Popup terminal" t display-popup -E
bind-key -T my-keys -N "Popup search and create" f display-popup -E "tmuxs"
bind-key -T my-keys -N "Jump to directory" j send-keys "cd $(find -L ~/dev ~/projects ~/.config -mindepth 1 -maxdepth 1 -type d | fzf)" Enter
```

##### Cheatsheet

Prefixed with `C-a c`
``` tangle:~/.tmux.conf
bind-key -T my-keys c switch-client -T cheatsheets
bind-key -T cheatsheets -N "Cheatsheet" c display-popup -E "cht-sh"
bind-key -T cheatsheets -N "Cheatsheet (programming languages)" l display-popup -E "cht-lang"
bind-key -T cheatsheets -N "Cheatsheet (utils)" u display-popup -E "cht-util"
bind-key -T cheatsheets -N "Cheatsheet for vim motions" v display-popup -E "less ~/.tmux/vim-motions.md"
```

##### Preconfigured layouts

Prefixed with `C-a l`
``` tangle:~/.tmux.conf
bind-key -T my-keys l switch-client -T my-layouts
bind-key -T my-layouts -N "Development layout" d source-file ~/.tmux/dev-layout
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
if [[ -z $TMUX ]] || [[ -z $tmux_running ]]; then
    tmux new-session -As $selected_name -c $selected
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
