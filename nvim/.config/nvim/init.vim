let s:editor_root=expand("~/.config/nvim")

" Vundle
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#rc(s:editor_root . '/bundle')
Plugin 'VundleVim/Vundle.vim'

Plugin 'floobits/floobits-neovim'

Plugin 'https://github.com/critiqjo/lldb.nvim.git'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/Xuyuanp/nerdtree-git-plugin.git'
Plugin 'https://github.com/edkolev/promptline.vim.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'https://github.com/tpope/vim-dispatch.git'
Plugin 'https://github.com/tpope/vim-fugitive.git'
Plugin 'https://github.com/noahfrederick/vim-noctu.git'
Plugin 'https://github.com/Valloric/YouCompleteMe.git'
Plugin 'https://github.com/terryma/vim-multiple-cursors.git'

" More cursors
let g:multi_cursor_use_default_mapping=1

" Vim options
set nocompatible
filetype off
filetype plugin indent on
set nu
syntax on
set laststatus=2
set nohlsearch
set nowrap
set foldmethod=syntax
set nofoldenable
set mouse=a

" Use CTRL+HJKL keys to navigate buffers 
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>
"tnoremap <Esc> <C-\><C-n>

" Cursor shape changes
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Tabs
set autoindent
set tabstop=3
set shiftwidth=3

" Airline options
filetype plugin on
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = "\ue0b8"
let g:airline_right_sep = "\ue0ba"
let g:airline_left_alt_sep = "\ue0b9"
let g:airline_right_alt_sep = "\ue0bb"


" Vim-cpp
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_class_scope_highlight = 1

" Colorscheme
colorscheme noctu
let g:airline_theme = "base16"

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ll-db.nvim
set rtp+=/home/duncan/.config/nvim/init.vim
nmap <M-b> <Plug>LLBreakSwitch
