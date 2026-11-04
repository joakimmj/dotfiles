alias ..='cd ..'
alias ls='ls -p --color=auto'
alias l='ls -Fl --color=auto'
alias ll='ls -Fl --color=auto'
alias la='ls -AFl --color=auto'
alias lr='ls -AFlR --color=auto'
alias bcalc='bc -l -q'
alias bashrc='nano ~/.bashrc'
alias which='type -all'
alias gs='git status -sb'
alias gd='git diff'
alias gds='git diff --staged'
alias git-prune-local-branches="git branch -vv | grep 'gone]' | awk '{print \$1}' | xargs git branch -D"
alias mkdir='mkdir -pv'
alias s-env='printenv | fzf'
alias s-path="echo $PATH | sed 's/:/\\n/g' | fzf"
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ln='ln -i'
alias docker-kill-all='docker kill $(docker ps -q)'
alias docker-clean='docker system prune -a'
alias docker-clean-volumes='docker volume rm $(docker volume ls -qf dangling=true)'
alias docker-clean-images='docker rmi $(docker images -q -f dangling=true)'
alias docker-clean-containers='docker rm $(docker ps -aqf status=exited)'
alias gl="git log --oneline --pretty=format:'%h | %<(70,trunc)%s | %cd | %an' --date=format:'%d.%m.%y %H:%M' | fzf --multi --preview 'git show {+1} | fzf-preview' | awk '{print \$1}' | xargs git show"
alias manual="man -k . | fzf --preview 'man {+1}' | awk '{print \$1}' | xargs man"
alias kill-intellij="ps -ux | grep -E '[i]dea|[i]ntellij' | awk '{print \$2}' | xargs --verbose -r kill -9"
alias tldrfzf="tldr --list | awk '{print \$1}' | fzf --preview 'tldr {+1}' | xargs tldr"
alias kill-process="ps -ux --no-headers | fzf --multi | awk '{print \$2}' | xargs --verbose -r kill -9"
alias nvimf="rg --hidden --files --ignore --glob '!.git' | fzf --preview 'fzf-preview {}' | xargs nvim"
alias cats="fzf --preview 'fzf-preview {}'"
alias nvimm='nvim -S .session.vim'
alias vim='NVIM_APPNAME=nvim-lite nvim'
alias vimm='NVIM_APPNAME=nvim-lite nvim -S .session.vim'
