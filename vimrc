
set nocompatible                  " Must come first because it changes other options.

call pathogen#infect()

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.
" remember more commands and search history
set history=10000

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set wildignore+=tmp/**            " Ignore tmp files, used for command t
set wildignore+=node_modules/**   " Ignore node modules, used for command t

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set noswapfile                    " no swap files

set tabstop=2                    " Global tab width.
set shiftwidth=2                 " And again, related.
set expandtab                    " Use spaces instead of tabs

set visualbell

set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

" enable copying to and from the mac clipboard
set clipboard=unnamed

" add plugins
packadd! matchit

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256 " 256 colors
set background=dark
:color distinguished
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40

let mapleader=","

cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>
" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>
nnoremap <leader><leader> <c-^>

let g:ackprg = 'ag --vimgrep'

vmap <Tab> >gv
vmap <S-Tab> <gv

map ; :
noremap ;; ;

" vim-go
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'))
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPS TO JUMP TO SPECIFIC CtrlP TARGETS AND FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](node_modules|env|htmlcov|Godeps|vendor|env|gen|.gen)$',
  \ 'file': '\v\.(pyc)$',
  \ }
map <leader>f :CtrlP .<cr>
map <leader>F :CtrlP %%<cr>

" rails
map <leader>fr :topleft :split config/routes.rb<cr>
map <leader>fg :topleft 100 :split Gemfile<cr>
map <leader>fv :CtrlP app/views<cr>
map <leader>fc :CtrlP app/controllers<cr>
map <leader>fm :CtrlP app/models<cr>
map <leader>fw :CtrlP app/workers<cr>
map <leader>fh :CtrlP app/helpers<cr>
map <leader>fl :CtrlP lib<cr>
map <leader>fs :CtrlP spec<cr>

" python
map <leader>fp :call ftplugin#python#CtrlpProject()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPS TO JUMP TO SPECIFIC LOCATIONS IN A FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>d /def
map <leader>c /class
map <leader>t /type
map <leader>fn /func

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LEGACY vim-commentary support
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
xmap \\  <Plug>Commentary
nmap \\  <Plug>Commentary
