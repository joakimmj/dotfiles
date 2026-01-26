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

Add git branch to left status (default length: 10)
``` tangle:~/.tmux.conf
set -g status-left "[#S] #(cd #{pane_current_path}; git rev-parse --abbrev-ref HEAD)"
set -g status-left-length 80
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

Change default pane info and format time for right status
``` tangle:~/.tmux.conf
set -g status-right "[#{=21:pane_index}:#{=21:pane_current_command}] %d.%m.%y, %H:%M"
```

Adjust right status length (default 40)
``` tangle:~/.tmux.conf
set -g status-right-length 40
```

Set update interval (default: 15 sec)
``` tangle:~/.tmux.conf
set-option -g status-interval 10
```

### Key tables

#### Change defaults

Keep current path when creating new windows/panes
``` tangle:~/.tmux.conf
bind-key -T prefix -N "Split window vertically" '"' split-window -v -c '#{pane_current_path}'
bind-key -T prefix -N "Split window horizontally" '%' split-window -h -c '#{pane_current_path}'
bind-key -T prefix -N "Create new window" c new-window -c '#{pane_current_path}'
```

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
bind-key -T my-keys -N "Popup search and create session" s display-popup -E "tmuxs"
bind-key -T my-keys -N "Popup search and create window" w display-popup -E "dev"
bind-key -T my-keys -N "Jump to directory" j send-keys "cd $(find -L ~/dev ~/projects ~/.config -mindepth 1 -maxdepth 1 -type d | fzf)" Enter
bind-key -T my-keys -N "Search up" / copy-mode \; send-key "?"
```

Popup scratchpad.
``` tangle:~/.tmux.conf
bind-key -T my-keys -N "Popup scratchpad" p if-shell -F '#{==:#{session_name},scratchpad}' {
    detach-client
} {
    display-popup -w 80% -h 80% -E "tmux new-session -A -s scratchpad -n home -c ~/"
}
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
```sh tangle:~/bin/tmuxs
#!/usr/bin/env bash
```

Directories to search (`~/dev` and `~/dev/private`)
```sh tangle:~/bin/tmuxs
dirs="~/dev ~/dev/private"
```

If no directory is given we use fuzzy search (`fzf`) the directories defined above.
```sh tangle:~/bin/tmuxs
if [[ $# -eq 1 ]]; then
    path=$1
else
    path=$(eval "find -L $dirs -mindepth 1 -maxdepth 1 -type d | fzf")
fi
```

If nothing gets selected, we exit the script
```sh tangle:~/bin/tmuxs
if [[ -z $path ]]; then
    exit 0
fi
```

Extract session name based on directory name.
```sh tangle:~/bin/tmuxs
selected_dir=$(basename "$path" | tr . _)
```

Create session if it does not exist
```sh tangle:~/bin/tmuxs
if ! tmux has-session -t $selected_dir 2> /dev/null; then
    tmux new-session -d -x - -y - -s $selected_dir -c $path
fi
```

If running outside of `tmux` attach the new session, if not switch to it
```sh tangle:~/bin/tmuxs
if [[ -z $TMUX ]]; then
    tmux attach-session -d -t $selected_dir
else
    tmux switch-client -t $selected_dir
fi
```

### Save/restore session

Save/restore all windows and sessions.

```sh tangle:~/bin/tmux-session
#!/usr/bin/env bash

set -e

if [ -n "$2" ]; then
  session_file=$2
else
  session_file=~/.tmux-session
fi

restore_session() {
  tmux start-server

  while IFS=$',' read session_name window_name dir; do
    echo "$session_name,$window_name,$dir"
    if [[ -d "$dir" ]]; then
      if ! tmux has-session -t "$session_name" 2>/dev/null; then
        tmux new-session -d -x - -y - -s "$session_name" -n "$window_name" -c "$dir"
      fi
      if ! tmux has-session -t "$session_name:$window_name" 2>/dev/null; then
        tmux new-window -d -t "$sessione_name" -n "$window_name" -c "$dir"
      fi
    fi
  done < "$session_file"

  if [[ -z $TMUX ]]; then
    tmux attach
  fi
}

case "$1" in
save)
  echo "-- Saving:"
  tmux list-windows -a -F "#S,#W,#{pane_current_path}" > "$session_file"
  cat "$session_file"
  exit 0
  ;;
restore)
  echo "-- Restoring"
  restore_session
  exit 0
  ;;
*)
  echo "Valid commands: save, restore"
  exit 1
  ;;
esac
```

### My dev script
> Strongly influenced by [tmux-sessionizer](https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer)

Use `dev <directory> (optional)` to start new session.
```sh tangle:~/bin/dev
#!/usr/bin/env bash
```

Directories to search (`~/dev` and `~/dev/private`)
```sh tangle:~/bin/dev
dirs="~/dev ~/dev/private"
```

If no directory is given we use fuzzy search (`fzf`) the directories defined above.
```sh tangle:~/bin/dev
if [[ $# -eq 1 ]]; then
    path=$1
else
    path=$(eval "find -L $dirs -mindepth 1 -maxdepth 1 -type d | fzf")
fi
```

If nothing gets selected, we exit the script
```sh tangle:~/bin/dev
if [[ -z $path ]]; then
    exit 0
fi
```

Extract window name based on folder name.
```sh tangle:~/bin/dev
selected_dir=$(basename "$path" | tr . _)
```

Create `dev` session with default `home` window if it does not exist
```sh tangle:~/bin/dev
if ! tmux has-session -t dev 2> /dev/null; then
    tmux new-session -d -x - -y - -s dev -n home -c ~/
fi
if ! tmux has-session -t dev:home 2> /dev/null; then
    tmux new-window -d -t dev -n home -c ~/
fi
```

Create window for selected directory if it does not exist
```sh tangle:~/bin/dev
if ! tmux has-session -t dev:$selected_dir 2> /dev/null; then
    tmux new-window -t dev -n $selected_dir -c $path
fi
```

If running outside of `tmux` attach the new session, if not switch to it
```sh tangle:~/bin/dev
if [[ -z $TMUX ]]; then
    tmux attach-session -d -t dev:$selected_dir
else
    tmux switch-client -t dev:$selected_dir
fi
```

