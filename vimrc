"
" Stefan Sonski's Vim Configuration
"
" It's got stuff in it.
"

"-----------------------------------------------------------------------------
" Global Stuff
"-----------------------------------------------------------------------------
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle '/usr/share/vim/addons/'

NeoBundle 'vim-scripts/UltiSnips'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'elzr/vim-json'
NeoBundle 'Valloric/YouCompleteMe',
  \ {
  \   'build' :
  \   {
  \     'unix' : './install.py --clang-completer --system-libclang --system-boost'
  \   }
  \ }
NeoBundle 'stefansonski/vim-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'derekwyatt/vim-fswitch'
NeoBundle 'derekwyatt/vim-protodef'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'rhysd/vim-clang-format'
NeoBundle 'bruno-/vim-man.git'
NeoBundle 'wincent/command-t',
  \ {
  \   'build' :
  \   {
  \     'unix' : 'cd ./ruby/command-t && make clean && ruby extconf.rb && make'
  \   }
  \ }
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'Yggdroot/indentLine'

call neobundle#end()

" Fix issues for YouCompleteMe installation because of a timeout, it just takes
" really long to fetch all submodules and build it
let g:neobundle#install_process_timeout = 1500

" Set filetype stuff to on
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" Set tab and indent options
set expandtab
set autoindent

" Printing options
set printoptions=header:0,duplex:long,paper:letter

" set the search scan to wrap lines
set wrapscan

" Let's try ignorecase smartcase for searches.
set ignorecase
set smartcase

" set the forward slash to be the slash of note.  Backslashes suck
set shellslash
if has("unix")
  set shell=bash
else
  set shell=ksh.exe
endif

" Make command line two lines high
set ch=4

" set visual bell -- I hate that damned beeping
set vb

" Allow backspacing over indent, EOL, and the start of an insert
set backspace=2

" Make sure that unsaved buffers that are to be put in the background are
" allowed to go in there (i.e. the "must save first" error doesn't come up)
set hidden

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
set cpoptions=ces$

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2
" Always display the tabline, even if there is only one tab
" Deactivate it until powerline has a bug.
"set showtabline=2
set showtabline=1
" Hide the default mode text (e.g. -- INSERT -- below the status line)
set noshowmode

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

" Set up the GUI cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor
set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

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

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
set foldmethod=syntax
set foldlevelstart=20

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" Allow the cursor to go in to "invalid" places
set virtualedit=all

" Disable encryption (:X)
set key=

" Make the command-line completion better
set wildmenu
set wildmode=list,full

" Same as default except that I remove the 'u' option
set complete=.,w,b,t

" When completing by tag, show the whole tag, not just the function name
set showfulltag

" Set the colorcolumn to textwidth +1
set colorcolumn=+1

" get rid of the silly characters in separators
set fillchars=""

" Add ignorance of whitespace to diff
set diffopt+=iwhite

" Enable search highlighting
set hlsearch

" Incrementally match the search
set incsearch

" Add the unnamed register to the clipboard
set clipboard=unnamedplus

" Automatically read a file that has changed on disk
set autoread

set grepprg=grep\ -nH\ $*

" Remove trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

" Trying out the line numbering thing...
set relativenumber

" Types of files to ignore when auto completing things
set wildignore+=*.o,*.class,*.git,*.svn,*/CMakeFiles/*,*/sources/*,*/installation_files/*,*/rootfs/*,*/alphaEOS_BIN/*
set wildignore+=*/Arduino/*,*/installation/*,*/binsources/*,*/build/*,*/Demos/*,*/Dokumentation/*,*/DotNet/*,GRTAGS
set wildignore+=GPATH,GTAGS

" Create backup, swap and undo directory if it does not exist
if !isdirectory($HOME . "/.vim/swp")
  call mkdir($HOME . "/.vim/swp", "p")
endif
if !isdirectory($HOME . "/.vim/undo")
  call mkdir($HOME . "/.vim/undo", "p")
endif

" Set backup, swap and undo directories.
set directory=~/.vim/swp//,/tmp

set undofile
set undodir=~/.vim/undo//,/tmp
set undolevels=1000
set undoreload=10000

" System default for mappings is now the "," character
let mapleader = ","

" Turn off that stupid highlight search
nmap <silent> <LEADER>n :nohls<CR>

" Highlight strings inside C comments
let c_comment_strings=1

" Load up the doxygen syntax
let g:load_doxygen_syntax=1

" Let the syntax highlighting for Java files allow cpp keywords
let java_allow_cpp_keywords = 1

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

let g:main_font = "Hack\\ Regular\\ 8"
let g:small_font = "Hack\\ Regular\\ 4"

"-----------------------------------------------------------------------------
" command-t Settings
"-----------------------------------------------------------------------------
let g:CommandTMatchWindowReverse = 1

noremap <LEADER>b :CommandTBuffer<cr>
noremap <LEADER>f :CommandT .<cr>

"-----------------------------------------------------------------------------
" Gundo Settings
"-----------------------------------------------------------------------------
nmap <c-F5> :GundoToggle<cr>

"-----------------------------------------------------------------------------
" Set up the window colors and size
"-----------------------------------------------------------------------------
colorscheme solarized
set background=dark
if has("gui_running")
  exe "set guifont=" . g:main_font
endif

"-----------------------------------------------------------------------------
" Set up YouCompleteMe
"-----------------------------------------------------------------------------
"Use tags files
let g:ycm_collect_identifiers_from_tags_files = 1
" Close preview after completion.
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0

"-----------------------------------------------------------------------------
" UltiSnip
"-----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger = "<C-J>"
let g:UltiSnipsListSnippets = "<C-K>"
let g:UltiSnipsJumpForwardTrigger = "<C-J>"
let g:UltiSnipsJumpBackwardTrigger = "<C-K>"

"-----------------------------------------------------------------------------
" Tagbar
"-----------------------------------------------------------------------------
nnoremap <leader>tt :TagbarToggle<CR>

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
  au BufEnter *.h   let b:fswitchlocs = '../,../src/,src/,../source/,source/'
  au BufEnter *.cpp let b:fswitchdst  = 'h'
  au BufEnter *.cpp let b:fswitchlocs = 'include/,../include,../'
augroup END
autocmd Filetype cpp setlocal shiftwidth=4 tabstop=4 softtabstop=4 textwidth=120
autocmd FileType cmake setlocal shiftwidth=2 tabstop=2 softtabstop=2 textwidth=120
autocmd FileType vim setlocal shiftwidth=2 tabstop=2 softtabstop=2 textwidth=120
autocmd Filetype gitcommit setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2 textwidth=80
autocmd FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2 textwidth=80
autocmd FileType markdown setlocal shiftwidth=3 tabstop=3 softtabstop=3 textwidth=80
autocmd BufNewFile,BufRead CMakeLists.txt set filetype=cmake

"-----------------------------------------------------------------------------
" clang_format
"-----------------------------------------------------------------------------
let g:clang_format#detect_style_file = 1

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

  cnoreabbrev csa cs add
  cnoreabbrev csf cs find
  cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset
  cnoreabbrev css cs show
  cnoreabbrev csh cs help

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
