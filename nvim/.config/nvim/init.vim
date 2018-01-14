" vim-plug
call plug#begin('~/.config/nvim/bundle')
"Plug 'autozimu/LanguageClient-neovim', {
"			\ 'branch': 'next',
"			\ 'do': './install.sh'
"			\ }

Plug 'Valloric/YouCompleteMe'

Plug 'noahfrederick/vim-noctu'
Plug 'ervandew/supertab'
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
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" NCM and RLS
"set hidden
"let g:LanguageClient_serverCommands = {
"			\ 'rust': ['rls'],
"			\ 'cpp': ['clangd'],
"			\ }
"
"let g:LanguageClient_autoStart = 1
"
"nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

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
