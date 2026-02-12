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
GIT_PS1_SHOWUPSTREAM=auto
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

  [[ -n "$tags" ]] && echo "${tags:+${tags[*]}-}"
}
export VIRTUAL_ENV_DISABLE_PROMPT=1
redox_teal="\e[38;2;126;193;174m"     # #7EC1AE
redox_rust="\e[38;2;205;139;100m"     # #CD8B64
redox_reset="\[\e[0m\]"
PS1="\[$redox_rust\]╭─\$(get_tags)[\[$redox_teal\]\A\[$redox_rust\]]-[\[$redox_teal\]\j\[$redox_rust\]]-[\[$redox_teal\]\u:\W\$(__git_ps1)\[$redox_rust\]]\n╰──\$ $redox_reset"
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
bind "set show-mode-in-prompt on"
bind "set vi-cmd-mode-string \"\1\e[2 q$redox_rust\2\""
bind "set vi-ins-mode-string \"\1\e[6 q$redox_rust\2\""
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
