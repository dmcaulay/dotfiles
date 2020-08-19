DOTFILES="${DOTFILES:-$HOME/src/dotfiles}"

# zsh
ln -sf $DOTFILES/zshrc ~/.zshrc
ln -sf $DOTFILES/dmcaulay.zsh-theme $ZSH/themes/dmcaulay.zsh-theme 

# vim
ln -sf $DOTFILES/vimrc ~/.vimrc
mkdir -p ~/.vim/colors
mkdir -p ~/.vim/ftplugin
mkdir -p ~/.vim/autoload/ftplugin
ln -sf $DOTFILES/colors/distinguished.vim ~/.vim/colors/distinguished.vim
ln -sf $DOTFILES/ruby.vim ~/.vim/ftplugin/ruby.vim
ln -sf $DOTFILES/ruby_autoload.vim ~/.vim/autoload/ftplugin/ruby.vim

# tmux
ln -sf $DOTFILES/tmux.conf ~/.tmux.conf
