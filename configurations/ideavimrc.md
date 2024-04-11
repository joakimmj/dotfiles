# .ideavimrc

## Default
```
" .ideavimrc is a configuration file for IdeaVim plugin. It uses
"   the same commands as the original .vimrc configuration.
" You can find a list of commands here: https://jb.gg/h38q75
" Find more examples here: https://jb.gg/share-ideavimrc


"" -- Suggested options --
" Show a few lines of context around the cursor. Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do incremental searching.
set incsearch

" Don't use Ex mode, use Q for formatting.
map Q gq

" --- Enable IdeaVim plugins https://jb.gg/ideavim-plugins

" Highlight copied text
Plug 'machakann/vim-highlightedyank'
" Commentary plugin
Plug 'tpope/vim-commentary'


"" -- Map IDE actions to IdeaVim -- https://jb.gg/abva4t
"" Map \r to the Reformat Code action
"map \r <Action>(ReformatCode)

"" Map <leader>d to start debug
"map <leader>d <Action>(Debug)

"" Map \b to toggle the breakpoint on the current line
"map \b <Action>(ToggleLineBreakpoint)
```

## WIP
``` tangle:~/.ideavimrc
""" Options --------------------
set showmode
set scrolloff=5
set incsearch
set relativenumber
set number
set hlsearch

set clipboard+=unnamed
"""set clipboard+=unnamedplus

""" Use system clipboard by default for y and p operations
"""nnoremap yy "+yy
"""vnoremap y "+y
"""
"""nnoremap p "+p
"""vnoremap p "+p
"""nnoremap P "+P
"""vnoremap P "+P
"""
"""""" Allow access to original y and p operations with leader key, e.g. to use registers
"""nnoremap <leader>yy yy
"""vnoremap <leader>y y
"""
"""nnoremap <leader>p p
"""vnoremap <leader>p p
"""nnoremap <leader>P P
"""vnoremap <leader>P P
"""
"""""" Allow to cut to system clipboard by using leader key with d
"""nnoremap <leader>dd "+dd
"""vnoremap <leader>d "+d
"""
""" Mappings --------------------
let mapleader = " "

" Ideavim config
nnoremap <leader>ce :e ~/.ideavimrc<CR>
nnoremap <leader>cr :source ~/.ideavimrc<CR>

" IDEA actions
nnoremap <leader><leader> :action SearchEverywhere<CR>

" Format code
nnoremap <leader>f :action ReformatCode<CR>
nnoremap <leader>fr :action RenameElement<CR>

" Version control
nnoremap <leader>va :action Annotate<CR>

" Tabs
" nnoremap <leader>tu :action Annotate<CR> " reopen closes tab

" Copy/Paste
map <leader><C-a> :action $SelectAll<CR>
map <leader><C-c> :action $Copy<CR>
map <leader><C-v> :action $Paste<CR>
map <leader><C-x> :action $Cut<CR>

" Run configurations
nnoremap <leader>r :action Run<CR>
nnoremap <leader>rr :action ChooseRunConfiguration<CR>
nnoremap <leader>rd :action Debug<CR>
nnoremap <leader>rdd :action ChooseDebugConfiguration<CR>

" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
"inoremap <Up> <Nop>
"inoremap <Down> <Nop>
"inoremap <Left> <Nop>
"inoremap <Right> <Nop>

""" Cheatsheet
" <C-w> h|j|k|l  -> move between windows
" <C-w> v        -> split window vertical
" <C-w> s        -> split window horizontal
" <C-w> c        -> close current window
" <C-w> o        -> close other window
" gt             -> next tab
" gT             -> previous tab
" *              -> next occurrence of word under cursor
" #              -> previous occurrence of word under cursor
```