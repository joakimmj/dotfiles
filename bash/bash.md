# Bashrc
Add header information
```bash tangle:~/.bashrc
# .bashrc
# AUTHOR: Joakim Myrvoll Johansen
# EMAIL:  joakimmyrvoll@gmail.com
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
export PATH="$PATH:~/bin/"
export JDK_HOME='/usr/lib/jvm/java-8-openjdk-amd64/'
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

## Pager
Set `less` as the system pager.

```bash tangle:~/.bashrc
export SYSTEMD_PAGER=less
```

## History control
Ignore duplicates and spaces in the git history.

> A value of `ignoredups` causes lines which match the previous history entry 
> to not be saved.

> A value of `erasedups` causes all previous lines matching the current line 
> to be removed from the history list before that line is saved.

```bash tangle:~/.bashrc
HISTCONTROL=ignoreboth:erasedups
```

Append to the history file, don't overwrite it
```bash tangle:~/.bashrc
shopt -s histappend
```

## Prompt

Show git status in prompt.

```bash tangle:~/.bashrc
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
```

Colors:
* `\[\e[0;34m\]` = BLUE
* `\[\e[0;32m\]` = GREEN
* `\[\e[0;33m\]` = YELLOW
* `\[\e[1;30m\]` = GREY
* `\[\e[0m\]`    = DEFAULT_COLOR

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

Set prompt dependent on if you're root or not. If `id -u` returns 0, you're root.
The color of the prompt is set to green if root.

```bash tangle:~/.bashrc
if [ $(id -u) -eq 0 ];
then 
  PS1="\[\e[0;32m\][\\A \u:\\W]\$ "
else
  PS1='[\A$(declare -F __git_ps1 &>/dev/null && __git_ps1 " (%s)") \u:\W]\$ '
fi
```

If logged into a SSH client, add `(ssh)` to prompt.

```bash tangle:~/.bashrc
if [ -n "$SSH_CLIENT" ];
then
  PS1='[\A (ssh)$(declare -F __git_ps1 &>/dev/null && __git_ps1 " (%s)") \u:\W]\$ '
fi
```

## Alias
Set aliases for bash

```bash tangle:~/.bashrc
alias ls='ls --color=auto'
alias l='ls -Fl --color=auto'
alias la='ls -AFl --color=auto'
alias lr='ls -AFlR --color=auto'
alias cp='cp -i'
alias mv='mv -i'
alias bcalc='bc -l -q'
alias bashrc='nano ~/.bashrc'
alias which='type -all'
#alias texpdf="latexmk -pdflatex='pdflatex -shell-escape -interaction nonstopmode' -pdf -f "
#alias texcc="latexmk -c "
```

Aliases for git

```bash tangle:~/.bashrc
alias gs='git status'
alias gl='git log'
alias gd='git diff'
```

### Programs
Add keybindings to downloaded programs.

```bash tangle:~/.bashrc

```

### Shortcuts
Add shortcuts for directories, ssh clients, etc.

```bash tangle:~/.bashrc
alias projects='cd ~/projects'
```
