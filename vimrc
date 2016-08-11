if empty(glob('~/var/vim'))
  silent !mkdir -p ~/var/vim
endif

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
if empty(glob('$VIM/runtime/syntax/go.vim'))
  Plug 'https://github.com/google/vim-ft-go' " see its doc
endif
Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/Raimondi/delimitMate'
Plug 'https://github.com/Yggdroot/indentLine.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/plasticboy/vim-markdown.git'
Plug 'https://github.com/bling/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'

"only mac has rich feature, i.e. development
if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
    Plug 'https://github.com/mattn/emmet-vim.git'
    Plug 'https://github.com/majutsushi/tagbar'
    Plug 'https://github.com/longkai/vimrc'
    Plug 'https://github.com/rizzatti/dash.vim'
    Plug 'https://github.com/Valloric/YouCompleteMe.git'
    Plug 'https://github.com/wannesm/wmgraphviz.vim'
  endif
endif
call plug#end()

" self defined config
set nocompatible
set rnu
set nu
set spell
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=4
set smarttab
set background=dark
set laststatus=2
set cursorline
set ignorecase
set autoread
set completeopt=longest,menuone
silent! colorscheme solarized

set backspace=indent,eol,start " allow backspacing over everything in insert mode
map v dwelp " swap two words
map , A;<ESC><CR> " insert semicolon at the end

set dir=~/var/vim " tell vim where to put swap files

" run simple c program
autocmd FileType c nmap <F10> :!clang % && ./a.out && rm -f ./a.out<CR>

if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
    " golang
    set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
    autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow
    autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd FileType go nmap <F10> :!go run %<CR>
  endif
endif

filetype plugin indent on
syntax on

" Switch windows via Ctrl-<h,j,k,l> instead of Ctrl-W,<h,j,k,l>
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

" Tabs for mac users (using the 'apple' key)
nnoremap <D-S-]> gt
nnoremap <D-S-[> gT
nnoremap <D-1> 1gt
nnoremap <D-2> 2gt
nnoremap <D-3> 3gt
nnoremap <D-4> 4gt
nnoremap <D-5> 5gt
nnoremap <D-6> 6gt
nnoremap <D-7> 7gt
nnoremap <D-8> 8gt
nnoremap <D-9> 9gt
nnoremap <D-0> :tablast<CR>

autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \     exe "normal! g`\"" |
  \ endif

if has('gui_running')
  set guifont=Hack:h16
  set lines=30 columns=100
endif

" nerd tree
let NERDTreeShowLineNumbers=1 " enable line numbers
map <C-n> :NERDTreeToggle<CR>
autocmd FileType nerdtree setlocal relativenumber " make sure relative line numbers are used

" airline
let g:airline_theme = 'bubblegum'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_conceal = 0

" emmet
let g:user_emmet_expandabbr_key = '<Tab>'
"imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")     " the same as normal mode
let g:user_emmet_mode = 'n'
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall      " only enable in html and css

" vim-gitgutter
let g:gitgutter_realtime = 250
let g:gitgutter_highlight_lines = 1

" delimitMate
let delimitMate_expand_cr = 1

" ycm
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_width = 24

if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
    if !executable('/usr/local/bin/ctags')
      silent !brew install ctags
    endif
    let g:tagbar_ctags_bin = '/usr/local/bin/ctags'  " Proper Ctags in mac
  else
    " only mac development env needs it
    " if !executable('/usr/bin/ctags')
    "   silent !sudo yum install -y ctags
    " endif
    " let g:tagbar_ctags_bin = '/usr/bin/ctags'  " Proper Ctags in non-mac unix env
  endif
endif


let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

