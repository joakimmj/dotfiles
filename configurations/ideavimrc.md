# .ideavimrc

## Default configuration
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

## My config

### Options

Show line and relative line numbers
``` tangle:~/.ideavimrc
set number
set relativenumber

```

Improve search
``` tangle:~/.ideavimrc
set ignorecase
set smartcase
set hlsearch
set incsearch
```

Other sane defaults
``` tangle:~/.ideavimrc
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set smartindent

set wrap

set scrolloff=8
set signcolumn=yes
set colorcolumn=80

set list
set listchars=tab:» ,trail:.,nbsp:␣
set cursorline
set breakindent
```

Vim modes showing in IDEA
``` tangle:~/.ideavimrc
set showmode
set showcmd
```

Disables bell sound for invalid input
``` tangle:~/.ideavimrc
set visualbell
```

Set leader to be space. Must be done before loading of plugins.
``` tangle:~/.ideavimrc
let mapleader=" "
```

### Plugins

#### vim-highlightedyank

Highlight copied text
``` tangle:~/.ideavimrc
Plug 'machakann/vim-highlightedyank'
```

#### vim-commentary
``` tangle:~/.ideavimrc
Plug 'tpope/vim-commentary'
```

#### vim-surround

Allow deleting/changing/adding 'surroundings'
``` tangle:~/.ideavimrc
Plug 'tpope/vim-surround'
```

#### vim-easymotion

Jump between matches
``` tangle:~/.ideavimrc
Plug 'easymotion/vim-easymotion'
```

#### nerdtree

Open NERDTree with `<leader>wf` (use `q` to quit)
``` tangle:~/.ideavimrc
Plug 'preservim/nerdtree'
map <leader>wf :NERDTreeToggle<CR>
```

#### which-key

Show keymap help menu with `which-key`
``` tangle:~/.ideavimrc
set which-key
set notimeout
set timeoutlen=5000

let g:WhichKey_ShowVimActions = "true"

let g:WhichKeyDesc_workspace = "<leader>w [w]orkspace"
let g:WhichKeyDesc_workspace_files = "<leader>wf [w]orkspace [f]iles"

let g:WhichKeyDesc_idea = "<leader>i IDEA"
let g:WhichKeyDesc_idea_config = "<leader>ic IDEA config"
let g:WhichKeyDesc_idea_config_edit = "<leader>ice [e]dit"
let g:WhichKeyDesc_idea_config_reload = "<leader>icr [r]eload"
let g:WhichKeyDesc_idea_config_actions = "<leader>ica list [a]ctions"
let g:WhichKeyDesc_idea_run = "<leader>ir [r]un"
let g:WhichKeyDesc_idea_debug = "<leader>id [d]ebug"
let g:WhichKeyDesc_idea_mode = "<leader>im Mode"
let g:WhichKeyDesc_idea_mode_zen = "<leader>imz [z]en mode"
let g:WhichKeyDesc_idea_mode_presentation = "<leader>imp [p]resentation mmode"

let g:WhichKeyDesc_previous = "[ Previous"
let g:WhichKeyDesc_previous_method = "[m previous method"
let g:WhichKeyDesc_next = "] Next"
let g:WhichKeyDesc_next_method = "]m next method"

let g:WhichKeyDesc_yank_system = "<leader>y yank to system clipboard"
let g:WhichKeyDesc_yank_line_system = "<leader>Y yank line to system clipboard"
let g:WhichKeyDesc_paste_system = "<leader>p paste from system clipboard"

let g:WhichKeyDesc_document = "<leader>d Document"
let g:WhichKeyDesc_document_replace_word = "<leader>dr [d]ocument [r]eplace word"

let g:WhichKeyDesc_search = "<leader>s Search"
let g:WhichKeyDesc_search_file = "<leader>sf search [f]ile"
let g:WhichKeyDesc_search_grep = "<leader>sg search [g]rep"
let g:WhichKeyDesc_search_recent = "<leader>s. search recent files"

let g:WhichKeyDesc_format = "<leader>f [f]ormat document"

let g:WhichKeyDesc_version_control = "<leader>h Version control [h]unk"
let g:WhichKeyDesc_version_control_blame = "<leader>hb [b]lame"
let g:WhichKeyDesc_version_control_diff = "<leader>hd [d]iff"
let g:WhichKeyDesc_version_control_reset = "<leader>hr [r]eset"
let g:WhichKeyDesc_version_control_status = "<leader>hs [s]tatus"
let g:WhichKeyDesc_version_control_reset_buffer = "<leader>hR [R]eset document"
let g:WhichKeyDesc_version_control_diff_preview = "<leader>hp [p]review diff under cursor"

let g:WhichKeyDesc_lsp = "g LSP"
let g:WhichKeyDesc_lsp_definition = "gd [g]oto [d]efinition"
let g:WhichKeyDesc_lsp_references = "gr [g]oto [r]eferences"
let g:WhichKeyDesc_lsp_implementation = "gI [g]oto [I]mplementation"
let g:WhichKeyDesc_lsp2 = "<leader>g LSP"
let g:WhichKeyDesc_lsp_type_def = "<leader>gt [g]oto [t]ype definition"
let g:WhichKeyDesc_lsp_type_def2 = "<leader>gT [g]oto [T]ype declaration"

let g:WhichKeyDesc_rename = "<leader>r [r]ename"
let g:WhichKeyDesc_rename_rename = "<leader>rn [r]e[n]ame"

let g:WhichKeyDesc_code = "<leader>c [c]ode"
let g:WhichKeyDesc_code_action = "<leader>ca [c]ode [a]ction"
```

### Mappings

IDEA actions
``` tangle:~/.ideavimrc
map <leader>ice :e ~/.ideavimrc<CR>
map <leader>icr :source ~/.ideavimrc<CR>
map <leader>ica <action>(VimFindActionIdAction)
map <leader>ir :action ChooseRunConfiguration<CR>
map <leader>id :action ChooseDebugConfiguration<CR>
map <leader>imz <action>(ToggleFullScreen)<action>(ToggleZenMode)
map <leader>imp <action>(TogglePresentationMode)
```

Stop highlighting search results
``` tangle:~/.ideavimrc
nmap <ESC> :nohlsearch<CR>
```

Move line up/down
``` tangle:~/.ideavimrc
vmap K :m '<-2<CR>gv=gv
vmap J :m '>+1<CR>gv=gv
```

Center cursor on up/down
``` tangle:~/.ideavimrc
nmap <C-u> <C-u>zz
nmap <C-d> <C-d>zz
```

Jump between methods
``` tangle:~/.ideavimrc
map [m <Action>(MethodUp)
map ]m <Action>(MethodDown)
```

Indent and stay in visual mode
``` tangle:~/.ideavimrc
vmap < <gv
vmap > >gv
```

Yank to/paste from system clipboard
``` tangle:~/.ideavimrc
nmap <leader>y "+y
vmap <leader>y "+y
nmap <leader>Y "+Y
nmap <leader>p "+p
```

Replace word under cursor (in document)
``` tangle:~/.ideavimrc
nmap <leader>dr :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
```

Toggle fold (currently not working, but is a merged fix to ideavim, so should be available soon).
``` tangle:~/.ideavimrc
nmap <tab> za
```

Search ("Telescope" replacement)
``` tangle:~/.ideavimrc
map <leader>sf <action>(SearchEverywhere)
map <leader>sg <action>(FindInPath)
map <leader>s. <action>(RecentFiles)
```

Format code
``` tangle:~/.ideavimrc
nmap <leader>f <action>(ReformatCode)
```

Version control
``` tangle:~/.ideavimrc
map <leader>hb <action>(Annotate)
map <leader>hd <action>(ActivateCommitToolWindow)
map <leader>hr <action>(Vcs.RollbackChangedLines)
map <leader>hR ggVG<action>(Vcs.RollbackChangedLines)<ESC><C-t><C-t>zz
map <leader>hp <action>(VcsShowCurrentChangeMarker)
map <leader>hs <action>(ActivateCommitToolWindow)
```

LSP
``` tangle:~/.ideavimrc
nmap gd <action>(GotoDeclaration)
nmap gr <action>(ShowUsages)
nmap gI <action>(GotoImplementation)
nmap <leader>gt <action>(QuickTypeDefinition)
nmap <leader>gT <action>(GotoTypeDeclaration)
nmap <leader>rn <action>(RenameElement)
nmap <leader>ca <action>(ShowIntentionActions)
```

Disable arrow keys to force usage of `hjkl` (in normal mode)
``` tangle:~/.ideavimrc
nmap <Up> <Nop>
nmap <Down> <Nop>
nmap <Left> <Nop>
nmap <Right> <Nop>
```

### Cheatsheet

Adding a tiny cheatsheet on the bottom of the config.
``` tangle:~/.ideavimrc

""" Cheatsheet -----------------------------------------------------------------
" <C-w> h|j|k|l  -> move between windows
" <C-w> v        -> split window vertical
" <C-w> s        -> split window horizontal
" <C-w> c        -> close current window
" <C-w> o        -> close other window
" <C-q>          -> visual block mode
" <Shift-v>      -> visual line mode
" gt             -> next tab
" gT             -> previous tab
" *              -> next occurrence of word under cursor
" #              -> previous occurrence of word under cursor
```

