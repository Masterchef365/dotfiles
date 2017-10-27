let s:editor_root=expand("~/.config/nvim")

" Vundle
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#rc(s:editor_root . '/bundle')
Plugin 'VundleVim/Vundle.vim'
Plugin 'kshenoy/vim-signature'
Plugin 'noahfrederick/vim-noctu'
Plugin 'tpope/vim-fugitive'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'Valloric/YouCompleteMe'
Plugin 'autozimu/LanguageClient-neovim'
Plugin 'rust-lang/rust.vim'
Plugin 'roxma/nvim-completion-manager'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'lilydjwg/colorizer'
Plugin 'ervandew/supertab'
call vundle#end()

" Misc
filetype plugin indent on
set nocompatible
set rnu
syntax on
set laststatus=2
set nohlsearch
set nowrap
set foldmethod=syntax
set nofoldenable
set mouse=a
set hidden
tnoremap <Esc> <C-\><C-n>
set clipboard=unnamedplus

" OCD Auto-Align a block of text
"let @c = 'v}k$:�ku=G}j'

" More cursors
let g:multi_cursor_use_default_mapping=1

" Use CTRL+HJKL keys to navigate buffers
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" Cursor shape changes
"let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

" Tabs
set autoindent
set tabstop=3
set shiftwidth=3

" Airline options
filetype plugin on
"let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 0
"let g:airline_left_sep = 		""
"let g:airline_right_sep = 		""
"let g:airline_left_alt_sep = 	""
"let g:airline_right_alt_sep = ""
let g:airline_theme = "base16color"

" Colorschemes
colorscheme noctu

" Nerdtree
"map <C-n> :NERDTreeToggle<CR>
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ll-db.nvim
set rtp+=/home/duncan/.config/nvim/init.vim
nmap <M-b> <Plug>LLBreakSwitch

" Better syntax highlighting
let g:cpp_concepts_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1

" TMUX
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> {Left-Mapping} :TmuxNavigateLeft<cr>
nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" NCM and RLS
set hidden
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" Indent guides
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
hi IndentGuidesEven ctermbg=0 guibg=0
hi IndentGuidesOdd ctermbg=0 guibg=8
let g:indent_guides_tab_guides = 0

" Clang complete
let g:ycm_filetype_whitelist = { '*.cpp': 1 }

" Colorizer
let g:colorizer_maxlines = 1000

