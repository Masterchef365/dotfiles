#!/bin/bash

URL_LIST="
https://github.com/critiqjo/lldb.nvim.git
https://github.com/Xuyuanp/nerdtree-git-plugin.git
https://github.com/scrooloose/nerdtree.git
https://github.com/noahfrederick/vim-noctu.git
https://github.com/edkolev/promptline.vim.git
https://github.com/neovim/python-client.git
https://github.com/vim-airline/vim-airline.git
https://github.com/vim-airline/vim-airline-themes.git
https://github.com/tpope/vim-dispatch.git
https://github.com/Valloric/YouCompleteMe.git
"

for x in $URL_LIST; do
	git submodule add $x $pwd
done

