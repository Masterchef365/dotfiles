" vim-plug
call plug#begin('~/.config/nvim/bundle')
Plug 'lervag/vimtex'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'sheerun/vim-polyglot'
"Plug 'autozimu/LanguageClient-neovim', {
"			\ 'branch': 'next',
"			\ 'do': 'bash install.sh',
"			\ }
Plug 'Valloric/YouCompleteMe'
Plug 'noahfrederick/vim-noctu'

call plug#end()

" Misc
filetype plugin indent on
set nocompatible
set rnu
set nu
syntax on
set laststatus=2
set nohlsearch 
set nowrap
set foldmethod=syntax
set nofoldenable
set mouse=a
set hidden
set clipboard=unnamedplus

" Easy search-replace under cursor
nnoremap <Leader>s :%s:\<<C-r><C-w>\>:

" Use CTRL+HJKL keys to navigate buffers
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" Cursor shape changes
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

" Tabs
set autoindent
set tabstop=3
set shiftwidth=3

" Colorschemes
colorscheme noctu

" vim-cpp-enhanced-highlight
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

" Fix latexmk
let g:polyglot_disabled = ['latex']

" latexmk
let g:vimtex_latexmk_options = '-pdf -shell-escape -verbose -file-line-error -synctex=1 -interaction=nonstopmode'
