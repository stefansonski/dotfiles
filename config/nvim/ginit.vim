"
" Stefan Sonski's neovim graphical Configuration
"

"-----------------------------------------------------------------------------
" Global Stuff
"-----------------------------------------------------------------------------

" Set font on start
if ($OS == 'Windows_NT')
  GuiFont! Courier New:h8
else
  GuiFont! Hack:h8
endif
