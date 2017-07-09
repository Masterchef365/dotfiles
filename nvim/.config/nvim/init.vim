let s:editor_root=expand("~/.config/nvim")

" Vundle
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#rc(s:editor_root . '/bundle')
Plugin 'VundleVim/Vundle.vim'

"lugin 'https://github.com/scrooloose/nerdtree.git'
"lugin 'https://github.com/Xuyuanp/nerdtree-git-plugin.git'
"lugin 'https://github.com/edkolev/promptline.vim.git'
Plugin 'https://github.com/vim-airline/vim-airline.git'
Plugin 'https://github.com/vim-airline/vim-airline-themes.git'

Plugin 'https://github.com/tpope/vim-fugitive.git'
Plugin 'https://github.com/noahfrederick/vim-noctu.git'
Plugin 'https://github.com/terryma/vim-multiple-cursors.git'

" You're gonna need libtinfo from the AUR, and you'll need to run
" sudo ln -s /usr/lib/libtinfo.so.6 /usr/lib/libtinfo.so.5 so that YCM doesn't
" have a panic attack. What a baby.
Plugin 'https://github.com/Valloric/YouCompleteMe.git'

"lugin 'https://github.com/critiqjo/lldb.nvim.git'
"lugin 'https://github.com/tpope/vim-dispatch.git'
"lugin 'https://github.com/lervag/vimtex.git'
"lugin 'octol/vim-cpp-enhanced-highlight'
"lugin 'christoomey/vim-tmux-navigator'
"lugin 'racer-rust/vim-racer'

Plugin 'autozimu/LanguageClient-neovim'
Plugin 'git://github.com/roxma/nvim-completion-manager.git'
Plugin 'rust-lang/rust.vim'
Plugin 'git://github.com/nathanaelkane/vim-indent-guides.git'
call vundle#end()

" More cursors
let g:multi_cursor_use_default_mapping=1

" Vim options
filetype plugin indent on
set nocompatible
set nu
syntax on
set laststatus=2
set nohlsearch
set nowrap
set foldmethod=syntax
set nofoldenable
set mouse=a
set hidden
"noremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
"inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
"inoremap <expr> <tab> ((pumvisible())?("\<Cr>"):("<Cr>"))
tnoremap <Esc> <C-\><C-n>
set clipboard=unnamedplus
"nnoremap H ^
"nnoremap L $


" Use CTRL+HJKL keys to navigate buffers
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" Cursor shape changes
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Tabs
set autoindent
set tabstop=3
set shiftwidth=3

" Airline options
filetype plugin on
let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = 		""
let g:airline_right_sep = 		""
let g:airline_left_alt_sep = 	""
let g:airline_right_alt_sep = ""

" Colorschemes
colorscheme noctu
let g:airline_theme = "base16color"

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ll-db.nvim
set rtp+=/home/duncan/.config/nvim/init.vim
nmap <M-b> <Plug>LLBreakSwitch

" Latex shortcut
"autocmd BufWrite *.tex !pdflatex *.tex
"if !exists('g:ycm_semantic_triggers')
"	let g:ycm_semantic_triggers = {}
"endif
"let g:ycm_semantic_triggers.tex = [
"			\ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
"			\ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
"			\ 're!\\hyperref\[[^]]*',
"			\ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
"			\ 're!\\(include(only)?|input){[^}]*',
"			\ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
"			\ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
"			\ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
"			\ ]

" Better syntax highlighting
let g:cpp_concepts_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1

" TMUX
"let g:tmux_navigator_no_mappings = 1
"nnoremap <silent> {Left-Mapping} :TmuxNavigateLeft<cr>
"nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
"nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
"nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
"nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" NCM and RLS
set hidden
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
"inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
hi IndentGuidesEven ctermbg=0 guibg=0
hi IndentGuidesOdd ctermbg=0 guibg=8
let g:indent_guides_tab_guides = 0

" Clang complete
let g:ycm_filetype_whitelist = { 'cpp': 1 }
