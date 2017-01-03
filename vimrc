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
Plug 'https://github.com/bumaociyuan/vim-swift'

"only mac has rich feature, i.e. development
if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
    Plug 'https://github.com/longkai/vimrc'
    Plug 'https://github.com/majutsushi/tagbar'
    Plug 'https://github.com/mattn/emmet-vim.git'
    Plug 'https://github.com/wannesm/wmgraphviz.vim'
    Plug 'https://github.com/Valloric/YouCompleteMe.git'
  endif
endif
call plug#end()

" self defined config
"set nocompatible
set nu
set rnu
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=4
set smarttab
set background=dark
set laststatus=2
set cursorline
set autoread
set ignorecase
set smartcase
set hlsearch
set incsearch

set mps+=<:>
au FileType c,cpp,java,go,swift set mps+==:;

set completeopt=longest,menuone
silent! colorscheme solarized
set backspace=indent,eol,start " allow backspacing over everything in insert mode

" for vim8
if v:version >= 800 
  set breakindent
  set emoji
endif

" customized key binding
map v dwelp " swap two words
noremap % v%

set dir=~/var/vim " tell vim where to put swap files

if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
    " golang
    set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
    autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow
    autocmd FileType go autocmd BufWritePre <buffer> Fmt
  endif
endif

" run simple go programs
autocmd FileType go nmap <F9> :!go test<CR>
autocmd FileType go nmap <F10> :!go run %<CR>

" run simple c programs
autocmd FileType c nmap <F10> :!f=`mktemp`; clang -o $f % && $f<CR>

" run simple swift programs
autocmd FileType swift nmap <F10> :!swift %<CR>

map <C-I> :pyf ~/bin/clang-format.py<CR>
imap <C-I> <c-o> :pyf ~/bin/clang-format.py<CR>
"Todo: auto exec on buffer saved
function! ClangFormatFile()
  let l:lines="all"
  pyf ~/bin/clang-format.py
endfunction
nmap <F12> :call ClangFormatFile()<CR>

filetype plugin indent on
syntax on

" Switch windows via Ctrl-<h,j,k,l> instead of Ctrl-W,<h,j,k,l>
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

ca tn tabnew
" CTRL-Tab is next tab
noremap <C-Tab> :<C-U>tabnext<CR>
inoremap <C-Tab> <C-\><C-N>:tabnext<CR>
cnoremap <C-Tab> <C-C>:tabnext<CR>
" CTRL-SHIFT-Tab is previous tab
noremap <C-S-Tab> :<C-U>tabprevious<CR>
inoremap <C-S-Tab> <C-\><C-N>:tabprevious<CR>
cnoremap <C-S-Tab> <C-C>:tabprevious<CR>
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
  set macligatures
  set guifont=Hack:h16
  "set guifont=Fira\ Code:h16
  set lines=30 columns=100
endif

if has("multi_byte")
	set encoding=utf-8
	set termencoding=utf-8
	set formatoptions+=mM
	set fencs=utf-8
	if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
		set ambiwidth=double
	endif
endif

" nerd tree
map <F2> :NERDTreeToggle<CR>
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" airline
"let g:airline_theme = 'solarized'
let g:airline_theme = 'bubblegum'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline_powerline_fonts = 1

" markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_conceal = 0
let g:vim_markdown_math = 1

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
let g:ycm_filetype_blacklist = { 'swift': 1 }

" tagbar
nmap <F3> :TagbarToggle<CR>
let g:tagbar_width = 24

if has("unix")
  let s:uname = system("uname -s")
  " only mac development env needs it
  if s:uname == "Darwin\n"
    if !executable('/usr/local/bin/ctags')
      silent !brew install ctags
    endif
    let g:tagbar_ctags_bin = '/usr/local/bin/ctags'  " Proper Ctags in mac
  else
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

