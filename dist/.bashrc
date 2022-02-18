# .bashrc
# AUTHOR: Joakim Myrvoll Johansen
# EMAIL:  joakimmyrvoll@gmail.com
source ~/.git-completion.bash
source ~/.git-prompt.sh
export PATH="$PATH:~/bin/"
export JDK_HOME='/usr/lib/jvm/java-8-openjdk-amd64/'
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

PS1="${tags:+$green(${tags[*]})$reset }[\A\$(__git_ps1) \u:\W]\$ "
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
