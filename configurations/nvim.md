# Nvim

## Init

Import my configurations
``` tangle:~/.config/nvim/init.lua
require("my.mappings")
require("my.options")
require("my.netrw")
```

## Options
Enable line number
``` tangle:~/.config/nvim/lua/my/options.lua
vim.opt.number = true
```

Enable relative line numbers
``` tangle:~/.config/nvim/lua/my/options.lua
vim.opt.relativenumber = true
```

Change tab spacing to four spaces
``` tangle:~/.config/nvim/lua/my/options.lua
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
```

``` tangle:~/.config/nvim/lua/my/options.lua
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
```

## Keymaps

Change `<leader>` to `Space`
``` tangle:~/.config/nvim/lua/my/mappings.lua
vim.g.mapleader = " "
```

Add binding for going to Netrw
``` tangle:~/.config/nvim/lua/my/mappings.lua
vim.keymap.set("n", "<leader>pv", function() vim.cmd("Ex") end)
```

## Netrw

``` tangle:~/.config/nvim/lua/my/netrw.lua
vim.g.netrw_bufsettings="noma nomod nu nobl nowrap ro"
```
