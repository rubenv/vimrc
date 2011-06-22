" .vimrc file
" Author: Ruben Vermeersch <ruben@Lambda1.be>

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


" General Settings:
set nocompatible                " Don't start in vi compatibility mode
set expandtab                   " Use spaces instead of tabs
set shiftwidth=4                " 4 spaces tabbing
set softtabstop=4               " 4 spaces tabbing
set tabstop=4                   " 4 spaces tabbing
set nopaste                     " Don't paste, we want normal insert mode
set cindent                     " C syntax formatting
set showcmd                     " Show command
set showmode                    " Show mode in search
set incsearch                   " Incremental search
set ruler                       " Show postion of pointer
set wildmode=list:longest,full  " Bash alike completion
set ignorecase                  " Ignore search case...
set smartcase                   " ... unless search contains caps
set hlsearch                    " Highlight search matches
set ttyfast                     " Fast, nice updating
set autoindent                  " Automatically indent
set smartindent                 " In a smarty way
syntax enable                   " highlight syntax
set formatoptions=qroct         " see :help fo-table for info
set splitright                  " splitting a window will put it to the right

filetype off
filetype plugin indent on

"autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
"autocmd FileType eruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
"autocmd FileType haml setlocal shiftwidth=2 tabstop=2 softtabstop=2
"au BufRead,BufNewFile *.scss set filetype=scss

"
" Keybindings:
"
set pastetoggle=<F2>
map <F3> :make!<CR>
map <F4> :make! install<CR>
map <F5> :cwindow<CR>
map <F6> :cnext<CR>
map <F7> :Tlist<CR><C-W>20<LEFT>
map § :nohlsearch<CR>

"
" Position:
"
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"
" Extra Scripts:
" 
try
    helptags ~/.vim/doc
catch
endtry

" Automatic close char mapping
inoremap  {<CR> {<CR>}<C-O>O

" Automatically save and load views
au BufWinLeave *.cs mkview
au BufWinEnter *.cs silent loadview
au BufWinLeave *.php mkview
au BufWinEnter *.php silent loadview
au BufWinLeave *.js mkview
au BufWinEnter *.js silent loadview
au BufWinLeave *.h mkview
au BufWinEnter *.h silent loadview
au BufWinLeave *.c mkview
au BufWinEnter *.c silent loadview
au BufWinLeave *.cpp mkview
au BufWinEnter *.cpp silent loadview



" ######################################################################
" The snippet below causes serials in zone files to be auto-incremented.
function! UPDSERIAL(date, num)
if (strftime("%Y%m%d") == a:date)
return a:date . a:num+1
endif
return strftime("%Y%m%d") . '01'
endfunction
command Soa :%s/(2[0-9]{7})([0-9]{2})(s*; serial)/=UPDSERIAL(submatch(1), submatch(2)) . submatch(3)/g
autocmd BufRead /var/named/*zone Soa
" ######################################################################


" Insert <Tab> or complete identifier
" if the cursor is after a keyword character
function MyTabOrComplete()
    let col = col('.')-1
    if !col || getline('.')[col-1] !~ '\k'
         return "\<tab>"
    else
         return "\<C-N>"
    endif
endfunction
inoremap <Tab> <C-R>=MyTabOrComplete()<CR>

" Map ctrl-space to complete-next.
inoremap <Nul> <C-N>

nmap <Tab> >>
nmap <S-Tab> <<
