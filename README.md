vimrc
===
My ``.vimrc``, a lightweight vim configuration file.

This config file use the [Plug][1] as the plugin manager tool.

Using it, soft linking file ``vimrc`` as ``~/.vimrc`` or just rename it.

```sh
$ ln -s path/to/repo/vimrc ~/.vimrc
```

Feel free to modify to adjust your use:)

Plugins uses:
```viml
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
```

For Windows user, you should know how to handle ``~``, the home directory in your OS.

The plugins contains [YouCompleteMe][2], it is not out of box which needs more work to do. If you donnot need it just comment it.

Happy Hacking!

[1]: https://github.com/junegunn/vim-plug
[2]: https://github.com/Valloric/YouCompleteMe
