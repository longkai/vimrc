lightweight vimrc
===
A lightweight c/go/markdown configuration file of vim which take the [Plug][1] as its plugin manager tool.

Using it, soft linking file ``vimrc`` as ``~/.vimrc``. 

```sh
$ ln -s path/to/repo/vimrc ~/.vimrc
```

Note: this is **self used only**. If you get insterested with some of these plugins, you should **check the plugin's** pre-requirement.

```viml
Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/tomtom/tcomment_vim'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/majutsushi/tagbar'
Plug 'https://github.com/Raimondi/delimitMate'
Plug 'https://github.com/Yggdroot/indentLine.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/plasticboy/vim-markdown.git'
Plug 'https://github.com/bling/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/Valloric/YouCompleteMe.git'
Plug 'https://github.com/vim-jp/vim-go-extra'
```

Happy Hacking!

[1]: https://github.com/junegunn/vim-plug
