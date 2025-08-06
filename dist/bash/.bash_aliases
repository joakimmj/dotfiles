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
alias gs='git status -sb'
alias gd='git diff'
alias gds='git diff --staged'
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
alias gl="git log --oneline --pretty=format:'%h | %<(70,trunc)%s | %cd | %an' --date=format:'%d.%m.%y %H:%M' | fzf --multi --preview 'git show {+1}' | awk '{print \$1}' | xargs git show"
alias manual="man -k . | fzf --preview 'man {+1}' | awk '{print \$1}' | xargs man"
alias kill-intellij="ps -ux | grep '[i]ntellij' | awk '{print \$2}' | xargs --verbose -r kill -9"
alias tldrfzf="tldr --list | sed 's/,/\\n/g' | fzf --preview 'tldr {+1}' | xargs tldr -t ocean"
alias nvimf="rg --hidden --files --ignore --glob '!.git' | fzf --preview 'cat {+1}' | xargs nvim"
alias nvimm='nvim -S .session.vim'
alias vim='NVIM_APPNAME=nvim-lite nvim'
alias vimm='NVIM_APPNAME=nvim-lite nvim -S .session.vim'
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
    local current_dir=$(current-dir)
    echo "java -jar -Dspring.profiles.active=local -Djavax.net.ssl.trustStore=/home/zero_ir/store/stb-test-cacerts-with-cwp.keystore target/${current_dir}.jar"
    java -jar -Dspring.profiles.active=local -Djavax.net.ssl.trustStore=/home/zero_ir/store/stb-test-cacerts-with-cwp.keystore target/${current_dir}.jar
}

jcleanstart() {
    clear
    echo "mvn -U clean package -Dmaven.test.skip"
    mvn -U clean package -Dmaven.test.skip
    local current_dir=$(current-dir)
    echo "java -jar -Dspring.profiles.active=local -Djavax.net.ssl.trustStore=/home/zero_ir/store/stb-test-cacerts-with-cwp.keystore target/${current_dir}.jar"
    java -jar -Dspring.profiles.active=local -Djavax.net.ssl.trustStore=/home/zero_ir/store/stb-test-cacerts-with-cwp.keystore target/${current_dir}.jar
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
alias projects='cd ~/projects'
