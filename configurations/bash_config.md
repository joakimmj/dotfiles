---
created: 2018-11-11
tool: bash
tags: [shell]
---
<!-- SYNAPSES -->
- **down:** [bash_java](bash_java.md), [bash_worktrees](bash_worktrees.md)
***
<!-- /SYNAPSES -->

# Bashrc
Add header information
```bash tangle:~/.bashrc
# .bashrc
# AUTHOR: Joakim Myrvoll Johansen
# EMAIL:  joakim@myrvoll.dev
```

## Git sources
Add completion and git status to prompt. `.git-completion.bash` and
`.git-prompt.sh` are copied from `assets/` to the home directory.

<!-- TANGLE_CP:assets/.git-completion.bash tangle:~/.git-completion.bash -->
<!-- TANGLE_CP:assets/.git-prompt.sh tangle:~/.git-prompt.sh -->

```bash tangle:~/.bashrc
source ~/.git-completion.bash
source ~/.git-prompt.sh
```

## Environment variables
Add `~/bin/` to `$PATH`, and set `JDK_HOME`.

```bash tangle:~/.bashrc
export PATH="$PATH:~/bin/:~/.local/bin/"
```

Bind `<ctrl-u>`/`<ctrl-d>` to up/down in preview of `fzf`.
```bash tangle:~/.bashrc
export FZF_DEFAULT_OPTS='--bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'
```

## Source global definitions
```bash tangle:~/.bashrc
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
```

## Core
Everything below goes in `~/.bash_core`, loaded from `~/.bashrc`. `~/.bashrc`
keeps only the parts that depend on the system (completion files, `$PATH`,
`/etc` definitions), so `.bash_core` can be sourced as is from e.g. a
home-manager generated `.bashrc`.

```bash tangle:~/.bashrc
if [ -f ~/.bash_core ]; then
    . ~/.bash_core
fi
```

```bash tangle:~/.bash_core
# .bash_core: system agnostic shell setup, sourced from ~/.bashrc
```

### Pager and editor
Set `less` as the pager (also for `man` and `systemd`), and `vi` as the editor.

```bash tangle:~/.bash_core
export EDITOR=vi
export PAGER=less
export MANPAGER=less
export SYSTEMD_PAGER=less
export VISUAL=vi
```

### Time zone
```bash tangle:~/.bash_core
export TZ=Europe/Oslo
```

### History control
Ignore duplicates and spaces in the git history.

> A value of `ignoredups` causes lines which match the previous history entry 
> to not be saved.

> A value of `erasedups` causes all previous lines matching the current line 
> to be removed from the history list before that line is saved.

```bash tangle:~/.bash_core
HISTCONTROL=ignoreboth:erasedups
```

Append to the history file, don't overwrite it
```bash tangle:~/.bash_core
shopt -s histappend
```

### Exit
Require `<C-d>` at an empty prompt three times in a row to exit. Protects
against accidental exits, e.g. with homerow-mod ctrl keys where a single press
is too easy to hit.
```bash tangle:~/.bash_core
IGNOREEOF=3
```

## Prompt

The prompt lives in its own file, `.bash_ps1`, which is sourced from `.bash_core`
(and can be sourced from other shells, e.g. nix dev-shells).

Show git status in prompt.

Show changes
> - unstaged (`*`)
> - staged (`+`)
```bash tangle:~/.bash_ps1
GIT_PS1_SHOWDIRTYSTATE=true
```

Show untracked files
> - untracked files (`%`)
```bash tangle:~/.bash_ps1
GIT_PS1_SHOWUNTRACKEDFILES=true
```

Show upstream status
> - local branch behind (`<`)
> - local branch ahead (`>`)
> - diverged (`<>`)
> - same as upstream (`=`)
```bash tangle:~/.bash_ps1
GIT_PS1_SHOWUPSTREAM=auto
```

Add tags if:
* chrooting inside a sub system
* logged in as root
* logged into a SSH client
* running in virtual environment
* running in a nix development shell (`$DEV_SHELL`)

```bash tangle:~/.bash_ps1
function get_tags(){
  local tags=()

  if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
      tags=$(cat /etc/debian_chroot)
  fi
  if [ $(id -u) -eq 0 ]; then
    tags+=("root")
  fi
  if [ -n "$SSH_CLIENT" ]; then
    tags+=("ssh")
  fi
  if [[ -n "$VIRTUAL_ENV" ]]; then
    tags+=("${VIRTUAL_ENV##*/}")
  fi
  # Add dev shell tag if in a nix development shell
  if [[ -n "$DEV_SHELL" ]]; then
    tags+=("$DEV_SHELL")
  fi

  [[ -n "$tags" ]] && echo "${tags:+${tags[*]}-}"
}
```

Disable default virtual env prompt
```bash tangle:~/.bash_ps1
export VIRTUAL_ENV_DISABLE_PROMPT=1
```

Using colors from the Redox theme (24-but RGB)
```bash tangle:~/.bash_ps1
redox_teal="\e[38;2;126;193;174m"     # #7EC1AE
redox_rust="\e[38;2;205;139;100m"     # #CD8B64
redox_reset="\[\e[0m\]"
```

Prompt commands:
* `\d` : the date in "Weekday Month Date" format (e.g., "Tue May 26")
* `\D{format}` : the format is passed to strftime(3) and the result is inserted into the prompt string; an empty format results in a locale-specific time representation. The braces are required
* `\h` : the hostname up to the first '.'
* `\H` : the hostname
* `\j` : the number of jobs currently managed by the shell
* `\l` : the basename of the shell’s terminal device name
* `\n` : newline
* `\s` : the name of the shell, the basename of $0 (the portion following the final slash)
* `\t` : the current time in 24-hour HH:MM:SS format
* `\A` : the current time in 24-hour HH:MM format
* `\u` : the username of the current user
* `\w` : the current working directory, with $HOME abbreviated with a tilde
* `\W` : the basename of the current working directory, with $HOME abbreviated with a tilde
* `\$` : if the effective UID is 0, a #, otherwise a $

```bash tangle:~/.bash_ps1
PS1="\[$redox_rust\]╭─\$(get_tags)[\[$redox_teal\]\A\[$redox_rust\]]-[\[$redox_teal\]\j\[$redox_rust\]]-[\[$redox_teal\]\u:\W\$(__git_ps1)\[$redox_rust\]]\n\[$redox_rust\]╰──\$$redox_reset "
```

Load the prompt from `.bash_ps1`. It must be sourced before the `vi` mode
cursor below, which reuses `$redox_rust`.
```bash tangle:~/.bash_core
if [ -f ~/.bash_ps1 ]; then
    . ~/.bash_ps1
fi
```

Set `vi` mode
```bash tangle:~/.bash_core
set -o vi
```

Allow using `<C-l>` to clear screen in both modes.
```bash tangle:~/.bash_core
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
```

Change cursor between the two modes
```bash tangle:~/.bash_core
bind "set show-mode-in-prompt on"
bind "set vi-cmd-mode-string \"\1\e[2 q$redox_rust\2\""
bind "set vi-ins-mode-string \"\1\e[6 q$redox_rust\2\""
```

## Alias

Load aliases from `.bash_aliases`
```bash tangle:~/.bash_core
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
```

Load the [Java helpers](bash_java.md) (`.bash_java`, only present when `bash_java.md` is tangled)
and the [`wt` worktree helper](bash_worktrees.md) (`.worktree_aliases`)
```bash tangle:~/.bash_core
if [ -f ~/.bash_java ]; then
    . ~/.bash_java
fi

if [ -f ~/.worktree_aliases ]; then
    . ~/.worktree_aliases
fi
```

Set aliases for bash
```bash tangle:~/.bash_aliases
alias ..='cd ..'
alias ls='ls -p --color=auto'
alias l='ls -Fl --color=auto'
alias ll='ls -Fl --color=auto'
alias la='ls -AFl --color=auto'
alias lr='ls -AFlR --color=auto'
alias bcalc='bc -l -q'
alias bashrc='nano ~/.bashrc'
alias which='type -all'
```

Set aliases for git
```bash tangle:~/.bash_aliases
alias gs='git status -sb'
alias gd='git diff'
alias gds='git diff --staged'
alias git-prune-local-branches="git branch -vv | grep 'gone]' | awk '{print \$1}' | xargs git branch -D"
```

Create directory with parent directories and verbose output
```bash tangle:~/.bash_aliases
alias mkdir='mkdir -pv'
```

Search commands
```bash tangle:~/.bash_aliases
alias s-env='printenv | fzf'
alias s-path="echo $PATH | sed 's/:/\\n/g' | fzf"
```

Interactive commands with confirmation
```bash tangle:~/.bash_aliases
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ln='ln -i'
```

Aliases for docker

```bash tangle:~/.bash_aliases
alias docker-kill-all='docker kill $(docker ps -q)'
alias docker-clean='docker system prune -a'
alias docker-clean-volumes='docker volume rm $(docker volume ls -qf dangling=true)'
alias docker-clean-images='docker rmi $(docker images -q -f dangling=true)'
alias docker-clean-containers='docker rm $(docker ps -aqf status=exited)'
```

### Programs
Add keybindings to downloaded programs.

```bash tangle:~/.bash_aliases
alias gl="git log --oneline --pretty=format:'%h | %<(70,trunc)%s | %cd | %an' --date=format:'%d.%m.%y %H:%M' | fzf --multi --preview 'git show {+1} | fzf-preview' | awk '{print \$1}' | xargs git show"
alias manual="man -k . | fzf --preview 'man {+1}' | awk '{print \$1}' | xargs man"
alias kill-intellij="ps -ux | grep -E '[i]dea|[i]ntellij' | grep -v 'bash -ic' | awk '{print \$2}' | xargs --verbose -r kill -9"
alias tldrfzf="tldr --list | awk '{print \$1}' | fzf --preview 'tldr {+1}' | xargs tldr"
alias kill-process="ps -ux --no-headers | fzf --multi | awk '{print \$2}' | xargs --verbose -r kill -9"
```
Add alias for seraching files to open witj `nvim`
```bash tangle:~/.bash_aliases
alias nvimf="rg --hidden --files --ignore --glob '!.git' | fzf --preview 'fzf-preview {}' | xargs nvim"
```

Add alias for searching files and showing them in the terminal
```bash tangle:~/.bash_aliases
alias cats="fzf --preview 'fzf-preview {}'"
```

Add alias for opening `nvim` with last session
```bash tangle:~/.bash_aliases
alias nvimm='nvim -S .session.vim'
```

Aliases for non-plugin based `nvim`
```bash tangle:~/.bash_aliases
alias vim='NVIM_APPNAME=nvim-lite nvim'
alias vimm='NVIM_APPNAME=nvim-lite nvim -S .session.vim'
```
