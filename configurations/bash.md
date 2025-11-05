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

Add tags if:
* chrooting inside a sub system
* logged in as root
* logged into a SSH client

```bash tangle:~/.bashrc
unset tags;
tags=()

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    tags=$(cat /etc/debian_chroot)
fi
if [ $(id -u) -eq 0 ]; then
  tags+=("root")
fi
if [ -n "$SSH_CLIENT" ]; then
  tags+=("ssh")
fi
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

```bash tangle:~/.bashrc
green="\[\033[01;32m\]"
reset="\[\033[00m\]"

PS1="${tags:+$green(${tags[*]})$reset }[\A$green\$(__git_ps1)$reset \u:\W]\$ "
```

Set `vi` mode
```bash tangle:~/.bashrc
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
```

## Alias

Load aliases from `.bash_aliases`
```bash tangle:~/.bashrc
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
```

Set aliases for bash
```bash tangle:~/.bash_aliases
alias ..='cd ..'
alias -='cd -'
alias ls='ls --color=auto'
alias l='ls -Fl --color=auto'
alias ll='ls -Fl --color=auto'
alias la='ls -AFl --color=auto'
alias lr='ls -AFlR --color=auto'
alias bcalc='bc -l -q'
alias bashrc='nano ~/.bashrc'
alias which='type -all'
alias cats="fzf --preview 'fzf-preview {}'"
```

Set aliases for git
```bash tangle:~/.bash_aliases
alias gs='git status -sb'
alias gd='git diff'
alias gds='git diff --staged'
alias git-prune-local-branches="git branch -vv | grep 'gone]' | awk '{print $1}' | xargs git branch -D"
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
alias kill-intellij="ps -ux | grep '[i]ntellij' | awk '{print \$2}' | xargs --verbose -r kill -9"
alias tldrfzf="tldr --list | awk '{print \$1}' | fzf --preview 'tldr {+1}' | xargs tldr"
alias kill-process="ps -ux --no-headers | fzf --multi | awk '{print \$2}' | xargs --verbose -r kill -9"
```
Add alias for seraching files to open witj `nvim`
```bash tangle:~/.bash_aliases
alias nvimf="rg --hidden --files --ignore --glob '!.git' | fzf --preview 'fzf-preview {}' | xargs nvim"
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

Add aliases for starting and testing maven projects
```bash tangle:~/.bash_aliases
current-dir() {
    local current_dir
    current_dir=${PWD##*/}        # to assign to a variable
    current_dir=${current_dir:-/} # to correct for the case where PWD is / (root)
    echo "${current_dir}"
}

jstart() {
    clear
    echo "mvn package -Dmaven.test.skip"
    mvn package -Dmaven.test.skip
    local profiles="local"
    if [ "$#" -eq 1 ]; then
        profiles+=",$1"
    fi
    local current_dir=$(current-dir)
    echo "java -jar -Dspring.profiles.active=${profiles} -Djavax.net.ssl.trustStore=/home/zero_ir/store/stb-test-cacerts-with-cwp.keystore target/${current_dir}.jar"
    java -jar -Dspring.profiles.active=${profiles} -Djavax.net.ssl.trustStore=/home/zero_ir/store/stb-test-cacerts-with-cwp.keystore target/${current_dir}.jar
}

jcleanstart() {
    clear
    echo "mvn -U clean package -Dmaven.test.skip"
    mvn -U clean package -Dmaven.test.skip
    local profiles="local"
    if [ "$#" -eq 1 ]; then
        profiles+=",$1"
    fi
    local current_dir=$(current-dir)
    echo "java -jar -Dspring.profiles.active=${profiles} -Djavax.net.ssl.trustStore=/home/zero_ir/store/stb-test-cacerts-with-cwp.keystore target/${current_dir}.jar"
    java -jar -Dspring.profiles.active=${profiles} -Djavax.net.ssl.trustStore=/home/zero_ir/store/stb-test-cacerts-with-cwp.keystore target/${current_dir}.jar
}

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

### Shortcuts
Add shortcuts for directories, ssh clients, etc.

```bash tangle:~/.bash_aliases
alias projects='cd ~/projects'
```
