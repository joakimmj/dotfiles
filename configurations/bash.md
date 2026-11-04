# Bashrc
Add header information
```bash tangle:~/.bashrc
# .bashrc
# AUTHOR: Joakim Myrvoll Johansen
# EMAIL:  joakim@myrvoll.dev
```

## Git sources
Add completion and git status to prompt. Copy the files `.git-completion.bash`
and `.git-prompt.sh` to your home directory (`$HOME`/`~/`).

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

Load the Java helpers (`.bash_java`, only present when tangled with `-i java`)
and the `wt` worktree helper (`.worktree_aliases`)
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
alias kill-intellij="ps -ux | grep -E '[i]dea|[i]ntellij' | awk '{print \$2}' | xargs --verbose -r kill -9"
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

## Java

Helper functions for starting and testing maven projects. They live in their
own file, `.bash_java`, and are only tangled when the `java` tag is included:
```bash
md-tangle configurations/bash.md -i java
```

> If you need a custom trust store, add `-Djavax.net.ssl.trustStore=<path>` to
> the `java -jar` calls on the machine that needs it (not committed here).

Name of the current directory (the jar is named after the project folder).
```bash tangle:~/.bash_java tags:java
_current_dir() {
    local current_dir
    current_dir=${PWD##*/}        # to assign to a variable
    current_dir=${current_dir:-/} # to correct for the case where PWD is / (root)
    echo "${current_dir}"
}
```

Build and start the project. `jstart [profile]` runs with profile `local` (plus
the given profile), `jcleanstart` does a clean build first.
```bash tangle:~/.bash_java tags:java

jstart() {
    clear
    echo "mvn package -Dmaven.test.skip"
    mvn package -Dmaven.test.skip
    local profiles="local"
    if [ "$#" -eq 1 ]; then
        profiles+=",$1"
    fi
    local current_dir=$(_current_dir)
    echo "java -jar -Dspring.profiles.active=${profiles} target/${current_dir}.jar"
    java -jar -Dspring.profiles.active=${profiles} target/${current_dir}.jar
}

jcleanstart() {
    clear
    echo "mvn -U clean package -Dmaven.test.skip"
    mvn -U clean package -Dmaven.test.skip
    local profiles="local"
    if [ "$#" -eq 1 ]; then
        profiles+=",$1"
    fi
    local current_dir=$(_current_dir)
    echo "java -jar -Dspring.profiles.active=${profiles} target/${current_dir}.jar"
    java -jar -Dspring.profiles.active=${profiles} target/${current_dir}.jar
}
```

Run tests. `jtest [class [method]]`, `jitest` runs the integration tests.
```bash tangle:~/.bash_java tags:java

jtest() {
    clear
    local args
    if [ "$#" -eq 1 ]; then
        args="-Dtest=$1"
    elif [ "$#" -eq 2 ]; then
        args="-Dtest=$1#$2"
    fi
    echo "mvn -U clean test ${args}"
    mvn -U clean test ${args}
}

jitest() {
    clear
    echo "mvn -U clean verify -Pintegration-test"
    mvn -U clean verify -Pintegration-test
}
```

## Git worktrees

`wt` mirrors `git worktree` verb-for-verb (`wt add`, `wt list`, `wt remove`, ...)
with a few extras: auto path `<repo>/.worktrees/<branch>`, `cd` into the
worktree, an `fzf` picker, and upstream tracking. Sourced from `.bash_core`
because it has to change the directory of the parent shell.

```bash tangle:~/.worktree_aliases
# git worktree helper — regular-clone + <repo>/.worktrees/ model.
# Sourced from ~/.bash_core — defines the `wt` function set (must be sourced, not
# executed, so `wt cd`/`wt add` can change the parent shell's directory).
#
# `wt` mirrors `git worktree` verb-for-verb so daily use teaches the real CLI.
# Every mutating call echoes the underlying `+ git worktree ...` before running.
#
#   wt / wt cd [<branch>]        EXTRA (not a git verb): fzf-pick or jump → cd
#   wt add [-b] <branch> [base]  git worktree add ...   (auto-path, cd, track)
#   wt list                      git worktree list
#   wt remove <branch|path>      git worktree remove <path>
#   wt move <branch|path> <dst>  git worktree move <path> <dst>
#   wt prune                     git fetch --prune origin ; git worktree prune
#   wt repair [<path>...]        git worktree repair [<path>...]
#   wt help
#
# The extras layered on plain `git worktree`:
#   - auto path convention  <repo>/.worktrees/<branch>  (/ -> -)
#   - cd into the worktree  (git never changes your dir)
#   - fzf picker + git-log preview
#   - default-branch base resolution for `add -b` (origin/HEAD, self-healing)
#   - upstream auto-tracking for existing local branches
#   - /.worktrees/ kept out of the primary tree's `git status`

_wt_common_dir() {
  # absolute path of the shared .git dir, from anywhere inside the repo/worktree
  git rev-parse --path-format=absolute --git-common-dir 2>/dev/null
}

_wt_container() {
  # absolute dir holding .git (the regular clone root)
  local common
  common=$(_wt_common_dir) || return 1
  dirname "$common"
}

_wt_default_branch() {
  local ref
  ref=$(git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null)
  if [ -z "$ref" ]; then
    git remote set-head origin -a >/dev/null 2>&1
    ref=$(git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null)
  fi
  echo "${ref#origin/}"
}

_wt_ensure_exclude() {
  # keep nested worktrees out of the primary tree's status (per-clone, uncommitted)
  local common
  common=$(_wt_common_dir) || return 0
  mkdir -p "$common/info"
  grep -qxF '/.worktrees/' "$common/info/exclude" 2>/dev/null \
    || echo '/.worktrees/' >> "$common/info/exclude"
}

_wt_paths() {
  # print worktree paths (primary + .worktrees/*)
  git worktree list --porcelain | awk '
    /^worktree /{p=$2}
    /^bare/{p=""}
    /^$/{if(p)print p; p=""}
    END{if(p)print p}'
}

_wt_track() {
  # set upstream to origin/<branch> when the remote branch exists and none is set
  local dir=$1 branch=$2
  git -C "$dir" rev-parse --abbrev-ref "$branch@{upstream}" >/dev/null 2>&1 && return 0
  git -C "$dir" show-ref --verify --quiet "refs/remotes/origin/$branch" || return 0
  git -C "$dir" branch --set-upstream-to="origin/$branch" "$branch" >/dev/null 2>&1
}

_wt_dest() {
  # echo destination worktree path for a branch name (/ -> -), under .worktrees/
  local branch=$1 container safe
  container=$(_wt_container) || { echo "wt: not in a git repo" >&2; return 1; }
  safe=${branch//\//-}
  echo "$container/.worktrees/$safe"
}

_wt_find() {
  # print path of the worktree whose checked-out branch == $1 (slash-safe), else empty
  git worktree list --porcelain | awk -v b="refs/heads/$1" '
    /^worktree /{p=$2}
    /^branch /{if($2==b) print p}'
}

_wt_pick() {
  # fzf-pick an existing worktree path (optional prompt arg)
  _wt_paths | fzf --prompt "${1:-worktree> }" \
    --preview 'git -C {} log --oneline -15 --color=always 2>/dev/null || fzf-preview {}'
}

_wt_run() {
  # echo the git invocation (learning aid), then run it
  printf '+ git %s\n' "$*" >&2
  git "$@"
}

_wt_resolve() {
  # branch name or path -> worktree path
  local arg=$1 found dest
  [ -z "$arg" ] && return 1
  found=$(_wt_find "$arg")
  if [ -n "$found" ]; then echo "$found"; return 0; fi
  dest=$(_wt_dest "$arg" 2>/dev/null)
  if [ -n "$dest" ] && [ -e "$dest" ]; then echo "$dest"; return 0; fi
  echo "$arg"   # fall back: treat as a literal path
}

_wt_add() {
  # git worktree add — with auto-path, base resolution, tracking, and cd.
  #   wt add <branch>            existing local branch  -> add + set upstream
  #                              remote-only branch     -> add --track -b
  #   wt add -b <branch> [base]  new branch (strict); base defaults to origin
  #                              default branch (-H|--head -> HEAD)
  local create=0 from_head=0 branch="" base=""
  while [ $# -gt 0 ]; do
    case "$1" in
      -b) create=1 ;;
      -H|--head) from_head=1 ;;
      -*) echo "wt add: unknown flag $1" >&2; return 1 ;;
      *) if [ -z "$branch" ]; then branch=$1; else base=$1; fi ;;
    esac
    shift
  done

  [ -z "$branch" ] && { echo "usage: wt add [-b] <branch> [base] [-H|--head]" >&2; return 1; }

  local dest; dest=$(_wt_dest "$branch") || return 1
  [ -e "$dest" ] && { echo "wt: $dest already exists (use 'wt cd $branch')" >&2; return 1; }
  _wt_ensure_exclude

  if [ "$create" -eq 1 ]; then
    if git show-ref --verify --quiet "refs/heads/$branch"; then
      echo "wt: branch '$branch' already exists; omit -b" >&2; return 1
    fi
    if [ -z "$base" ]; then
      if [ "$from_head" -eq 1 ]; then
        base=HEAD
      else
        printf '+ git fetch origin\n' >&2
        git fetch origin >/dev/null 2>&1
        base="origin/$(_wt_default_branch)"
      fi
    fi
    _wt_run worktree add --no-track -b "$branch" "$dest" "$base" || return 1
  else
    if git show-ref --verify --quiet "refs/heads/$branch"; then
      _wt_run worktree add "$dest" "$branch" || return 1
      _wt_track "$dest" "$branch"
    elif git show-ref --verify --quiet "refs/remotes/origin/$branch"; then
      _wt_run worktree add --track -b "$branch" "$dest" "origin/$branch" || return 1
    else
      echo "wt: no branch '$branch' (local or remote); use -b to create" >&2
      return 1
    fi
  fi
  cd "$dest" || return
}

_wt_cd() {
  # EXTRA (no git equivalent): navigate to a worktree. Never creates.
  local branch=${1:-} found sel
  if [ -z "$branch" ]; then
    sel=$(_wt_pick) || return
    [ -n "$sel" ] && cd "$sel"
    return
  fi
  found=$(_wt_find "$branch")
  if [ -n "$found" ]; then
    cd "$found" || return
  else
    echo "wt: no worktree for '$branch'; use 'wt add $branch'" >&2
    return 1
  fi
}

_wt_remove() {
  local arg=${1:-} dest
  if [ -z "$arg" ]; then
    dest=$(_wt_pick 'remove> ') || return
    [ -z "$dest" ] && return
  else
    dest=$(_wt_resolve "$arg")
  fi
  _wt_run worktree remove "$dest" || return 1
  echo "removed worktree: $dest"
}

_wt_move() {
  local src=${1:-} dst=${2:-}
  { [ -z "$src" ] || [ -z "$dst" ]; } && { echo "usage: wt move <branch|path> <new-path>" >&2; return 1; }
  src=$(_wt_resolve "$src")
  _wt_run worktree move "$src" "$dst"
}

_wt_prune() {
  printf '+ git fetch --prune origin\n' >&2
  git fetch --prune origin >/dev/null 2>&1
  _wt_run worktree prune -v
}

_wt_repair() {
  _wt_run worktree repair "$@"
}

_wt_help() {
  cat <<'EOF'
wt — git worktree helper (mirrors `git worktree`; extras noted)
  wt [cd [<branch>]]          EXTRA: fzf-pick a worktree, or jump to <branch> → cd
  wt add <branch>             git worktree add: check out existing branch (local or
                              remote) into .worktrees/<branch>, then cd in
  wt add -b <branch> [base]   git worktree add -b: new branch off [base] (default
                              origin default branch; -H|--head → HEAD)
  wt list                     git worktree list
  wt remove <branch|path>     git worktree remove (branch name resolved to path;
                              no arg → fzf-pick). Does not delete the branch.
  wt move <branch|path> <dst> git worktree move (relocate + fix bookkeeping)
  wt prune                    git fetch --prune origin  +  git worktree prune
  wt repair [<path>...]       git worktree repair (fix admin links after a move)
EOF
}

wt() {
  local cmd=${1:-}
  [ $# -gt 0 ] && shift
  case "$cmd" in
    ""|cd)   _wt_cd "$@" ;;
    add)     _wt_add "$@" ;;
    list)    _wt_run worktree list ;;
    remove)  _wt_remove "$@" ;;
    move)    _wt_move "$@" ;;
    prune)   _wt_prune "$@" ;;
    repair)  _wt_repair "$@" ;;
    -h|--help|help) _wt_help ;;
    *) echo "wt: unknown subcommand '$cmd'" >&2; _wt_help; return 1 ;;
  esac
}
```
