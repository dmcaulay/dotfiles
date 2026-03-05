# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export PATH="$HOME/.local/bin:$PATH"

# history
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command
shopt -s checkwinsize

# color prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

parse_git_branch() {
    local branch=$(git branch 2>/dev/null | sed -n 's/* \(.*\)/\1/p')
    if [ -n "$branch" ]; then
        local dirty=$(git status --porcelain 2>/dev/null | head -1)
        [ -n "$dirty" ] && echo " ($branch*)" || echo " ($branch)"
    fi
}

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\] \$ '
else
    PS1='\u@\h:\w$(parse_git_branch) \$ '
fi
unset color_prompt force_color_prompt

# set terminal title
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# git
alias gst='git status'
alias gd='git diff'
alias gc='git commit -v'
alias gco='git checkout'
alias gb='git branch'
alias ga='git add'
alias gap='git add -p'
alias gpo='git pull origin'
alias gpm='git pull origin main'
alias grh='git reset HEAD'
alias gfuckit='git reset --hard origin/main'
alias gstats='gitstats -c start_date=2.weeks .git gitstats'
alias gf='git diff --name-status'

# ripgrep
alias rg='rg --smart-case'

# Cleanup git branches.
clean_branches() {
  for branch in $(git branch | grep -v "main"); do
    echo -n "Delete $branch (y/n)? "
    read answer
    if [[ $answer =~ ^[Yy]$ ]]; then
      git branch -D $branch
    fi
  done
}
