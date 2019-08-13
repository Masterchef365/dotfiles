call plug#begin('~/.config/nvim/bundle')

" Syntax highlighting/UI colors
"Plug 'noahfrederick/vim-noctu'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rust-lang/rust.vim'
"Plug 'jeffkreeftmeijer/vim-dim'

" Completion engines/Compiler integration
Plug 'lervag/vimtex'
Plug 'autozimu/LanguageClient-neovim', {
			\ 'branch': 'next',
			\ 'do': 'bash install.sh',
			\ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

" Misc
filetype plugin indent on "Use new fancy vim stuff
set nocompatible "Ditto
set rnu "Relative line numbers
set nu "But still show my current line number
syntax on "Syntax highlighting!
"set laststatus=1 "Don't show the file name unless there's multiple
set hls! "Don't highlight everything while searching
set mouse=a " Allow use of the mouse (Sometimes it's nice, okay?!)
set hidden "Allow multiple buffers
set clipboard=unnamedplus "Use the system clipboard
set foldmethod=syntax "Allow folding
set nofoldenable "But don't do it by default
set noruler "Don't display extra ruler cruft by default
"set cursorline

" Use CTRL+HJKL keys to navigate buffers
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" Quicker buffer navigation
map gb :bn<cr>
map gB :bp<cr>

" Wrap, but preserve indents. Move through the lines 
" as though they are not wrapped but line broken instead.
set wrap lbr
set breakindent
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Easy search-replace under cursor when \s is hit
nnoremap <Leader>s :%s:\<<C-r><C-w>\>:

" Cursor shape changes based on mode
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

" Indentation, tabs are now all 4 spaces wide; tab key inserts four spaces.
set autoindent
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" Colorscheme
colorscheme variac

" Vim C++ Enhanced Highlighting
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

" LaTeXmk
let g:vimtex_latexmk_options = '-pdf -shell-escape -verbose -file-line-error -synctex=1 -interaction=nonstopmode'
let g:vimtex_view_general_viewer = 'evince'

" Language Client Neovim 
" \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
let g:LanguageClient_serverCommands = {
    \ "rust": ["rustup", "run", "stable", "ra_lsp_server"],
    \ 'cpp': ['clangd-6.0'],
    \ 'c': ['clangd-6.0'],
    \ 'cu': ['clangd-6.0'],
    \ 'python': ['pyls'],
    \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gu :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
let g:deoplete#enable_at_startup = 1
