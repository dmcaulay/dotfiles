export PATH=$(brew --prefix)/sbin:$(brew --prefix)/bin:$PATH:$HOME/bin
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/

ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export RBENV_ROOT="$HOME/.rbenv"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Change to the directory of the specified Go package name.
gg() {
	paths=($(g "$@"))
	path_index=1

	if [ ${#paths[@]} -gt 1 ]; then
		c=1
		for current in "${paths[@]}"; do
			echo "[${c}]: cd ${GOPATH}/${current}"
			c=$((c+1))
		done
		echo -n "Go to which path: "
		read path_index
	fi

	cd_path=${paths[$path_index]}
	cd $GOPATH/src/$cd_path
}

# Print the directories of the specified Go package name.
g() {
	local pkg_candidates="$((cd $GOPATH/src && find . -mindepth 1 -maxdepth 5 -type d \( -path "*/$1" -or -path "*/$1.git" \) -print) | sed 's/^\.\///g')"
	echo "$pkg_candidates"
}

# git
alias gfuckit='git reset --hard origin/master'
alias gstats='gitstats -c start_date=2.weeks .git gitstats'
alias gf='git diff --name-status'
alias ostats='open gitstats/index.html'
alias rmstats='rm -rf gitstats'

# vim
alias vn='ln -sf ~/my/dotfiles/vimrc-node ~/.vimrc && vim'
alias vr='ln -sf ~/my/dotfiles/vimrc-rails ~/.vimrc && vim'
alias vp='ln -sf ~/my/dotfiles/vimrc-django ~/.vimrc && vim'
alias va='ln -sf ~/my/dotfiles/vimrc-advisor ~/.vimrc && vim'
alias vg='ln -sf ~/my/dotfiles/vimrc-go ~/.vimrc && vim'

# node.js
alias nr='npm run'

# silver searcher
alias ag='\ag --pager="less -XFR"'

# md5sum
alias md5='md5 -r'
alias md5sum='md5 -r'

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
