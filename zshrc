export PATH="$HOME/.local/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="dmcaulay"

plugins=(zsh-syntax-highlighting)

# catppuccin theme for syntax highlighting (must come before plugin load)
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

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

# ripgrep
alias rg='rg --smart-case'

# aider
alias aider='python -m aider'

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

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
