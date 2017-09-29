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

Plug 'vim-scripts/UltiSnips'
Plug 'elzr/vim-json'
Plug 'stefansonski/vim-snippets'
Plug 'tpope/vim-fugitive'
Plug 'derekwyatt/vim-fswitch'
Plug 'derekwyatt/vim-protodef'
Plug 'icymind/NeoSolarized'
Plug 'kana/vim-operator-user'
Plug 'Chiel92/vim-autoformat'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'lervag/vimtex'
Plug 'peterhoeg/vim-qml'
Plug 'huawenyu/neogdb.vim'

" Non-Windows plugins
if ($OS != 'Windows_NT')
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang --system-boost --gocode-completer' }
  Plug 'arakashic/chromatica.nvim'
endif

call plug#end()

" Set filetype stuff to on
filetype plugin indent on

" Set tab and indent options
set expandtab
set autoindent
set breakindent
set showbreak=...
set linebreak

" Highlight different highlight groups
set list

" set the search scan to wrap lines
set wrapscan

" Let's try ignorecase smartcase for searches.
set ignorecase
set smartcase

" Make command line two lines high
set ch=4

" set visual bell -- I hate that damned beeping
set vb

" Make sure that unsaved buffers that are to be put in the background are
" allowed to go in there (i.e. the "must save first" error doesn't come up)
set hidden

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2
" Always display the tabline, even if there is only one tab
" Deactivate it until powerline has a bug.
"set showtabline=2
"set showtabline=1

" Don't update the display while executing macros
set lazyredraw

" Don't show the current command in the lower right corner.  In OSX, if this is
" set and lazyredraw is set then it's slow as molasses, so we unset this
set showcmd

" Show the current mode
set showmode

" Switch on syntax highlighting.
syntax on

" Hide the mouse pointer while typing
set mousehide
set mouse=""

" Highlight the current cursor line
set cursorline

"highlight matching bracket when a new one is inserted
set showmatch

" set the GUI options the way I like
set guioptions=acg

" Setting this below makes it show that error messages don't disappear after one second on startup.
"set debug=msg

" This is the timeout used while waiting for user input on a multi-keyed macro
" or while just sitting and waiting for another key to be pressed measured
" in milliseconds.
"
" i.e. for the ",d" command, there is a "timeoutlen" wait period between the
"      "," key and the "d" key.  If the "d" key isn't pressed before the
"      timeout expires, one of two things happens: The "," command is executed
"      if there is one (which there isn't) or the command aborts.
set timeoutlen=500

" Keep some stuff in the history
set history=100

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" Allow the cursor to go in to "invalid" places
set virtualedit=all

" Make the command-line completion better
set wildmenu
set wildmode=list,full

" Same as default except that I remove the 'u' option
set complete=.,w,b,t

" When completing by tag, show the whole tag, not just the function name
set showfulltag

" get rid of the silly characters in separators
set fillchars=""

" Enable search highlighting
set hlsearch

" Incrementally match the search
set incsearch

" Incrementally match the substitution
set inccommand=nosplit

" Add the unnamed register to the clipboard
set clipboard=unnamedplus

" Automatically read a file that has changed on disk
set autoread

" Trying out the line numbering thing...
set relativenumber

" Types of files to ignore when auto completing things
set wildignore+=GRTAGS,GPATH,GTAGS,*.class,*.gcno,*.gcda,*.git,*.o,*.pyc,*.svn
set wildignore+=*/build/*,*/CMakeFiles/*

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

" Turn off that stupid highlight search
nmap <silent> <LEADER>n :nohls<CR>

" Highlight strings inside C comments
let c_comment_strings=1

" Activate spell-checking as default.
set spell

" Disable arrow keys to get rid of the habit of using them.
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <S-Up> <NOP>
noremap <S-Down> <NOP>
noremap <S-Left> <NOP>
noremap <S-Right> <NOP>
inoremap <S-Up> <NOP>
inoremap <S-Down> <NOP>
inoremap <S-Left> <NOP>
inoremap <S-Right> <NOP>
noremap <C-Up> <NOP>
noremap <C-Down> <NOP>
noremap <C-Left> <NOP>
noremap <C-Right> <NOP>
inoremap <C-Up> <NOP>
inoremap <C-Down> <NOP>
inoremap <C-Left> <NOP>
inoremap <C-Right> <NOP>
noremap <S-C-Up> <NOP>
noremap <S-C-Down> <NOP>
noremap <S-C-Left> <NOP>
noremap <S-C-Right> <NOP>
inoremap <S-C-Up> <NOP>
inoremap <S-C-Down> <NOP>
inoremap <S-C-Left> <NOP>
inoremap <S-C-Right> <NOP>

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Maps to make handling windows a bit easier
noremap <silent> <LEADER>h :wincmd h<CR>
noremap <silent> <LEADER>j :wincmd j<CR>
noremap <silent> <LEADER>k :wincmd k<CR>
noremap <silent> <LEADER>l :wincmd l<CR>
noremap <silent> <LEADER>sb :wincmd p<CR>
noremap <silent> <C-F9>  :vertical resize -10<CR>
noremap <silent> <C-F10> :resize +10<CR>
noremap <silent> <C-F11> :resize -10<CR>
noremap <silent> <C-F12> :vertical resize +10<CR>
noremap <silent> <LEADER>wq :cclose<CR>
noremap <silent> <LEADER>ww :copen<CR>

"Format files.
command! JSONFormat :%!python -m json.tool

" Edit the vimrc file
nmap <silent> <LEADER>ev :e $MYVIMRC<CR>
nmap <silent> <LEADER>sv :so $MYVIMRC<CR>

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048

" I don't like it when the matching parens are automatically highlighted
let loaded_matchparen = 1

if ($OS != 'Windows_NT')
  let g:main_font = "Hack\\ Regular\\ 8"
  let g:small_font = "Hack\\ Regular\\ 4"
else
  let g:main_font = "Courier\\ New\\ 8"
  let g:small_font = "Courier\\ New\\ 4"
endif

"-----------------------------------------------------------------------------
" CtrlP Settings
"-----------------------------------------------------------------------------
let g:ctrlp_switch_buffer = 'E'
let g:ctrlp_tabpage_position = 'c'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_root_markers = ['.git']
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_open_multiple_files = '1ri'
let g:ctrlp_match_window = 'max:40'

noremap <LEADER>b :CtrlPBuffer<cr>
noremap <LEADER>f :CtrlP .<cr>

"-----------------------------------------------------------------------------
" Set up the window colors and size
"-----------------------------------------------------------------------------
colorscheme NeoSolarized
set background=dark

if ($OS != 'Windows_NT')
  "-----------------------------------------------------------------------------
  " Set up YouCompleteMe
  "-----------------------------------------------------------------------------
  "Use tags files
  let g:ycm_collect_identifiers_from_tags_files = 1
  " Close preview after completion.
  let g:ycm_add_preview_to_completeopt = 1
  let g:ycm_autoclose_preview_window_after_insertion = 1
  let g:ycm_confirm_extra_conf = 0
  "Fill location list
  let g:ycm_always_populate_location_list = 1
  let g:ycm_global_ycm_extra_conf = '~/.config/nvim/ycm_extra_conf.py'
  nnoremap <silent> <LEADER>gd :YcmCompleter GetDoc<CR>
  nnoremap <silent> <LEADER>gf :YcmCompleter GoToDefinition<CR>
  nnoremap <silent> <LEADER>gl :YcmCompleter GoToDeclaration<CR>
endif

"-----------------------------------------------------------------------------
" UltiSnip
"-----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger = "<C-J>"
let g:UltiSnipsListSnippets = "<C-K>"
let g:UltiSnipsJumpForwardTrigger = "<C-J>"
let g:UltiSnipsJumpBackwardTrigger = "<C-K>"

"-----------------------------------------------------------------------------
" FSwitch mappings
"-----------------------------------------------------------------------------
nmap <silent> <LEADER>of :FSHere<CR>
nmap <silent> <LEADER>ol :FSRight<CR>
nmap <silent> <LEADER>oL :FSSplitRight<CR>
nmap <silent> <LEADER>oh :FSLeft<CR>
nmap <silent> <LEADER>oH :FSSplitLeft<CR>
nmap <silent> <LEADER>ok :FSAbove<CR>
nmap <silent> <LEADER>oK :FSSplitAbove<CR>
nmap <silent> <LEADER>oj :FSBelow<CR>
nmap <silent> <LEADER>oJ :FSSplitBelow<CR>

"-----------------------------------------------------------------------------
" autocmds
"-----------------------------------------------------------------------------
augroup cppfiles
  au!
  au BufEnter *.h   let b:fswitchdst  = 'cpp'
  au BufEnter *.h   let b:fswitchlocs = 'src/,../src/'
  au BufEnter *.cpp let b:fswitchdst  = 'h'
  au BufEnter *.cpp let b:fswitchlocs = 'include/,../include/'
  au BufEnter *.hxx let b:fswitchdst  = 'cxx'
  au BufEnter *.hxx let b:fswitchlocs = 'src/,../src/'
  au BufEnter *.cxx let b:fswitchdst  = 'hxx'
  au BufEnter *.cxx let b:fswitchlocs = 'include/,../include/'
  au BufWritePre *.h    :Autoformat
  au BufWritePre *.cpp  :Autoformat
  au BufWritePre *.hxx  :Autoformat
  au BufWritePre *.cxx  :Autoformat
augroup END

au BufWritePre * :%s/\s\+$//e
au BufWritePre *.cpp :Autoformat
au BufWritePre *.h :Autoformat
au BufRead,BufNewFile *gitattributes setfiletype gitattributes
au BufRead,BufNewFile *gitconfig* setfiletype gitconfig
au FileType cmake setlocal shiftwidth=2 tabstop=2 softtabstop=2
au Filetype cpp setlocal shiftwidth=4 tabstop=4 softtabstop=4 colorcolumn=120
au Filetype gitattributes setlocal shiftwidth=8 tabstop=8 softtabstop=8 noexpandtab
au Filetype gitcommit setlocal shiftwidth=2 tabstop=2 softtabstop=2
au Filetype gitconfig setlocal shiftwidth=8 tabstop=8 softtabstop=8 noexpandtab
au Filetype go setlocal shiftwidth=8 tabstop=8 softtabstop=8 noexpandtab
au FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType java setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab omnifunc=javacomplete#Complete
au FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4
au FileType markdown setlocal shiftwidth=3 tabstop=3 softtabstop=3
au FileType php setlocal shiftwidth=4 tabstop=4 softtabstop=4
au Filetype qml setlocal shiftwidth=4 tabstop=4 softtabstop=4 colorcolumn=120
au FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType tex setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType text setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType vim setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2 colorcolumn=80
au FileType zsh setlocal shiftwidth=2 tabstop=2 softtabstop=2
au BufNewFile,BufRead CMakeLists.txt set filetype=cmake

au FilterWritePre * if &diff | set wrap | endif

"" Help NeoVim check for modified files: https://github.com/neovim/neovim/issues/2127
autocmd BufEnter,FocusGained * checktime

"-----------------------------------------------------------------------------
" vim-autoformat
"-----------------------------------------------------------------------------
let g:formatters_cpp = ['astyle_cpp', 'clangformat']
let g:formatdef_astyle_cpp = '"astyle --mode=c"'

"-----------------------------------------------------------------------------
" vim-json
"-----------------------------------------------------------------------------
let g:vim_json_syntax_conceal = 0

"-----------------------------------------------------------------------------
" gtags
"-----------------------------------------------------------------------------
function! UpdateGtagsFile()
  if (expand('%:p') =~ getcwd() && (filereadable("GPATH") || filereadable("GRTAGS") || filereadable("GTAGS")))
    exec ":silent !global -q --single-update " . expand('%:p')
  endif
endfunction
autocmd BufWritePost * :call UpdateGtagsFile()

set cscopeprg=gtags-cscope
if has('cscope')
  set cscopetag cscopeverbose
  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

  command! -nargs=0 Cscope cs add GTAGS
  map <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
endif

"-----------------------------------------------------------------------------
" indentLine
"-----------------------------------------------------------------------------
let g:indentLine_char = '┆'

"-----------------------------------------------------------------------------
" delimitMate
"-----------------------------------------------------------------------------
let delimitMate_expand_cr = 1

"-----------------------------------------------------------------------------
" solarized
"-----------------------------------------------------------------------------
let g:solarized_diffmode="high"

"-----------------------------------------------------------------------------
" chromatica
"-----------------------------------------------------------------------------
if ($OS != 'Windows_NT')
  let g:chromatica#libclang_path='/usr/lib/llvm-3.8/lib'
endif
let g:chromatica#enable_at_startup = 1
let g:chromatica#responsive_mode = 1
"let g:chromatica#highlight_feature_level = 1

" Disable one diff window during a three-way diff allowing you to cut out the
" noise of a three-way diff and focus on just the changes between two versions
" at a time. Inspired by Steve Losh's Splice
function! DiffToggle(window)
  " Save the cursor position and turn on diff for all windows
  let l:save_cursor = getpos('.')
  windo :diffthis
  " Turn off diff for the specified window (but keep scrollbind) and move
  " the cursor to the left-most diff window
  exe a:window . "wincmd w"
  diffoff
  set scrollbind
  set cursorbind
  exe a:window . "wincmd " . (a:window == 1 ? "l" : "h")
  " Update the diff and restore the cursor position
  diffupdate
  call setpos('.', l:save_cursor)
endfunction
" Toggle diff view on the left, center, or right windows
nmap <silent> <LEADER>dl :call DiffToggle(1)<CR>
nmap <silent> <LEADER>dc :call DiffToggle(2)<CR>
nmap <silent> <LEADER>dr :call DiffToggle(3)<CR>

if ($OS != 'Windows_NT')
  "-----------------------------------------------------------------------------
  " powerline
  "-----------------------------------------------------------------------------
  python import vim
  python from powerline.vim import setup as powerline_setup
  python powerline_setup(gvars=globals())
  python del powerline_setup
endif
