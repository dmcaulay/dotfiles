export ZSH="/Users/dan/.oh-my-zsh"

ZSH_THEME="dmcaulay"

plugins=()

source $ZSH/oh-my-zsh.sh

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

# silver searcher
alias ag='\ag --pager="less -XFR"'

# aider
alias aider='python -m aider'

# go bin
export PATH=$PATH:$(go env GOPATH)/bin

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# Cleanup git branches.
clean_branches() {
  for branch in $(git branch | grep -v "main"); do
    echo -n "Delete $branch (y/n)? "
    read answer
    if [[ $answer =~ ^[Yy]$ ]]
    then
      git branch -D $branch
    fi
  done
}

# Created by `pipx` on 2024-11-07 05:22:55
export PATH="$PATH:/Users/dan/.local/bin"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

