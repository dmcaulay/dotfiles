DOTFILES="${DOTFILES:-$HOME/src/dotfiles}"

# zsh
ln -sf $DOTFILES/zshrc ~/.zshrc
ln -sf $DOTFILES/dmcaulay.zsh-theme ~/.oh-my-zsh/themes/dmcaulay.zsh-theme
mkdir -p ~/.zsh
curl -so ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh https://raw.githubusercontent.com/catppuccin/zsh-syntax-highlighting/main/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 2>/dev/null || true 

# git
ln -sf $DOTFILES/gitconfig ~/.gitconfig

# vim
ln -sf $DOTFILES/vimrc ~/.vimrc
mkdir -p ~/.vim/ftplugin
mkdir -p ~/.vim/autoload/ftplugin
ln -sf $DOTFILES/ruby.vim ~/.vim/ftplugin/ruby.vim
ln -sf $DOTFILES/ruby_autoload.vim ~/.vim/autoload/ftplugin/ruby.vim
ln -sf $DOTFILES/go.vim ~/.vim/ftplugin/go.vim
ln -sf $DOTFILES/go_autoload.vim ~/.vim/autoload/ftplugin/go.vim
ln -sf $DOTFILES/python.vim ~/.vim/ftplugin/python.vim
ln -sf $DOTFILES/python_autoload.vim ~/.vim/autoload/ftplugin/python.vim
ln -sf $DOTFILES/javascript.vim ~/.vim/ftplugin/javascript.vim
ln -sf $DOTFILES/javascript_autoload.vim ~/.vim/autoload/ftplugin/javascript.vim

# neovim (uses vim config)
mkdir -p ~/.config/nvim
ln -sf $DOTFILES/vimrc ~/.config/nvim/init.vim
ln -sf ~/.vim/ftplugin ~/.config/nvim/ftplugin
ln -sf ~/.vim/autoload ~/.config/nvim/autoload

# tmux
ln -sf $DOTFILES/tmux.conf ~/.tmux.conf
