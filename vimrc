if empty(glob('~/var/vim'))
  silent !mkdir -p ~/var/vim
endif

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/bling/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/plasticboy/vim-markdown.git'
Plug 'https://github.com/Yggdroot/indentLine.git'
Plug 'https://github.com/Raimondi/delimitMate'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/fatih/vim-go.git'
Plug 'https://github.com/mattn/emmet-vim.git'
if version >= 704
  Plug 'https://github.com/Valloric/YouCompleteMe.git'
else
  Plug 'https://github.com/myusuf3/numbers.vim.git' 
endif

"Plug 'https://github.com/scrooloose/syntastic.git'

call plug#end()

" self defined config
set nocompatible

if version >= 704
  set rnu
endif

set nu
syntax on
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
colorscheme solarized

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
map v dwelp

filetype indent on

if (exists('+colorcolumn'))
   set colorcolumn=100
  "highlight ColorColumn ctermbg=9
endif

"set foldmethod=syntax

"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

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

" tell vim to keep a backup file
set backup
" tell vim where to put its backup files
set backupdir=~/var/vim
" tell vim where to put swap files
set dir=~/var/vim

if has('gui_running')
  set guifont=Hack:h16
  set lines=30 columns=100
endif

autocmd InsertEnter * set timeoutlen=200
autocmd InsertLeave * set timeoutlen=1000

" nerd tree
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

" delimitMate
let delimitMate_expand_cr=1

" airline
let g:airline_theme = 'bubblegum'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" markdown
let g:vim_markdown_folding_disabled = 1

" go-vim
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" emmet
let g:user_emmet_expandabbr_key = '<Tab>'
"imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")     " the same as normal mode
let g:user_emmet_mode = 'n'
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall      " only enable in html and css

" tagbar
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
let g:go_auto_type_info=1
if get(g:, "go_auto_type_info", 0)
  setlocal updatetime=250
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

" ctrlp
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

