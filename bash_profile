
ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export RBENV_ROOT="$HOME/.rbenv"

# prompt
PS1="\[\033[01;92m\]\u@\h\[\033[01;96m\] \w \e[91m\$(parse_git_branch)
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
alias gp='git push'
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
alias vim_node='ln -s ~/code/dotfiles/vimrc-node ~/.vimrc && vim'
alias vim_ruby='ln -s ~/code/dotfiles/vimrc-ruby ~.vimrc && vim'
