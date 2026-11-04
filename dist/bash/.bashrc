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
export EDITOR=vi
export PAGER=less
export MANPAGER=less
export SYSTEMD_PAGER=less
export VISUAL=vi
export TZ=Europe/Oslo
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
IGNOREEOF=3
if [ -f ~/.bash_ps1 ]; then
    . ~/.bash_ps1
fi
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
bind "set show-mode-in-prompt on"
bind "set vi-cmd-mode-string \"\1\e[2 q$redox_rust\2\""
bind "set vi-ins-mode-string \"\1\e[6 q$redox_rust\2\""
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if [ -f ~/.bash_java ]; then
    . ~/.bash_java
fi

if [ -f ~/.worktree_aliases ]; then
    . ~/.worktree_aliases
fi
