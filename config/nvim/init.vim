"
" Stefan Sonski's neovim Configuration
"

"-----------------------------------------------------------------------------
" Global Stuff
"-----------------------------------------------------------------------------

if ($OS != 'Windows_NT')
  call plug#begin('~/.config/nvim/plugged')
else
  call plug#begin('~/AppData/Local/nvim/plugged')
endif

Plug 'icymind/NeoSolarized'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'rust-lang/rust.vim'
Plug 'sbdchd/neoformat'

call plug#end()

" Set filetype stuff to on
filetype plugin indent on
" Switch on syntax highlighting.
syntax on

" Add the unnamed register to the clipboard
set clipboard=unnamedplus

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
set wildignore+=*.gcno,*.gcda,*.o,*.pyc,.git,build,CMakeFiles

" Automatically read a file that has changed on disk
set autoread
"" Help NeoVim check for modified files: https://github.com/neovim/neovim/issues/2127
autocmd BufEnter,FocusGained * checktime

" Keep some stuff in the history
set history=100

if ($OS != 'Windows_NT')
  " Create backup, swap and undo directory if it does not exist
  if !isdirectory($HOME . "/.cache/nvim/swp")
    call mkdir($HOME . "/.cache/nvim/swp", "p")
  endif
  if !isdirectory($HOME . "/.cache/nvim/undo")
    call mkdir($HOME . "/.cache/nvim/undo", "p")
  endif

  " Set backup, swap and undo directories.
  set directory=~/.cache/nvim/swp//,/tmp

  set undofile
  set undodir=~/.cache/nvim/undo//,/tmp
  set undolevels=1000
  set undoreload=10000
endif

" System default for mappings is now the "," character
let mapleader = ","

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Edit the vimrc file
nmap <silent> <LEADER>ev :e $MYVIMRC<CR>
nmap <silent> <LEADER>sv :so $MYVIMRC<CR>

au BufWritePre * :%s/\s\+$//e
au BufRead,BufNewFile *gitattributes setfiletype gitattributes
au BufRead,BufNewFile *gitconfig* setfiletype gitconfig
au Filetype cpp setlocal shiftwidth=4 tabstop=4 softtabstop=4 colorcolumn=120
au Filetype gitattributes setlocal shiftwidth=8 tabstop=8 softtabstop=8 noexpandtab
au Filetype gitcommit setlocal shiftwidth=2 tabstop=2 softtabstop=2
au Filetype gitconfig setlocal shiftwidth=8 tabstop=8 softtabstop=8 noexpandtab
au FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4
au FileType markdown setlocal shiftwidth=3 tabstop=3 softtabstop=3
au Filetype qml setlocal shiftwidth=4 tabstop=4 softtabstop=4 colorcolumn=180
au FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType tex setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType text setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType vim setlocal shiftwidth=2 tabstop=2 softtabstop=2
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
" LanguageClient-neovim
"-----------------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1

"-----------------------------------------------------------------------------
" LanguageClient-neovim
"-----------------------------------------------------------------------------
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
  \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
  \ 'cpp': ['clangd']
  \ }

"-----------------------------------------------------------------------------
" solarized
"-----------------------------------------------------------------------------
let g:solarized_diffmode="high"

"-----------------------------------------------------------------------------
" Denite
"-----------------------------------------------------------------------------
call denite#custom#var('file/rec', 'command',
  \ ['scantree.py'])

noremap <LEADER>b :Denite buffer<cr>
noremap <LEADER>f :Denite file/rec<cr>

if ($OS != 'Windows_NT')
  "-----------------------------------------------------------------------------
  " powerline
  "-----------------------------------------------------------------------------
  python import vim
  python from powerline.vim import setup as powerline_setup
  python powerline_setup(gvars=globals())
  python del powerline_setup
endif
