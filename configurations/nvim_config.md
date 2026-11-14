---
created: 2025-11-05
tool: nvim
tags: [editor]
---
<!-- SYNAPSES -->
- **down:** [nvim_writing](nvim_writing.md), [nvim_editor](nvim_editor.md), [nvim_theme](nvim_theme.md), [nvim_file_explorer](nvim_file_explorer.md), [nvim_dev](nvim_dev.md)
***
<!-- /SYNAPSES -->

# Nvim

Requires Neovim `0.12+` (plugins are managed by the built-in `vim.pack`).

Install neovim (stable)
```bash
#!/usr/bin/env bash

git clone --branch stable --single-branch --depth 1 https://github.com/neovim/neovim.git
cd neovim
make distclean
make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=~/lib/neovim-stable
make install
cd ..
rm -rf neovim
ln -sf ~/lib/neovim-stable/bin/nvim ~/.local/bin/nvim
```

Install neovim (nightly)
```bash
#!/usr/bin/env bash

git clone --branch nightly --single-branch --depth 1 https://github.com/neovim/neovim.git
cd neovim
make distclean
make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=~/lib/neovim-nightly
make install
cd ..
rm -rf neovim
ln -sf ~/lib/neovim-nightly/bin/nvim ~/.local/bin/nvim-nightly
```

## Table of content

- [Generate config](#generate-config)
- [Lua setup](#lua-setup)
- [Init](#init)
- [Groups (plugins)](#groups-plugins)
  - [tmp](#tmp)

Split into separate files: [writing](nvim_writing.md), [editor](nvim_editor.md),
[theme](nvim_theme.md), [file-explorer](nvim_file_explorer.md), [dev](nvim_dev.md).

## Generate config

This `Neovim` config can be generated using `md-tangle` with different options.

For a simple configuration without any plugins, tangle the core and the
writing group (or run the full config with `NVIM_LITE=1`, see [Groups](#groups)):
```bash
md-tangle configurations/nvim_config.md
md-tangle configurations/nvim_writing.md
```

The config is split into logical groups, each living in its own module under
`lua/my/<group>`. Each plugin group lives in its own file; tangle the ones
you want:
```bash
md-tangle configurations/nvim_editor.md
md-tangle configurations/nvim_theme.md
md-tangle configurations/nvim_file_explorer.md
md-tangle configurations/nvim_dev.md
```

Scratch space for trying out local plugins ([tmp](#tmp)) lives in this file
and is only tangled when the `tmp` tag is included:
```bash
md-tangle configurations/nvim_config.md -i tmp
```

Groups that are not tangled are skipped silently. If the group has a native
fallback, it is applied (with a notification), so `nvim` stays usable.

## Lua setup

### LSP

Configuration of the Lua language server
```json tangle:~/.config/nvim/.luarc.json
{
    "runtime": {
        "version": "LuaJIT"
    },
    "workspace": {
        "checkThirdParty": false
    },
    "telemetry": {
        "enable": false
    }
}
```

### Formatting

Set formatting rules for `StyLua`
```toml tangle:~/.config/nvim/.stylua.toml
indent_type = "Spaces"
indent_width = 2
collapse_simple_statement = "Never"
```

## Init

### Leader

Change `<leader>` to `Space`
```lua tangle:~/.config/nvim/init.lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "
```

### Diagnostics

Diagnostics are shown in a float only:
- `jump.on_jump` opens the float when jumping to a diagnostic (`]d`/`[d`)
- `float.source` always shows which source (LSP, spell, ...) reported it
- `virtual_lines` and `virtual_text` are off by default (toggle below). Use
  `{ current_line = true }` instead of `true` to only show them for the cursor
  line.
```lua tangle:~/.config/nvim/init.lua
vim.diagnostic.config({
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({ bufnr = bufnr })
    end,
  },
  update_in_insert = false,
  float = {
    source = true,
    focusable = false,
    border = "rounded",
    style = "minimal",
  },
  virtual_lines = false,
  virtual_text = false,
})
```

Toggle diagnostics, virtual lines and virtual text
```lua tangle:~/.config/nvim/init.lua
vim.keymap.set("n", "<leader>td", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "[t]oggle [d]iagnostic" })
vim.keymap.set("n", "<leader>tl", function()
  local current = vim.diagnostic.config().virtual_lines or false
  vim.diagnostic.config({ virtual_lines = not current })
end, { desc = "[t]oggle virtual [l]ines" })
vim.keymap.set("n", "<C-w>D", function()
  local current = vim.diagnostic.config().virtual_lines or false
  vim.diagnostic.config({ virtual_lines = not current })
end, { desc = "Toggle diagnostics" })
vim.keymap.set("n", "<leader>tv", function()
  local current = vim.diagnostic.config().virtual_text or false
  vim.diagnostic.config({ virtual_text = not current })
end, { desc = "[t]oggle [v]irtual text" })
```

### Keymaps

Remove highlight from search
```lua tangle:~/.config/nvim/init.lua
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
```

Move line up/down
```lua tangle:~/.config/nvim/init.lua
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "move line up" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "move line down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "move selection up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
```

Better indenting in visual mode
```lua tangle:~/.config/nvim/init.lua
vim.keymap.set("v", "<", "<gv", { desc = "indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "indent right and reselect" })
```

Better J behavior
```lua tangle:~/.config/nvim/init.lua
vim.keymap.set("n", "J", "mzJ`z", { desc = "join lines and keep cursor position" })
```

Toggle line wrap for current buffer
```lua tangle:~/.config/nvim/init.lua
vim.keymap.set("n", "<leader>dw", "<cmd>set wrap!<CR>", { desc = "toggle [w]rap" })
```

Center cursor on up/down
```lua tangle:~/.config/nvim/init.lua
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move cursor up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move cursor down" })
```

Center cursor on next/previous search result
```lua tangle:~/.config/nvim/init.lua
vim.keymap.set("n", "n", "nzzzv", { desc = "next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "previous search result (centered)" })
```

Yank to/paste from system clipboard
```lua tangle:~/.config/nvim/init.lua
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[y]ank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank rest of line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "[p]aste from system clipboard" })
```

Paste from yank register (`"0`)
```lua tangle:~/.config/nvim/init.lua
vim.keymap.set({ "n", "v" }, "<C-p>", '"0p', { desc = "paste from yank register" })
```

Replace all of word under cursor / selected text
```lua tangle:~/.config/nvim/init.lua
vim.keymap.set("n", "<leader>dr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "[r]eplace word" })
vim.keymap.set("v", "<leader>dr", [["hy:%s/<C-r>h//gI<left><left><left>]], { desc = "[r]eplace selected text" })
```

Diagnostic keymaps
```lua tangle:~/.config/nvim/init.lua
vim.keymap.set("n", "<leader>dd", vim.diagnostic.setloclist, { desc = "[d]iagnostic (location list)" })
vim.keymap.set("n", "<leader>wd", vim.diagnostic.setqflist, { desc = "[d]iagnostic (quickfix list)" })
```

Quickfix list keymaps
```lua tangle:~/.config/nvim/init.lua
vim.keymap.set(
  "n",
  "<c-j>",
  "<cmd>try | cnext | catch | cfirst | catch | endtry<cr>zz",
  { desc = "go to next quickfix list entry" }
)
vim.keymap.set(
  "n",
  "<c-k>",
  "<cmd>try | cprevious | catch | clast | catch | endtry<cr>zz",
  { desc = "go to previous quickfix list entry" }
)
vim.keymap.set("n", "<C-h>", "<cmd>colder<CR>", { desc = "go to previous quickfix list" })
vim.keymap.set("n", "<C-l>", "<cmd>cnewer<CR>", { desc = "go to next quickfix list" })
vim.keymap.set("n", "<leader>q", function()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  local action = qf_winid > 0 and "cclose" or "copen"
  vim.cmd("botright " .. action)
end, { noremap = true, silent = true, desc = "[q]uickfix list toggle" })
```

`:Make` runs `:make` (with args) and sends the output to the quickfix list,
without jumping to the first error or showing a hit-enter prompt. The quickfix
window only opens when it has entries.
```lua tangle:~/.config/nvim/init.lua
vim.api.nvim_create_user_command("Make", function(opts)
  vim.cmd("silent make! " .. opts.args)
  vim.cmd("redraw!")
  vim.cmd("botright cwindow")
end, { nargs = "*", complete = "file", desc = "make → quickfix" })
```

Disable arrow keys in normal mode
```lua tangle:~/.config/nvim/init.lua
vim.keymap.set("n", "<left>", "<Nop>")
vim.keymap.set("n", "<right>", "<Nop>")
vim.keymap.set("n", "<up>", "<Nop>")
vim.keymap.set("n", "<down>", "<Nop>")
```

Save/restore vim sessions
```lua tangle:~/.config/nvim/init.lua
vim.keymap.set("n", "<leader>SS", function()
  vim.cmd([[mksession! .session.vim]])
end, { desc = "[S]ave" })
vim.keymap.set("n", "<leader>SR", function()
  vim.cmd([[source .session.vim]])
end, { desc = "[R]estore" })
```

### Options

Enable line number
```lua tangle:~/.config/nvim/init.lua
vim.opt.number = true
```

Enable relative line numbers
```lua tangle:~/.config/nvim/init.lua
vim.opt.relativenumber = true
```

Change tab spacing to four spaces. Neovim's built-in EditorConfig support
overrides this per project.
```lua tangle:~/.config/nvim/init.lua
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
```

Sane defaults
```lua tangle:~/.config/nvim/init.lua
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.colorcolumn = "80,120"

vim.opt.isfname:append("@-@")
```

Decrease update time
```lua tangle:~/.config/nvim/init.lua
vim.opt.updatetime = 50
```

Decrease mapped sequence wait time (displays which-key popup sooner)
```lua tangle:~/.config/nvim/init.lua
vim.opt.timeoutlen = 300
```

Configure how new splits should be opened
```lua tangle:~/.config/nvim/init.lua
vim.opt.splitright = true
vim.opt.splitbelow = true
```

Sets how neovim will display certain whitespace characters in the editor.
(See `:help 'list'` and `:help 'listchars'`)
```lua tangle:~/.config/nvim/init.lua
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", leadmultispace = "|   " }
```

Preview substitutions live, as you type!
```lua tangle:~/.config/nvim/init.lua
vim.opt.inccommand = "split"
```

Show which line your cursor is on
```lua tangle:~/.config/nvim/init.lua
vim.opt.cursorline = true
```

Breakindent
```lua tangle:~/.config/nvim/init.lua
vim.opt.breakindent = true
```

Case-insensitive searching UNLESS \C or one or more capital letters in the search term
```lua tangle:~/.config/nvim/init.lua
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
```

Automatic folding based on treesitter (native `vim.treesitter.foldexpr`)
```lua tangle:~/.config/nvim/init.lua
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
```

Disable default folding when opening file
```lua tangle:~/.config/nvim/init.lua
vim.opt.foldlevelstart = 99
```

### Autocmd

Highlight when yanking (copying) text
```lua tangle:~/.config/nvim/init.lua
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("augroup-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
```

Automatically save session when closing nvim
```lua tangle:~/.config/nvim/init.lua
vim.api.nvim_create_autocmd("VimLeave", {
  desc = "Save session on exit",
  group = vim.api.nvim_create_augroup("augroup-session-manage", { clear = true }),
  callback = function()
    vim.cmd([[silent! mksession! .session.vim]])
  end,
})
```

Reload files when changed on disk
```lua tangle:~/.config/nvim/init.lua
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  desc = "Check if file changed on disk",
  group = vim.api.nvim_create_augroup("augroup-file-disk-status", { clear = true }),
  pattern = { "*" },
  command = "if mode() != 'c' | checktime | endif",
})
```

Add keymaps for executing `Lua` code (for `Lua` buffers only)
```lua tangle:~/.config/nvim/init.lua
vim.api.nvim_create_autocmd("FileType", {
  desc = "Lua specific options",
  pattern = "lua",
  group = vim.api.nvim_create_augroup("augroup-lua-options", { clear = true }),
  callback = function()
    vim.keymap.set("n", "<leader>X", "<cmd>source %<CR>", { buffer = true, desc = "e[X]ecute lua file" })
    vim.keymap.set("n", "<leader>x", ":.lua<CR>", { buffer = true, desc = "e[x]ecute lua line" })
    vim.keymap.set("v", "<leader>x", ":lua<CR>", { buffer = true, desc = "e[x]ecute lua selection" })
  end,
})
```

Add keymaps for formatting `JSON` (for `json` buffers only)
```lua tangle:~/.config/nvim/init.lua
vim.api.nvim_create_autocmd("FileType", {
  desc = "Json specific options",
  pattern = "json",
  group = vim.api.nvim_create_augroup("augroup-json-options", { clear = true }),
  callback = function()
    vim.keymap.set("n", "<leader>X", "<cmd>%!jq '.'<CR>", { buffer = true, desc = "e[X]ecute json formatting" })
  end,
})
```

### Tabline

```lua tangle:~/.config/nvim/init.lua
function _G.get_tabline()
  local s = ""
  for tabnr = 1, vim.fn.tabpagenr("$") do
    local winnr = vim.fn.tabpagewinnr(tabnr)
    local buflist = vim.fn.tabpagebuflist(tabnr)[winnr]
    local bufname = vim.fn.bufname(buflist)
    local bufname_short = vim.fn.fnamemodify(bufname, ":t")
    if #bufname_short == 0 then
      bufname_short = "[No Name]"
    end
    if tabnr == vim.fn.tabpagenr() then
      s = s .. "%#TabLineSel#"
    else
      s = s .. "%#TabLine#"
    end
    s = s .. " " .. tabnr .. ": " .. bufname_short .. " "
  end
  s = s .. "%#TabLineFill#"
  return s
end

vim.o.tabline = "%!v:lua.get_tabline()"
```

### Statusline

```lua tangle:~/.config/nvim/init.lua
vim.o.statusline = " %f [%{strlen(&fenc)?&fenc:&enc}] [%{&ff}] %y [%{&spelllang}] [0x%04B] "
  .. "%="
  .. " [%n] %l/%L (%p%%), %c "
  .. "%#StatusLineNC#%{&mod?' [+] ':''}%*"
```

### Completion

Options for native insert-mode completion (`vim.lsp.completion`, enabled per
buffer in [dev/lsp](nvim_dev.md#lsp))
```lua tangle:~/.config/nvim/init.lua
vim.o.completeopt = "menuone,noselect,noinsert,fuzzy,popup"
```

### Groups

The config is split into logical groups (neovim as an editor, as a dev tool, as
a writing tool, ...). Each group module `vim.pack.add`s the plugins it owns.

If a group fails to load, the optional native fallback keeps nvim usable:
- group module missing (not tangled): silent, but notify if a fallback is used
- any other error (config error, plugin missing, ...): always notify

Only a missing *group* module counts as "missing". A missing module inside the
group (e.g. a plugin `require`) is reported as an error.

Set `NVIM_LITE=1` to skip every plugin group and apply its fallback silently
(`writing` has no plugins, so it always loads). This is what the `vim` alias
uses for a fast, plugin-free editor.
```lua tangle:~/.config/nvim/init.lua
local lite = (vim.env.NVIM_LITE or "") ~= ""

local function group(name, fallback)
  if lite and name ~= "writing" then
    if fallback then
      fallback()
    end
    return
  end

  local mod = "my." .. name
  local ok, err = pcall(require, mod)
  if ok then
    return
  end

  err = tostring(err)
  local missing = err:find(("module '%s' not found"):format(mod), 1, true) ~= nil
  local msg
  if not missing then
    msg = ("%s failed: %s"):format(mod, err)
  elseif fallback then
    msg = ("%s not found, using fallback"):format(mod)
  end
  if msg then
    vim.schedule(function()
      vim.notify(msg, vim.log.levels.WARN)
    end)
  end

  if fallback then
    fallback()
  end
end
```

General editing UX (git signs, which-key, colorizer)
```lua tangle:~/.config/nvim/init.lua
group("editor")
```

Prose ergonomics (soft wrap, spell), see [writing](nvim_writing.md)
```lua tangle:~/.config/nvim/init.lua
group("writing")
```

Theme, with the built-in `vim` colorscheme as fallback
```lua tangle:~/.config/nvim/init.lua
group("theme", function()
  vim.cmd.colorscheme("vim")
end)
```

File explorer and pickers, with `netrw` + `vimgrep` as fallback
```lua tangle:~/.config/nvim/init.lua
group("file-explorer", function()
  vim.g.netrw_bufsettings = "noma nomod nu rnu nobl nowrap ro"
  vim.g.netrw_liststyle = 3
  vim.g.netrw_browse_split = 0
  vim.g.netrw_banner = 0
  vim.g.netrw_winsize = 25

  vim.keymap.set("n", "<leader>we", ":Lex<CR>", { desc = "[e]xplorer" })
  vim.keymap.set(
    "n",
    "<leader>wg",
    [[:vimgrep //j ** | copen<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]],
    { desc = "[g]rep" }
  )
  vim.keymap.set("n", "<leader>wf", ":Lex<CR>", { desc = "[f]iles" })
  vim.keymap.set("n", "<leader><space>", ":ls<CR>:b<Space>", { desc = "[ ] find existing buffers" })
  vim.keymap.set(
    "n",
    "<leader>sw",
    [[:execute "vimgrep /" . expand("<cword>") . "/j **" | cw<CR>]],
    { desc = "current [w]ord" }
  )
end)
```

Dev tooling, with re-indenting the whole buffer as fallback formatter
```lua tangle:~/.config/nvim/init.lua
group("dev", function()
  vim.keymap.set("n", "<leader>df", "gg=G", { desc = "[f]ormat" })
end)
```

Scratch space for local plugins (see [tmp](#tmp))
```lua tangle:~/.config/nvim/init.lua tags:tmp
group("tmp")
```

## Groups (plugins)

All plugins are installed with the built-in `vim.pack` (`:h vim.pack`). Pinned
revisions are written to `~/.config/nvim/nvim-pack-lock.json` (generated, not
tangled). Update with `:lua vim.pack.update()`.

Each group lives in its own file:
- [editor](nvim_editor.md)
- [theme](nvim_theme.md)
- [file-explorer](nvim_file_explorer.md)
- [dev](nvim_dev.md)

### tmp
> `tags:tmp`

Scratch space for trying out plugins under development. Plugins are loaded
from a local directory by prepending it to the runtimepath (no `vim.pack`), and
their help tags are generated. A missing directory gives a warning and returns
`false`, so the setup can be guarded.

Uncomment and adjust the example to load a local plugin.
```lua tangle:~/.config/nvim/lua/my/tmp/init.lua tags:tmp
---@param dir string
---@return boolean loaded
local function add_local(dir)
  local path = vim.fn.expand(dir)
  if vim.fn.isdirectory(path) == 1 then
    vim.opt.rtp:prepend(path)
    pcall(vim.cmd.helptags, path .. "/doc")
    return true
  end
  vim.schedule(function()
    vim.notify("local plugin not found: " .. path, vim.log.levels.WARN)
  end)
  return false
end

-- if add_local("~/dev/nvim-plugins/my-plugin.nvim") then
--   require("my-plugin").setup({})
-- end
```
