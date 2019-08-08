export PATH=$(brew --prefix)/sbin:$(brew --prefix)/bin:$PATH:$HOME/bin

ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export RBENV_ROOT="$HOME/.rbenv"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Change to the directory of the specified Go package name.
gg() {
	paths=($(g "$@"))
	path_index=0

	if [ ${#paths[@]} -gt 1 ]; then
		c=1
		for path in "${paths[@]}"; do
			echo [$c]: cd ${GOPATH}/${path}
			c=$((c+1))
		done
		echo -n "Go to which path: "
		read path_index

		path_index=$(($path_index-1))
	fi

	path=${paths[$path_index]}
	cd $GOPATH/src/$path
}

# Print the directories of the specified Go package name.
g() {
	local pkg_candidates="$((cd $GOPATH/src && find . -mindepth 1 -maxdepth 5 -type d \( -path "*/$1" -or -path "*/$1.git" \) -print) | sed 's/^\.\///g')"
	echo "$pkg_candidates"
}

# prompt
set_bash_prompt() {
  PS1="\[\033[01;32m\]\u@\h $(prompt_current_dir) \e[31m$(parse_git_branch)
\[\033[00m\]$ "
}
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
function prompt_current_dir {
  w=$PWD
  pre=""
  pre_color="\e[35m"
  w_color="\[\033[01;36m\]"

  if [[ $w == "$GOPATH/src/"* ]]; then
    w="${w#$GOPATH/src/}"
    pre="go/"
  else
    if [[ $w == $HOME* ]]; then
      w="${w#$HOME}"
      pre="~"
    fi
  fi
  echo $pre_color$pre$w_color$w
}
PROMPT_COMMAND=set_bash_prompt

# git
alias gst='git status'
alias gd='git diff'
alias gp='git push dmcaulay'
alias gpo='git push origin'
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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
