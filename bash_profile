
ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export RBENV_ROOT="$HOME/.rbenv"
export GOPATH=$HOME/go
export CGO_LDFLAGS="-L${HOMEBREW_ROOT}/Cellar/leptonica/1.71_1/lib -L${HOMEBREW_ROOT}/Cellar/tesseract/3.02.02_3/lib"
export CGO_CFLAGS="-I${HOMEBREW_ROOT}/Cellar/leptonica/1.71_1/include -I${HOMEBREW_ROOT}/Cellar/tesseract/3.02.02_3/include"
export PATH=$PATH:$GOPATH/bin

# prompt
PS1="\[\033[01;32m\]\u@\h\[\033[01;36m\] \w \e[31m\$(parse_git_branch)
\[\033[00m\]$ "
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

# git
alias gst='git status'
alias gd='git diff'
alias gp='git push dmcaulay'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gco='git checkout'
alias gcm='git checkout master'
alias gr='git remote'
alias grv='git remote -v'
alias gb='git branch'
alias glg='git log --stat --max-count=10'
alias ga='git add'
alias gap='git add -p'
alias gm='git merge'
alias grh='git reset HEAD'

# vim
alias vn='ln -sf ~/my/dotfiles/vimrc-node ~/.vimrc && vim'
alias vr='ln -sf ~/my/dotfiles/vimrc-rails ~/.vimrc && vim'
alias vp='ln -sf ~/my/dotfiles/vimrc-django ~/.vimrc && vim'
alias va='ln -sf ~/my/dotfiles/vimrc-advisor ~/.vimrc && vim'

# node.js
alias nr='npm run'

source /opt/boxen/env.sh

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
