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
  set shell=cmd
endif

Plug 'airblade/vim-gitgutter'
Plug 'icymind/NeoSolarized'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'peterhoeg/vim-qml'
Plug 'sbdchd/neoformat'
Plug 'whiteinge/diffconflicts'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

if ($OS == 'Windows_NT')
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
endif

call plug#end()

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

set completeopt=menuone,noinsert,noselect
" Hide completion messages in command line
set shortmess+=c

" Types of files to ignore when auto completing things
set wildignore+=*.gcno,*.gcda,*.o,*.pyc,*.idx,.cache,.git,build,CMakeFiles,target

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
map <s-insert> <middlemouse>
map! <s-insert> <middlemouse>

" Edit the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<cr>
nmap <silent> <leader>sv :so $MYVIMRC<cr>

au BufWritePre * silent! :undojoin | %s/\s\+$//e
au BufRead,BufNewFile *gitattributes setfiletype gitattributes
au BufRead,BufNewFile *gitconfig* setfiletype gitconfig
au BufRead,BufNewFile *.ts set filetype=xml
au BufWritePre *.c silent! :undojoin | Neoformat clangformat
au BufWritePre *.cpp silent! :undojoin | Neoformat clangformat
au BufWritePre *.h silent! :undojoin | Neoformat clangformat
au Filetype c setlocal shiftwidth=4 tabstop=4 softtabstop=4 colorcolumn=120
au Filetype cpp setlocal shiftwidth=4 tabstop=4 softtabstop=4 colorcolumn=120
au FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
au Filetype gitattributes setlocal shiftwidth=8 tabstop=8 softtabstop=8 noexpandtab
au Filetype gitcommit setlocal shiftwidth=2 tabstop=2 softtabstop=2
au Filetype gitconfig setlocal shiftwidth=8 tabstop=8 softtabstop=8 noexpandtab
au FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4
au FileType markdown setlocal shiftwidth=3 tabstop=3 softtabstop=3
au FileType ps1 setlocal shiftwidth=2 tabstop=2 softtabstop=2
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
" telescope
"-----------------------------------------------------------------------------
nnoremap <leader>ff <cmd>Telescope git_files<cr>
nnoremap <leader>fc <cmd>Telescope git_status<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fd <cmd>lua require'telescope.builtin'.lsp_definitions{}<cr>
nnoremap <leader>fi <cmd>lua require'telescope.builtin'.lsp_implementations{}<cr>
nnoremap <leader>fr <cmd>lua require'telescope.builtin'.lsp_references{}<cr>
nnoremap <leader>fs <cmd>lua require'telescope.builtin'.treesitter{}<cr>

"-----------------------------------------------------------------------------
" lsp
"-----------------------------------------------------------------------------
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  require'completion'.on_attach(client)

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "bashls", "clangd", "cmake", "dockerls", "pyright", "yamlls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

require'lspconfig'.rust_analyzer.setup{
  cmd = { "rustup", "run", "nightly rust-analyzer" },
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  }
}
EOF

"-----------------------------------------------------------------------------
" treesitter
"-----------------------------------------------------------------------------
set foldmethod=expr
set nofoldenable
set foldexpr=nvim_treesitter#foldexpr()
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}
EOF

"-----------------------------------------------------------------------------
" powerline/airline
"-----------------------------------------------------------------------------
if ($OS != 'Windows_NT')
  python import vim
  python from powerline.vim import setup as powerline_setup
  python powerline_setup(gvars=globals())
  python del powerline_setup
else
  let g:airline_powerline_fonts = 1
endif

function IHexChecksum()
  let l:data = getline(".")
  let l:dlen = strlen(data)

  if (empty(matchstr(l:data, "^:\\(\\x\\x\\)\\{5,}$")))
    echoerr("Input is not a valid Intel HEX line!")
    return
  endif

  let l:byte = 0
  for l:bytepos in range(1, l:dlen-4, 2)
    let l:byte += str2nr(strpart(l:data, l:bytepos, 2), 16)
  endfor

  let l:byte = (256-(l:byte%256))%256
  call setline(".", strpart(l:data, 0, l:dlen-2).printf("%02X", l:byte))
endfunction
