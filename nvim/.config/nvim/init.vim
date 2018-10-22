" Plugins
call plug#begin('~/.config/nvim/bundle')
Plug 'lervag/vimtex'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'sheerun/vim-polyglot'
"Plug 'autozimu/LanguageClient-neovim', {
"			\ 'branch': 'next',
"			\ 'do': 'bash install.sh',
"			\ }
"Plug 'Valloric/YouCompleteMe'
Plug 'noahfrederick/vim-noctu'
Plug 'davidhalter/jedi-vim'
call plug#end()

" Misc
filetype plugin indent on
set nocompatible
set rnu
set nu
syntax on
set laststatus=2
set nohlsearch 
set foldmethod=syntax
set nofoldenable
set mouse=a
set hidden
set clipboard=unnamedplus

" Wrap, but perserve indents. Move through the lines like they are not wrapped
" but line broken instead.
set wrap lbr
set breakindent
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

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
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" Colorscheme
colorscheme noctu

" vim-cpp-enhanced-highlight
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

" Fix latexmk
let g:polyglot_disabled = ['latex']

" latexmk
let g:vimtex_latexmk_options = '-pdf -shell-escape -verbose -file-line-error -synctex=1 -interaction=nonstopmode'

" Rust language server
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ }
