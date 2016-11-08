
" Pathogen
execute pathogen#infect()

" Vim options
set nocompatible
filetype off
filetype plugin indent on
set autoindent
set nu
syntax on
set laststatus=2
"set wildmenu
set nohlsearch

" Airline options
filetype plugin on
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Neovim options
tnoremap <Esc> <C-\><C-n>

" Vim-cpp
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_class_scope_highlight = 1

" Colorscheme
colorscheme noctu
let g:airline_theme = "base16color"
