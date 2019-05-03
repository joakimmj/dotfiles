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
if [ $(id -u) -eq 0 ];
then 
  PS1="\[\e[0;32m\][\\A \u:\\W]\$ "
else
  PS1='[\A$(declare -F __git_ps1 &>/dev/null && __git_ps1 " (%s)") \u:\W]\$ '
fi
if [ -n "$SSH_CLIENT" ];
then
  PS1='[\A (ssh)$(declare -F __git_ps1 &>/dev/null && __git_ps1 " (%s)") \u:\W]\$ '
fi
alias ls='ls --color=auto'
alias l='ls -Fl --color=auto'
alias ll='ls -Fl --color=auto'
alias la='ls -AFl --color=auto'
alias lr='ls -AFlR --color=auto'
alias cp='cp -i'
alias mv='mv -i'
alias bcalc='bc -l -q'
alias bashrc='nano ~/.bashrc'
alias which='type -all'
#alias texpdf="latexmk -pdflatex='pdflatex -shell-escape -interaction nonstopmode' -pdf -f "
#alias texcc="latexmk -c "
alias gs='git status -sb'
alias docker-kill-all='docker kill $(docker ps -q)'
alias docker-clean='docker system prune -a'
alias docker-clean-volumes='docker volume rm $(docker volume ls -qf dangling=true)'
alias docker-clean-images='docker rmi $(docker images -q -f dangling=true)'
alias docker-clean-containers='docker rm $(docker ps -aqf status=exited)'

alias projects='cd ~/projects'

# default: 810
alias brightness='sudo nano /sys/class/backlight/intel_backlight/brightness'
