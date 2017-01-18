" Pathogen
execute pathogen#infect()

" Vim options
set nocompatible
filetype off
filetype plugin indent on
set nu
syntax on
set laststatus=2
set nohlsearch

" Use CTRL+HJKL keys to navigate buffers 
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>
tnoremap <Esc> <C-\><C-n>

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

" Vim-cpp
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_class_scope_highlight = 1

" Colorscheme
colorscheme noctu
let g:airline_theme = "base16color"

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ll-db.nvim
set rtp+=/home/duncan/.vim/bundle/lldb.nvim
