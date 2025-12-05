
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

" Disable Copilot
" let g:copilot_enabled = v:false

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
" COPY HIGHLIGHTED TEXT WITH FILE INFO
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CopyHighlightedWithFileInfo()
  " Get the current file name
  let l:filename = expand('%')
  
  " Get the line range of the selected text
  let l:start_line = line("'<")
  let l:end_line = line("'>")
  
  " Get the highlighted text
  let l:highlighted_text = getline(l:start_line, l:end_line)
  
  " Join the text into a single string
  let l:joined_text = join(l:highlighted_text, "\n")
  
  " Format the output with file name and line range
  let l:formatted_output = printf("File: %s\nLines: %d-%d\n\n%s",
        \ l:filename, l:start_line, l:end_line, l:joined_text)
  
  " Copy the formatted text to the system clipboard
  call setreg('+', l:formatted_output)
  echo "Copied to clipboard: " . l:filename . " (" . l:start_line . "-" . l:end_line . ")"
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COPY FILE NAME
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CopyFilename()
  " Get the current file name
  let l:filename = expand('%')
  
  
  " Copy the formatted text to the system clipboard
  call setreg('+', l:filename)
  echo "Copied to clipboard: " . l:filename
endfunction

map <leader>y :<C-u>call CopyHighlightedWithFileInfo()<CR>
map <leader>yf :<C-u>call CopyFilename()<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPS TO JUMP TO SPECIFIC FZF TARGETS AND FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=/usr/local/bin/fzf

map <leader>f :FZF .<cr>

map <leader>fc :FZF --query=config<cr>
map <leader>fe :FZF --query=event<cr>
map <leader>fh :FZF --query=handler<cr>
map <leader>fi :FZF --query=infra<cr>
map <leader>fl :FZF --query=log<cr>
map <leader>fm :FZF --query=model<cr>
map <leader>fp :FZF --query=pipeline<cr>
map <leader>fr :FZF --query=route<cr>
map <leader>fs :FZF --query=service<cr>
map <leader>ft :FZF --query=task<cr>
map <leader>fx :FZF --query=schema<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Typescript redraw fix
set re=0

" GoTo code navigation.
nmap <leader>d <Plug>(coc-definition)
nmap <leader>td <Plug>(coc-type-definition)
nmap <leader>i <Plug>(coc-implementation)
nmap <leader>r <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Use K to show documentation in preview window.
nnoremap <leader>D :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LEGACY vim-commentary support
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
xmap \\  <Plug>Commentary
nmap \\  <Plug>Commentary
