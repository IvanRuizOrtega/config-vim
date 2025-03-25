
function parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

RED="\[\033[01;31m\]"
YELLOW="\[\033[01;33m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
NO_COLOR="\[\033[00m\]"
 # without host
PS1="$GREEN\u$NO_COLOR:$BLUE\w$YELLOW\$(parse_git_branch)$NO_COLOR\$ "
 # with host

# PS1="$GREEN\u@\h$NO_COLOR:$BLUE\w$YELLOW\$(parse_git_branch)$NO_COLOR\$ "
 #Alias to docker
alias dri="docker rmi"
alias dcu="docker compose up"
alias dcd="docker compose down"
alias dcbnc="docker compose build --no-cache"
alias dcb="docker compose build"
alias dce="docker compose exec"
alias ded="docker run --rm -it --entrypoint bash"
alias dedsh="docker run --rm -it --entrypoint sh"
alias di="docker images"
alias dp="docker ps"
alias dcr="docker compose restart"