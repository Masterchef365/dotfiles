call plug#begin('~/.config/nvim/bundle')

" Syntax highlighting/UI colors
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rust-lang/rust.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'cespare/vim-toml'

" LaTeX
Plug 'lervag/vimtex'

" Completion engines/Compiler integration
Plug 'neovim/nvim-lspconfig' " Collection of configurations for built-in LSP client
Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip' " Snippets plugin

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
set inccommand=nosplit "Show matches while I'm writing a regex
"set inccommand=split "Show matches while I'm writing a regex
nnoremap Y Y
set ft=markdown "Default file type is Markdown, because it's what I use for notes

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
"let g:vimtex_latexmk_options = '-pdf -shell-escape -verbose -file-line-error -synctex=1 -interaction=nonstopmode'
let g:vimtex_view_general_viewer = 'evince'
let g:tex_flavor = 'latex'

" Markdown
let g:markdown_fenced_languages = ['sh', 'rust', 'python', 'glsl', 'c', 'cpp', 'toml', 'lua']

lua <<EOF
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'rust_analyzer', 'clangd', 'pylsp' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
local types = require('cmp.types')

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    -- { name = 'luasnip' },
  },
  -- https://github.com/hrsh7th/nvim-cmp/issues/381#issuecomment-981660945
  -- Shows methods before snippets
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      function(entry1, entry2)
          local kind1 = entry1:get_kind()
          kind1 = kind1 == types.lsp.CompletionItemKind.Text and 100 or kind1
          local kind2 = entry2:get_kind()
          kind2 = kind2 == types.lsp.CompletionItemKind.Text and 100 or kind2
          if kind1 ~= kind2 then
              if kind1 == types.lsp.CompletionItemKind.Snippet then
                  return false
              end
              if kind2 == types.lsp.CompletionItemKind.Snippet then
                  return true
              end
              local diff = kind1 - kind2
              if diff < 0 then
                  return true
              elseif diff > 0 then
                  return false
              end
          end
      end,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
}
EOF

nnoremap <silent> <F2>  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <c-]>    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
"nnoremap <silent> <c-k>     <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

packadd termdebug "Enable terminal-debug
let termdebugger = "rust-gdb" "Use rust-gdb instead of default gdb
