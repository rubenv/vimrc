" .vimrc file
" Author: Ruben Vermeersch <ruben@rocketeer.be>

filetype off
call pathogen#infect()
filetype plugin indent on

" General Settings:
set autoindent                  " Automatically indent
set autoread                    " Automatically read changed files
set cindent                     " C syntax formatting
set clipboard=unnamed           " yank and paste with the system clipboard
set expandtab                   " Use spaces instead of tabs
set formatoptions=qroct         " see :help fo-table for info
set hlsearch                    " Highlight search matches
set ignorecase                  " Ignore search case...
set incsearch                   " Incremental search
set nocompatible                " Don't start in vi compatibility mode
set nopaste                     " Don't paste, we want normal insert mode
set ruler                       " Show postion of pointer
set scrolloff=3                 " show context above/below cursorline
set shiftwidth=4                " 4 spaces tabbing
set showcmd                     " Show command
set showmode                    " Show mode in search
set smartcase                   " ... unless search contains caps
set smartindent                 " In a smarty way
set softtabstop=4               " 4 spaces tabbing
set splitright                  " splitting a window will put it to the right
set tabstop=4                   " 4 spaces tabbing
set ttyfast                     " Fast, nice updating
set wildignore=log/**,dist/**,tmp/**,.tmp/**
set wildmenu                    " show a navigable menu for tab completion
set wildmode=longest,list,full
syntax enable                   " highlight syntax

" Unlimited persistent undo:
set undofile
set undodir=~/.vim/undo

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists('$TMUX') && !has('nvim')  " Support resizing in tmux
  set ttymouse=xterm2
endif

"
" Keybindings:
"
set pastetoggle=<F2>
map § :nohlsearch<CR>
"let mapleader = ','
map <leader>l :Align
nmap <leader>a :Ack
nmap <leader>b :CommandTBuffer<CR>
nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>
nmap <leader>t :CommandT<CR>
nmap <leader>T :CommandTFlush<CR>:CommandT<CR>
nmap <leader>] :TagbarToggle<CR>
nmap <leader><space> :%s/\s\+$//<CR>
nmap <leader>g :ToggleGitGutter<CR>
nmap <leader>c <Plug>Kwbd
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" plugin settings
let g:CommandTMaxHeight=20
let g:CommandTWildIgnore=&wildignore . ",**/node_modules/*"
let g:NERDSpaceDelims=1
let g:gitgutter_enabled = 0
" ZOMG the_silver_searcher is so much faster than ack"
let g:ackprg = 'ag --nogroup --column'

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Filetypes
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby

"
" Position:
"
set viminfo='10,\"100,:20,%,n~/.viminfo
autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Automatic close char mapping
inoremap  {<CR> {<CR>}<C-O>O

" Insert <Tab> or complete identifier
" if the cursor is after a keyword character
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 1

nmap <Tab> >>
nmap <S-Tab> <<

" Go configuration
let g:go_fmt_command = "goimports"

" HCL formatting
let g:hcl_fmt_autosave = 1

" Map \\ to tests, but save and store position first
autocmd FileType go nmap <leader><leader> :wa<CR>mT:GoTest<CR>
" Jump back to last editing position before test run: \'
autocmd FileType go nmap <leader>' `T
