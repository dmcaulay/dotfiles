export ZSH="/Users/danmcaulay/.oh-my-zsh"

ZSH_THEME="dmcaulay"

plugins=()

source $ZSH/oh-my-zsh.sh

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export GOPATH=$HOME/go
export KNOWN_GOHOSTS=github.com
export PATH="$PATH:${GOPATH//://bin:}/bin"

# Print the directories of the specified Go package name.
g() {
	local pkg_candidates="$((cd $GOPATH/src && find . -mindepth 1 -maxdepth 5 -type d \( -path "*/$1" -or -path "*/$1.git" \) -print) | sed 's/^\.\///g')"
	echo "$pkg_candidates"
}

# Change to the directory of the specified Go package name.
gg() {
	paths=($(g "$@"))
	path_index=0

	if [ ${#paths[@]} -gt 1 ]; then
		c=1
		for current in "${paths[@]}"; do
			echo "[$c]: cd ${GOPATH}/${current}"
			c=$((c+1))
		done
		echo -n "Go to which path: "
		read path_index

		path_index=$(($path_index))
	fi

	cd_path=${paths[$path_index]}
	cd $GOPATH/src/$cd_path
}

# git
alias gst='git status'
alias gd='git diff'
alias gc='git commit -v'
alias gco='git checkout'
alias gb='git branch'
alias ga='git add'
alias gap='git add -p'
alias gpm='git pull origin master'
alias grh='git reset HEAD'
alias gfuckit='git reset --hard origin/master'
alias gstats='gitstats -c start_date=2.weeks .git gitstats'
alias gf='git diff --name-status'

# silver searcher
alias ag='\ag --pager="less -XFR"'
