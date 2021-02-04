"
" Stefan Sonski's neovim Configuration
"

"-----------------------------------------------------------------------------
" Global Stuff
"-----------------------------------------------------------------------------
if ($OS != 'Windows_NT')
  call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')
else
  call plug#begin('$LOCALAPPDATA/AppData/Local/nvim/plugged')
endif

Plug 'icymind/NeoSolarized'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'whiteinge/diffconflicts'
Plug 'peterhoeg/vim-qml'
Plug 'neovim/nvim-lspconfig'
Plug 'itchyny/vim-grep'
Plug 'airblade/vim-gitgutter'

if ($OS != 'Windows_NT')
  Plug 'sbdchd/neoformat'
endif

call plug#end()

let g:loaded_python_provider = 0

" Set filetype stuff to on
filetype plugin indent on
" Switch on syntax highlighting.
syntax on

" Add the unnamed register to the clipboard
set clipboard^=unnamed,unnamedplus

" Activate spell-checking as default.
set spell

" Set tab and indent options
set expandtab
set autoindent
set breakindent
set showbreak=...
set linebreak
" set the search scan to wrap lines
set wrapscan
" Let's try ignorecase smartcase for searches.
set ignorecase
set smartcase
" Enable search highlighting
set hlsearch
" Incrementally match the search
set incsearch
" Incrementally match the substitution
set inccommand=nosplit

" set visual bell -- I hate that damned beeping
set vb

" Make sure that unsaved buffers that are to be put in the background are
" allowed to go in there (i.e. the "must save first" error doesn't come up)
set hidden

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2

" Hide the mouse pointer while typing
set mousehide
set mouse=""
" Hide current mode in command
set noshowmode

" Trying out the line numbering thing...
set relativenumber
" Highlight the current cursor line
set cursorline
set lazyredraw
" Allow the cursor to go in to "invalid" places
set virtualedit=all

" Make the command-line completion better
set wildmenu
set wildmode=longest:list,full

set completeopt+=noinsert
set completeopt-=preview
" Hide completion messages in command line
set shortmess+=c

" Types of files to ignore when auto completing things
set wildignore+=*.gcno,*.gcda,*.o,*.pyc,.git,build,CMakeFiles,target

" Automatically read a file that has changed on disk
set autoread
"" Help NeoVim check for modified files: https://github.com/neovim/neovim/issues/2127
autocmd BufEnter,FocusGained * checktime

" Keep some stuff in the history
set history=100

" Activate undo directories.
set undofile
set undolevels=1000
set undoreload=10000

" System default for mappings is now the "," character
let mapleader = ","

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Edit the vimrc file
nmap <silent> <LEADER>ev :e $MYVIMRC<CR>
nmap <silent> <LEADER>sv :so $MYVIMRC<CR>

au BufWritePre * silent! :undojoin | %s/\s\+$//e
au BufRead,BufNewFile *gitattributes setfiletype gitattributes
au BufRead,BufNewFile *gitconfig* setfiletype gitconfig
au BufRead,BufNewFile *.ts set filetype=xml
au BufWritePre *.cpp silent! :undojoin | Neoformat astyle
au BufWritePre *.h silent! :undojoin | Neoformat astyle
au Filetype c setlocal shiftwidth=4 tabstop=4 softtabstop=4 colorcolumn=150
au Filetype cpp setlocal shiftwidth=4 tabstop=4 softtabstop=4 colorcolumn=150
au FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
au Filetype gitattributes setlocal shiftwidth=8 tabstop=8 softtabstop=8 noexpandtab
au Filetype gitcommit setlocal shiftwidth=2 tabstop=2 softtabstop=2
au Filetype gitconfig setlocal shiftwidth=8 tabstop=8 softtabstop=8 noexpandtab
au FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4
au FileType markdown setlocal shiftwidth=3 tabstop=3 softtabstop=3
au Filetype python setlocal shiftwidth=4 tabstop=4 softtabstop=4 colorcolumn=80
au Filetype qml setlocal shiftwidth=4 tabstop=4 softtabstop=4 colorcolumn=180
au FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType tex setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType text setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType vim setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=80
au FileType zsh setlocal shiftwidth=2 tabstop=2 softtabstop=2

"-----------------------------------------------------------------------------
" Set up the window colors and size
"-----------------------------------------------------------------------------
colorscheme NeoSolarized
set background=dark

let g:main_font = "Hack\\ Regular\\ 8"
let g:small_font = "Hack\\ Regular\\ 4"

"-----------------------------------------------------------------------------
" solarized
"-----------------------------------------------------------------------------
let g:solarized_diffmode="high"

"-----------------------------------------------------------------------------
" ctrlp
"-----------------------------------------------------------------------------
let g:ctrlp_working_path_mode = 0
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_open_multiple_files = '1ri'
let g:ctrlp_match_window = 'max:50'"

noremap <LEADER>b :CtrlPBuffer<cr>
noremap <LEADER>f :CtrlP<cr>

"-----------------------------------------------------------------------------
" lsp
"-----------------------------------------------------------------------------
lua <<EOF
require'lspconfig'.bashls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.rls.setup{}
require'lspconfig'.tsserver.setup{}
EOF

autocmd Filetype c setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype cpp setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype css setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype dockerfile setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype javascript setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype qml setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype sh setlocal omnifunc=v:lua.vim.lsp.omnifunc

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>

"-----------------------------------------------------------------------------
" powerline
"-----------------------------------------------------------------------------
python import vim
python from powerline.vim import setup as powerline_setup
python powerline_setup(gvars=globals())
python del powerline_setup
