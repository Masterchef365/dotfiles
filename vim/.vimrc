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
set wildmenu

" Supertab
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
let g:SuperTabClosePreviewOnPopupClose = 1

" Completion Functions
set completeopt=longest,menuone,preview
set conceallevel=2
set concealcursor=vin
let g:clang_snippets=1
let g:clang_conceal_snippets=1
let g:clang_snippets_engine='clang_complete'
let g:clang_user_options='|| exit 0'
let g:clang_complete_auto = 0
let g:clang_complete_copen = 1
set pumheight=20

" Airline options
filetype plugin on
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

