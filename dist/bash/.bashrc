# .bashrc
# AUTHOR: Joakim Myrvoll Johansen
# EMAIL:  joakim@myrvoll.dev
source ~/.git-completion.bash
source ~/.git-prompt.sh
export PATH="$PATH:~/bin/:~/.local/bin/"
export FZF_DEFAULT_OPTS='--bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
export SYSTEMD_PAGER=less
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
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
green="\[\033[01;32m\]"
reset="\[\033[00m\]"

PS1="${tags:+$green(${tags[*]})$reset }[\A$green\$(__git_ps1)$reset \u:\W]\$ "
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
