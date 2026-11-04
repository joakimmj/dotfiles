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
if [ -f ~/.bash_core ]; then
    . ~/.bash_core
fi
