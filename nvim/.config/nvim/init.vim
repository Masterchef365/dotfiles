call plug#begin('~/.config/nvim/bundle')

" Syntax highlighting/UI colors
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rust-lang/rust.vim'
Plug 'cstrahan/vim-capnp'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-lsp'

" Completion engines/Compiler integration
Plug 'lervag/vimtex'
Plug 'neovim/nvim-lsp'

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

" Escape the terminal emulator with one <Esc>
tnoremap <Esc> <C-\><C-n>

" Vim C++ Enhanced Highlighting
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

" LaTeXmk
let g:vimtex_latexmk_options = '-pdf -shell-escape -verbose -file-line-error -synctex=1 -interaction=nonstopmode'
let g:vimtex_view_general_viewer = 'evince'

" Deoplete
let g:deoplete#enable_at_startup = 1

" nvim-lsp
lua require'nvim_lsp'.rust_analyzer.setup({})
lua require'nvim_lsp'.pyls.setup({})
autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc
"set completeopt=menu,preview,noinsert

nnoremap <silent> <F2>  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
"nnoremap <silent> <c-k>     <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
