"
" Derek Wyatt's Vim Configuration
"
" It's got stuff in it.
"

"-----------------------------------------------------------------------------
" Global Stuff
"-----------------------------------------------------------------------------

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'vim-scripts/UltiSnips'
Plugin 'yegappan/lid'
Plugin 'bling/vim-airline'
Plugin 'vim-scripts/bufkill.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'sjl/gundo.vim'
Plugin 'elzr/vim-json'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Valloric/YouCompleteMe'
Plugin 'stefansonski/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

if $GIT_DIR != ""
  let dirs = split(&rtp, ',')
  let cleaned = filter(dirs, 'v:val !~ "vim-indexer"')
  let &rtp = join(cleaned, ',')
  unlet dirs cleaned
endif

" Set filetype stuff to on
filetype on
filetype plugin on
filetype indent on

" Tabstops are 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

" Printing options
set printoptions=header:0,duplex:long,paper:letter

" set the search scan to wrap lines
set wrapscan

" I'm happy to type the case of things.  I tried the ignorecase, smartcase
" thing but it just wasn't working out for me
set noignorecase

" set the forward slash to be the slash of note.  Backslashes suck
set shellslash
if has("unix")
  set shell=bash
else
  set shell=ksh.exe
endif

" Make command line two lines high
set ch=4

" set visual bell -- i hate that damned beeping
set vb

" Allow backspacing over indent, eol, and the start of an insert
set backspace=2

" Make sure that unsaved buffers that are to be put in the background are
" allowed to go in there (ie. the "must save first" error doesn't come up)
set hidden

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
set cpoptions=ces$

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2

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

" Set up the gui cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

" set the gui options the way I like
set guioptions=acg

" Setting this below makes it sow that error messages don't disappear after one second on startup.
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

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" Allow the cursor to go in to "invalid" places
set virtualedit=all

" Disable encryption (:X)
set key=

" Make the command-line completion better
set wildmenu

" Same as default except that I remove the 'u' option
set complete=.,w,b,t

" When completing by tag, show the whole tag, not just the function name
set showfulltag

" Set the textwidth to be 80 chars
set colorcolumn=120

" get rid of the silly characters in separators
set fillchars = ""

" Add ignorance of whitespace to diff
set diffopt+=iwhite

" Enable search highlighting
set hlsearch

" Incrementally match the search
set incsearch

" Add the unnamed register to the clipboard
set clipboard+=unnamed

" Automatically read a file that has changed on disk
set autoread

set grepprg=grep\ -nH\ $*

" Remove trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

" Trying out the line numbering thing... never liked it, but that doesn't mean
" I shouldn't give it another go :)
set relativenumber

" Types of files to ignore when autocompleting things
set wildignore+=*.o,*.class,*.git,*.svn,*/CMakeFiles/*,*/alphaBoxOS/*,*/alphaEOS_BIN/*,*/Arduino/*,*/Build_Tools/*,*/Demos/*,*/Dokumentation/*,*/DotNet/*

" Various characters are "wider" than normal fixed width characters, but the
" default setting of ambiwidth (single) squeezes them into "normal" width, which
" sucks.  Setting it to double makes it awesome.
"set ambiwidth=double

" OK, so I'm gonna remove the VIM safety net for a while and see if kicks my ass
set nobackup
set nowritebackup
set noswapfile

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

" The following beast is something i didn't write... it will return the
" syntax highlighting group that the current "thing" under the cursor
" belongs to -- very useful for figuring out what to change as far as
" syntax highlighting goes.
nmap <silent> <LEADER>qq :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" set text wrapping toggles
nmap <silent> <LEADER>ww :set invwrap<CR>

" Maps to make handling windows a bit easier
"noremap <silent> <LEADER>h :wincmd h<CR>
"noremap <silent> <LEADER>j :wincmd j<CR>
"noremap <silent> <LEADER>k :wincmd k<CR>
"noremap <silent> <LEADER>l :wincmd l<CR>
"noremap <silent> <LEADER>sb :wincmd p<CR>
noremap <silent> <C-F9>  :vertical resize -10<CR>
noremap <silent> <C-F10> :resize +10<CR>
noremap <silent> <C-F11> :resize -10<CR>
noremap <silent> <C-F12> :vertical resize +10<CR>
noremap <silent> <LEADER>cc :close<CR>
noremap <silent> <LEADER>cq :cclose<CR>
noremap <silent> <LEADER>cw :copen<CR>

"Make indent work in normal and visual mode and unindent in insert mode possible.
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Edit the vimrc file
nmap <silent> <LEADER>ev :e $MYVIMRC<CR>
nmap <silent> <LEADER>sv :so $MYVIMRC<CR>

" Use the bufkill plugin to eliminate a buffer but keep the window layout
nmap <LEADER>bd :BD<cr>

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048

" I don't like it when the matching parens are automatically highlighted
let loaded_matchparen = 1

let g:main_font = "Inconsolata\\ for\\ Powerline\\ 11"
let g:small_font = "Inconsolata\\ for\\ Powerline\\ 4"

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

nmap <LEADER>fb :CtrlPBuffer<cr>
nmap <LEADER>ff :CtrlP .<cr>
nmap <LEADER>fF :execute ":CtrlP " . expand('%:p:h')<cr>
nmap <LEADER>fr :CtrlP<cr>
nmap <LEADER>fm :CtrlPMixed<cr>

"-----------------------------------------------------------------------------
" Gundo Settings
"-----------------------------------------------------------------------------
nmap <c-F5> :GundoToggle<cr>

"-----------------------------------------------------------------------------
" Shortcuts
"-----------------------------------------------------------------------------
nnoremap <silent> <C-Home> :enew<CR>
nnoremap <silent> <C-PageDown> :bn<CR>
nnoremap <silent> <C-PageUp> :bp<CR>
nnoremap <silent> <C-End> :BD<CR>

vnoremap <silent> <C-S-y> "+y
vnoremap <silent> <C-S-p> "+p

function! HighlightAllOfWord(onoff)
  if a:onoff == 1
    :augroup highlight_all
    :au!
    :au CursorMoved * silent! exe printf('match Search /\<%s\>/', expand('<cword>'))
    :augroup END
  else
    :au! highlight_all
    match none /\<%s\>/
  endif
endfunction

:nmap <LEADER>ha :call HighlightAllOfWord(1)<cr>
:nmap <LEADER>hA :call HighlightAllOfWord(0)<cr>

"-----------------------------------------------------------------------------
" Set up the window colors and size
"-----------------------------------------------------------------------------
if has("gui_running")
  exe "set guifont=" . g:main_font
  set lines=999 columns=999
  set background=dark
  colorscheme solarized
endif
:nohls

"-----------------------------------------------------------------------------
" Set up YouCompleteMe
"-----------------------------------------------------------------------------
let g:ycm_global_ycm_extra_conf = '$HOME/.vim/ycm_global_extra_conf'
let g:ycm_extra_conf_globlist = ['~/alphaeosdev*/*','!~/*']
nmap <C-D> :YcmCompleter GoToDefinitionElseDeclaration<CR>
"Close preview after completion.
let g:ycm_autoclose_preview_window_after_completion=1

"-----------------------------------------------------------------------------
" UltiSnip
"-----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<C-J>"
let g:UltiSnipsJumpForwardTrigger="<C-B>"
let g:UltiSnipsJumpBackwardTrigger="<C-Z>"

"-----------------------------------------------------------------------------
" Find words recursively under the cursor
"-----------------------------------------------------------------------------
nnoremap <silent> <F4> :Lid <C-R><C-W><CR>
nmap <C-F> <ESC>:Lid<SPACE>

"-----------------------------------------------------------------------------
" TToC mapping
"-----------------------------------------------------------------------------
map <C-T> :TToC<CR>

"-----------------------------------------------------------------------------
" Ariline config
"-----------------------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
"Use fancy fonts
let g:airline_powerline_fonts = 1
