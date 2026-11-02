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
- [Writing](#writing)
- [Groups (plugins)](#groups-plugins)
  - [editor](#editor)
  - [theme](#theme)
  - [file-explorer](#file-explorer)
  - [dev](#dev)
  - [tmp](#tmp)

## Generate config

This `Neovim` config can be generated using `md-tangle` with different options.

For a simple configuration without any plugins, just run:
```bash
md-tangle configurations/nvim.md
```

The config is split into logical groups, each living in its own module under
`lua/my/<group>`. Every group that pulls in plugins is tagged:
- `plugins` (all groups below, except `tmp`)
- `editor`
- `theme`
- `file-explorer`
- `dev`
- `tmp` (scratch space for trying out local plugins)

You can include all plugins by running:
```bash
md-tangle configurations/nvim.md -i plugins
```

or cherry-pick the groups you want:
```bash
md-tangle configurations/nvim.md -i editor,theme,file-explorer
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
buffer in [dev/lsp](#lsp))
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
```lua tangle:~/.config/nvim/init.lua
local function group(name, fallback)
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

Prose ergonomics (soft wrap, spell), see [Writing](#writing)
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

## Writing

Neovim as a writing tool: soft wrap + spell for prose filetypes. No plugins, so
this group is always tangled.

Spell files: English ships with the nvim runtime. Norwegian (`nb`) is fetched on
demand by nvim's built-in `spellfile.vim` into `~/.local/share/nvim/site/spell`
the first time `spelllang` includes `nb` (accept the download prompt).

### Prose options

For `markdown`, `text` and `gitcommit` buffers:
- soft wrap at word boundaries, keeping wrapped lines indented
- `textwidth = 80` for `gq`/`gw` reflow, and no `colorcolumn` ruler
- `formatoptions = "qjnl"`: `q` allow `gq` to format, `j` drop comment leader
  on join, `n` recognize numbered lists, `l` don't auto-break long lines while
  typing
- spell for English + Norwegian Bokmål
- `j`/`k` move by display (wrapped) lines, but counts stay linewise (`5j` = 5
  real lines, works with `relativenumber`)
- misspellings published as diagnostics (see [Spell diagnostics](#spell-diagnostics))
```lua tangle:~/.config/nvim/lua/my/writing/init.lua
local spell_diagnostics = require("my.writing.spell-diagnostics")

local group = vim.api.nvim_create_augroup("writing", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "markdown", "text", "gitcommit" },
  callback = function(args)
    local buf = args.buf

    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true

    vim.opt_local.textwidth = 80
    vim.opt_local.colorcolumn = ""

    vim.opt_local.formatoptions = "qjnl"

    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en,nb"

    vim.keymap.set({ "n", "x" }, "j", function()
      return vim.v.count == 0 and "gj" or "j"
    end, { expr = true, buffer = buf, desc = "prose: j by display line" })
    vim.keymap.set({ "n", "x" }, "k", function()
      return vim.v.count == 0 and "gk" or "k"
    end, { expr = true, buffer = buf, desc = "prose: k by display line" })

    spell_diagnostics.attach(buf, group)
  end,
})
```

### Spell diagnostics

Lightweight spell → diagnostics bridge. Native spell (`SpellBad` highlight) has
no gutter/diagnostics, so this publishes misspellings as diagnostics in a
dedicated namespace. They then show up in the sign column, as virtual text and
in the quickfix/location list. It reuses the buffer's `spelllang` dicts, and the
native `SpellBad` highlight stays alongside.

`bad` words are reported as `WARN`, everything else (`rare`, `local`, `caps`) as
`HINT`.
```lua tangle:~/.config/nvim/lua/my/writing/spell-diagnostics.lua
local M = {}

local ns = vim.api.nvim_create_namespace("writing_spell")
local timers = {}

local function refresh(buf)
  if not vim.api.nvim_buf_is_valid(buf) or not vim.b[buf].writing_spell then
    return
  end
  local diags = {}
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  for lnum, line in ipairs(lines) do
    for _, m in ipairs(vim.spell.check(line)) do
      local word, kind, col = m[1], m[2], m[3] -- col is 1-based byte index
      diags[#diags + 1] = {
        lnum = lnum - 1,
        col = col - 1,
        end_col = col - 1 + #word,
        severity = (kind == "bad") and vim.diagnostic.severity.WARN or vim.diagnostic.severity.HINT,
        source = "spell",
        message = ("%s: %s"):format(kind, word),
      }
    end
  end
  vim.diagnostic.set(ns, buf, diags)
end
```

Debounce refreshes (300ms) per buffer
```lua tangle:~/.config/nvim/lua/my/writing/spell-diagnostics.lua
local function schedule(buf)
  if timers[buf] then
    timers[buf]:stop()
  end
  local t = vim.uv.new_timer()
  timers[buf] = t
  t:start(
    300,
    0,
    vim.schedule_wrap(function()
      t:stop()
      t:close()
      timers[buf] = nil
      refresh(buf)
    end)
  )
end
```

Wordlist commands change spelling but don't edit the buffer, so no
`TextChanged` fires. These keys are wrapped to run the native key, then
re-check the buffer. Other buffers pick up the change lazily on `BufEnter`.
(`zg`/`zw`/`zug`/`zuw` persist to the spellfile, `zG`/`zW`/`zuG`/`zuW` are
session-only.)
```lua tangle:~/.config/nvim/lua/my/writing/spell-diagnostics.lua
local wordlist_keys = { "zg", "zw", "zug", "zuw", "zG", "zW", "zuG", "zuW" }
```

Attach the bridge to a buffer. `group` is the augroup the autocmds register
under (shared with the writing `FileType` autocmd). Re-check on text edits
(`TextChanged`/`InsertLeave`) and on `BufEnter` (to pick up wordlist changes
made while another writing buffer was focused).
```lua tangle:~/.config/nvim/lua/my/writing/spell-diagnostics.lua
function M.attach(buf, group)
  vim.b[buf].writing_spell = true

  vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "InsertLeave", "BufEnter" }, {
    group = group,
    buffer = buf,
    callback = function()
      schedule(buf)
    end,
  })

  for _, key in ipairs(wordlist_keys) do
    vim.keymap.set({ "n", "x" }, key, function()
      local count = vim.v.count > 0 and tostring(vim.v.count) or ""
      -- "nx": no-remap + execute now, so the wordlist is updated before refresh.
      vim.api.nvim_feedkeys(count .. key, "nx", false)
      schedule(buf)
    end, { buffer = buf, desc = "spell: " .. key .. " (+refresh diagnostics)" })
  end

  schedule(buf)
end

return M
```

## Groups (plugins)

All plugins are installed with the built-in `vim.pack` (`:h vim.pack`). Pinned
revisions are written to `~/.config/nvim/nvim-pack-lock.json` (generated, not
tangled). Update with `:lua vim.pack.update()`.

### editor
> `tags:plugins,editor`

General editing UX plugins:
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim): git signs in
  the gutter + hunk actions
- [which-key.nvim](https://github.com/folke/which-key.nvim): show pending
  keybinds
- [nvim-colorizer.lua](https://github.com/catgoose/nvim-colorizer.lua): show
  colors in Neovim

Indentation is handled by the global defaults in `init.lua` + Neovim's built-in
EditorConfig support (no `vim-sleuth`).
```lua tangle:~/.config/nvim/lua/my/editor/init.lua tags:plugins,editor
vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/catgoose/nvim-colorizer.lua" },
})
```

#### gitsigns

```lua tangle:~/.config/nvim/lua/my/editor/init.lua tags:plugins,editor
require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  signs_staged = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  signs_staged_enable = true,
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end, { desc = "Jump to next git [c]hange" })

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end, { desc = "Jump to previous git [c]hange" })

    map("v", "<leader>va", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "git [a]dd selection" })
    map("v", "<leader>vr", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "git [r]eset selection" })

    map("n", "<leader>va", gitsigns.stage_hunk, { desc = "git [a]dd hunk" })
    map("n", "<leader>vr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
    map("n", "<leader>vA", gitsigns.stage_buffer, { desc = "git [A]dd buffer" })
    map("n", "<leader>vu", gitsigns.undo_stage_hunk, { desc = "git [u]ndo stage hunk" })
    map("n", "<leader>vR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })
    map("n", "<leader>vp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
    map("n", "<leader>vb", gitsigns.blame_line, { desc = "git [b]lame line" })
    map("n", "<leader>vtb", gitsigns.toggle_current_line_blame, { desc = "show [b]lame line" })
  end,
})
```

#### which-key

The spelling plugin is disabled so which-key doesn't hijack `z=`. Its popup
renders its own suggestion list with divergent numbering (extra/reordered
entries) vs native `z=`, so the key you press selects a different word than
shown.
```lua tangle:~/.config/nvim/lua/my/editor/init.lua tags:plugins,editor
local wk = require("which-key")
wk.setup({
  plugins = {
    spelling = { enabled = false },
  },
  icons = {
    keys = {
      Up = "<Up> ",
      Down = "<Down> ",
      Left = "<Left> ",
      Right = "<Right> ",
      C = "<C-…> ",
      M = "<M-…> ",
      D = "<D-…> ",
      S = "<S-…> ",
      CR = "<CR> ",
      Esc = "<Esc> ",
      ScrollWheelDown = "<ScrollWheelDown> ",
      ScrollWheelUp = "<ScrollWheelUp> ",
      NL = "<NL> ",
      BS = "<BS> ",
      Space = "<Space> ",
      Tab = "<Tab> ",
      F1 = "<F1>",
      F2 = "<F2>",
      F3 = "<F3>",
      F4 = "<F4>",
      F5 = "<F5>",
      F6 = "<F6>",
      F7 = "<F7>",
      F8 = "<F8>",
      F9 = "<F9>",
      F10 = "<F10>",
      F11 = "<F11>",
      F12 = "<F12>",
    },
  },
})
```

Document existing key chains
```lua tangle:~/.config/nvim/lua/my/editor/init.lua tags:plugins,editor
wk.add({
  { "<leader>c", group = "[c]ode", mode = { "n", "x" } },
  { "<leader>ct", group = "[t]oggles", mode = { "n", "x" } },
  { "<leader>cg", group = "[g]oto", mode = { "n", "x" } },
  { "<leader>d", group = "[d]ocument" },
  { "<leader>s", group = "[s]earch" },
  { "<leader>S", group = "[S]ession" },
  { "<leader>t", group = '[t]emporary ("scratch") files' },
  { "<leader>w", group = "[w]orkspace" },
  { "<leader>v", group = "[v]ersion control", mode = { "n", "v" } },
  { "<leader>vt", group = "[t]oggles", mode = { "n", "v" } },
})
```

#### colorizer

```lua tangle:~/.config/nvim/lua/my/editor/init.lua tags:plugins,editor
require("colorizer").setup()
```

### theme
> `tags:plugins,theme`

Load the [redox](https://github.com/joakimmj/redox.nvim) theme. Fallback (if
this group fails) is `colorscheme vim`.
```lua tangle:~/.config/nvim/lua/my/theme/init.lua tags:plugins,theme
vim.pack.add({
  { src = "https://github.com/joakimmj/redox.nvim" },
})

vim.cmd.colorscheme("redox")
vim.keymap.set("n", "<leader>tb", require("redox").toggle_transparency, { desc = "[t]oggle [b]ackground" })
```

### file-explorer
> `tags:plugins,file-explorer`

File navigation + fuzzy pickers via
[snacks.nvim](https://github.com/folke/snacks.nvim). Fallback (if this group
fails) is `netrw`, configured in `init.lua`.

Picker layout is `ivy`, or `ivy_split` if the window is narrower than 120
columns. The explorer is a sidebar with the preview shown inside the sidebar
(clearing `layout.preview`).
```lua tangle:~/.config/nvim/lua/my/file-explorer/init.lua tags:plugins,file-explorer
vim.pack.add({
  { src = "https://github.com/folke/snacks.nvim" },
})

require("snacks").setup({
  picker = {
    ui_select = true,
    layout = {
      preset = function()
        return vim.o.columns >= 120 and "ivy" or "ivy_split"
      end,
    },
    focus = "input",
    sources = {
      explorer = {
        layout = {
          preset = "sidebar",
          layout = {
            width = 80,
          },
          config = function(layout)
            layout.preview = nil
          end,
        },
        focus = "list",
      },
    },
  },
  explorer = {
    replace_netrw = true,
  },
  gitbrowse = {},
  indent = {},
})

local map = vim.keymap.set
```

Workspace
```lua tangle:~/.config/nvim/lua/my/file-explorer/init.lua tags:plugins,file-explorer
map("n", "<leader>we", function()
  Snacks.picker.explorer()
end, { desc = "[e]xplorer" })
map("n", "<leader>wf", function()
  Snacks.picker.files({ hidden = true, ignored = true })
end, { desc = "[f]iles" })
map("n", "<leader>wg", function()
  Snacks.picker.grep()
end, { desc = "[g]rep" })
map("n", "<leader>ws", function()
  Snacks.picker.lsp_workspace_symbols()
end, { desc = "[s]ymbols" })
```

Document
```lua tangle:~/.config/nvim/lua/my/file-explorer/init.lua tags:plugins,file-explorer
map("n", "<leader>ds", function()
  Snacks.picker.lsp_symbols()
end, { desc = "[s]ymbols" })
```

Search
```lua tangle:~/.config/nvim/lua/my/file-explorer/init.lua tags:plugins,file-explorer
map("n", "<leader>sh", function()
  Snacks.picker.help()
end, { desc = "[h]elp" })
map("n", "<leader>sm", function()
  Snacks.picker.marks()
end, { desc = "[m]arks" })
map("n", "<leader>sk", function()
  Snacks.picker.keymaps()
end, { desc = "[k]eymaps" })
map("n", "<leader>sf", function()
  Snacks.picker.smart({ hidden = true })
end, { desc = "[f]iles" })
map("n", "<leader>ss", function()
  Snacks.picker.pickers()
end, { desc = "[s]elect picker" })
map("n", "<leader>sw", function()
  Snacks.picker.grep_word()
end, { desc = "current [w]ord" })
map("n", "<leader>sd", function()
  Snacks.picker.diagnostics()
end, { desc = "[d]iagnostics" })
map("n", "<leader>sr", function()
  Snacks.picker.resume()
end, { desc = "[r]esume" })
map("n", "<leader>s.", function()
  Snacks.picker.recent()
end, { desc = "recent files ('.' for repeat)" })
map("n", "<leader><space>", function()
  Snacks.picker.buffers()
end, { desc = "[ ] find existing buffers" })
map("n", "<leader>/", function()
  Snacks.picker.grep({ glob = vim.fn.expand("%:t"), need_search = false })
end, { desc = "[/] fuzzily search in current buffer" })
map("n", "<leader>s/", function()
  Snacks.picker.grep_buffers()
end, { desc = "[/] open files" })
map("n", "<leader>sn", function()
  Snacks.picker.files({ cwd = vim.fn.stdpath("config"), hidden = true })
end, { desc = "[n]eovim files" })
```

Version control
```lua tangle:~/.config/nvim/lua/my/file-explorer/init.lua tags:plugins,file-explorer
map("n", "<leader>vd", function()
  Snacks.picker.git_status()
end, { desc = "git [d]iff" })
map("n", "<leader>vo", function()
  Snacks.gitbrowse()
end, { desc = "[o]pen repo destination" })
```

LSP navigation
```lua tangle:~/.config/nvim/lua/my/file-explorer/init.lua tags:plugins,file-explorer
map("n", "gd", function()
  Snacks.picker.lsp_definitions()
end, { desc = "[g]oto [d]efinition" })
map("n", "gr", function()
  Snacks.picker.lsp_references()
end, { desc = "[g]oto [r]eferences", nowait = true })
map("n", "gI", function()
  Snacks.picker.lsp_implementations()
end, { desc = "[g]oto [I]mplementation" })
map("n", "<leader>cgt", function()
  Snacks.picker.lsp_type_definitions()
end, { desc = "[t]ype definition" })
```

Scratch (tmp files)
```lua tangle:~/.config/nvim/lua/my/file-explorer/init.lua tags:plugins,file-explorer
map("n", "<leader>tt", function()
  Snacks.scratch()
end, { desc = "[t]oggle scratch" })
map("n", "<leader>ts", function()
  Snacks.scratch.select()
end, { desc = "[s]elect scratch" })
```

### dev
> `tags:plugins,dev`

Neovim as a dev tool: LSP, completion, treesitter, formatting, Lua dev and LSP
UI. Each submodule `vim.pack.add`s the plugins it owns.

`mason` must be loaded first, since it prepends its bin dir to `PATH` (needed
when `vim.lsp.enable()` resolves each server's `cmd`).
```lua tangle:~/.config/nvim/lua/my/dev/init.lua tags:plugins,dev
require("my.dev.mason")
require("my.dev.lsp")
require("my.dev.treesitter")
require("my.dev.formatting")
require("my.dev.lazydev")
require("my.dev.fidget")
```

#### mason

Tool installer ([mason.nvim](https://github.com/mason-org/mason.nvim) +
[mason-tool-installer](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim)).
Installs language servers and formatters into `stdpath("data")/mason` and
prepends its bin dir to `vim.env.PATH`. (On NixOS these come from `neovim.nix`
instead.)

`mason-lspconfig` is deliberately NOT installed: servers are configured by hand
in [lsp](#lsp) (`vim.lsp.config` + `vim.lsp.enable`), and `mason-lspconfig` v2
would fight that by auto-enabling servers itself. The tradeoff is that
`mason-tool-installer` can no longer translate lspconfig server names into
mason package names, so `ensure_installed` uses **mason package names**.

`nixd` is not in the mason registry. Drop a release binary from
[nixd](https://github.com/nix-community/nixd) on `PATH` and [lsp](#lsp) picks
it up automatically. Until then `nixfmt` handles `.nix` files.
```lua tangle:~/.config/nvim/lua/my/dev/mason.lua tags:plugins,dev
vim.pack.add({
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
})

require("mason").setup()

require("mason-tool-installer").setup({
  integrations = { ["mason-lspconfig"] = false },
  ensure_installed = {
    -- language servers
    "lua-language-server",
    "bash-language-server",
    "typescript-language-server",
    "angular-language-server",
    "html-lsp",
    "gopls",
    "basedpyright",
    "ruff",
    -- formatters
    "stylua",
    "prettierd",
    "eslint_d",
    "nixfmt",
    "goimports",
  },
})
```

#### LSP

Native LSP (`vim.lsp.config` + `vim.lsp.enable`).
[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) is kept ONLY as a
data pack of `lsp/*.lua` presets that `vim.lsp.enable()` discovers on the
runtimepath. The `vim.lsp.config()` calls below layer per-server overrides on
top.
```lua tangle:~/.config/nvim/lua/my/dev/lsp.lua tags:plugins,dev
vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
})
```

Snippet navigation for LSP-provided snippets (native `vim.snippet`)
```lua tangle:~/.config/nvim/lua/my/dev/lsp.lua tags:plugins,dev
vim.keymap.set({ "i", "s" }, "<C-l>", function()
  if vim.snippet.active({ direction = 1 }) then
    return vim.snippet.jump(1)
  end
end, { desc = "snippet jump forward" })
vim.keymap.set({ "i", "s" }, "<C-h>", function()
  if vim.snippet.active({ direction = -1 }) then
    return vim.snippet.jump(-1)
  end
end, { desc = "snippet jump backward" })
```

Manually trigger native completion. Other built-in completions: `<C-x><C-o>`
(omni), `<C-x><C-f>` (file system), `<C-x><C-l>` (matching line).
```lua tangle:~/.config/nvim/lua/my/dev/lsp.lua tags:plugins,dev
vim.keymap.set("i", "<C-Space>", function()
  vim.lsp.completion.get()
end, { desc = "trigger completion" })
```

When an LSP attaches to a buffer:
- set buffer-local LSP keymaps
- enable native LSP-driven completion (replaces `nvim-cmp`)
- highlight references of the word under the cursor (on `CursorHold`)
- add toggle for inlay hints, if the server supports them
```lua tangle:~/.config/nvim/lua/my/dev/lsp.lua tags:plugins,dev
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("<leader>wr", vim.lsp.buf.rename, "[r]ename")
    map("<leader>ca", vim.lsp.buf.code_action, "[a]ction", { "n", "x" })
    map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
    map("<leader>cd", function()
      vim.diagnostic.open_float({ scope = "line" })
    end, "show [d]iagnostic")

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
        end,
      })
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map("<leader>cth", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, "inlay [h]ints")
    end
  end,
})
```

Per-server overrides. Empty tables just enable the nvim-lspconfig preset.
- `angularls`: deliberately NO `cmd` override. The preset resolves the ts/ng
  probe locations itself from `exepath("ngserver")` plus the project
  `root_dir`, which is exactly what we want with a mason-installed `ngserver`.
- `basedpyright`: Python types/completion/hover. Finds the project's `.venv`
  through its `pyrightconfig.json` (`venvPath`/`venv`), which also overrides
  these settings.
- `ruff`: Python lint diagnostics + quick fixes. Hover is off, since
  basedpyright's is better.
- `gopls`:
  - `staticcheck`: extra checks (staticcheck's analyzers run inside gopls, no
    separate binary)
  - `gofumpt = false`: stay on plain `gofmt`, which is what projects' `gofmt`
    checks enforce
  - `hints`: only shown when toggled with `<leader>cth`. Handy while learning
    Go's type inference.
```lua tangle:~/.config/nvim/lua/my/dev/lsp.lua tags:plugins,dev
local servers = {
  bashls = {},
  html = {},
  ts_ls = {},
  angularls = {},
  basedpyright = {
    settings = {
      basedpyright = {
        analysis = { typeCheckingMode = "standard" },
      },
    },
  },
  ruff = {
    on_attach = function(client)
      client.server_capabilities.hoverProvider = false
    end,
  },
  gopls = {
    settings = {
      gopls = {
        staticcheck = true,
        analyses = { unusedparams = true, unusedwrite = true, nilness = true, shadow = true },
        gofumpt = false,
        usePlaceholders = true,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          constantValues = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        telemetry = { enable = false },
        completion = { callSnippet = "Replace" },
      },
    },
  },
}
```

`nixd` is not available through mason. Only enable it when the binary is on
`PATH`, so `.nix` buffers stay quiet otherwise.
```lua tangle:~/.config/nvim/lua/my/dev/lsp.lua tags:plugins,dev
if vim.fn.executable("nixd") == 1 then
  servers.nixd = {}
end
```

Register overrides and enable all servers
```lua tangle:~/.config/nvim/lua/my/dev/lsp.lua tags:plugins,dev
for name, cfg in pairs(servers) do
  vim.lsp.config(name, cfg)
end
vim.lsp.enable(vim.tbl_keys(servers))
```

#### treesitter

[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) `main`
branch (the 0.11+ rewrite), used only as a parser installer. Highlighting is
native via `vim.treesitter.start`. The legacy `master` branch is unsupported
on Neovim 0.12 (and crashed on markdown with `node:range()`).

Parsers to install
```lua tangle:~/.config/nvim/lua/my/dev/treesitter.lua tags:plugins,dev
local ENSURE = {
  "bash",
  "c",
  "comment",
  "diff",
  "html",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "query",
  "vim",
  "vimdoc",
  "javascript",
  "typescript",
  "java",
  "nix",
  "json",
  "kotlin",
  "css",
  "go",
  "gomod",
  "gosum",
  "gowork",
  "python",
}
```

Build hook: install/update parsers whenever the plugin itself is installed or
updated by `vim.pack`. Registered BEFORE `vim.pack.add` so it fires on the very
first install.
```lua tangle:~/.config/nvim/lua/my/dev/treesitter.lua tags:plugins,dev
vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("nvim-treesitter-pack", { clear = true }),
  callback = function(ev)
    local d = ev.data
    if d and d.spec and d.spec.name == "nvim-treesitter" and (d.kind == "install" or d.kind == "update") then
      pcall(function()
        require("nvim-treesitter").install(ENSURE)
      end)
    end
  end,
})

vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})
```

Best-effort: install any missing parsers (e.g. after a data wipe where the
plugin is already cloned, so `PackChanged` does not fire)
```lua tangle:~/.config/nvim/lua/my/dev/treesitter.lua tags:plugins,dev
pcall(function()
  local installed = require("nvim-treesitter.config").get_installed("parsers")
  local have = {}
  for _, p in ipairs(installed) do
    have[p] = true
  end
  local missing = vim.tbl_filter(function(lang)
    return not have[lang]
  end, ENSURE)
  if #missing > 0 then
    require("nvim-treesitter").install(missing)
  end
end)
```

The `main` branch does NOT auto-enable highlighting, so start it per buffer
```lua tangle:~/.config/nvim/lua/my/dev/treesitter.lua tags:plugins,dev
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("nvim-treesitter-highlight", { clear = true }),
  pattern = {
    "bash",
    "sh",
    "c",
    "diff",
    "html",
    "lua",
    "markdown",
    "query",
    "vim",
    "help",
    "javascript",
    "typescript",
    "java",
    "nix",
    "json",
    "kotlin",
    "css",
    "go",
    "gomod",
    "gosum",
    "gowork",
    "python",
  },
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})
```

#### formatting

Formatting via [conform.nvim](https://github.com/stevearc/conform.nvim).
`stylua`, `prettierd`, `eslint_d`, `nixfmt`, `goimports` and `ruff` are
installed by [mason](#mason), `jq` comes from the system.

No `format_on_save`: formatting is manual only, via `<leader>df`. For `go`,
`goimports` (= `gofmt` + add/remove imports) is used, with plain `gofmt` (ships
with Go) as fallback.
```lua tangle:~/.config/nvim/lua/my/dev/formatting.lua tags:plugins,dev
vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim" },
})

local conform = require("conform")

conform.setup({
  notify_on_error = false,
  formatters_by_ft = {
    lua = { "stylua" },
    nix = { "nixfmt" },
    go = { "goimports", "gofmt", stop_after_first = true },
    python = { "ruff_organize_imports", "ruff_format" },
    javascript = { "eslint_d", "eslint", "prettierd", "prettier", stop_after_first = true },
    typescript = { "eslint_d", "eslint", "prettierd", "prettier", stop_after_first = true },
  },
})
```

Format code blocks injected in other filetypes (e.g. `json` in markdown)
```lua tangle:~/.config/nvim/lua/my/dev/formatting.lua tags:plugins,dev
conform.formatters.injected = {
  options = {
    lang_to_formatters = {
      json = { "jq" },
    },
    ft_parsers = {
      javascript = "babel",
      javascriptreact = "babel",
      typescript = "typescript",
      typescriptreact = "typescript",
    },
  },
}

vim.keymap.set("", "<leader>df", function()
  conform.format({ async = true, lsp_format = "fallback" })
end, { desc = "[f]ormat" })
```

Draw tabs as indent guides in `Go` buffers. `gofmt` indents with tabs (the
runtime ftplugin sets `noexpandtab`), so render them like `leadmultispace` does
for spaces instead of a `»` on every line.
```lua tangle:~/.config/nvim/lua/my/dev/formatting.lua tags:plugins,dev
vim.api.nvim_create_autocmd("FileType", {
  desc = "Go specific options",
  pattern = "go",
  group = vim.api.nvim_create_augroup("augroup-go-options", { clear = true }),
  callback = function()
    vim.opt_local.listchars:append({ tab = "| " })
  end,
})
```

#### lazydev

[lazydev](https://github.com/folke/lazydev.nvim) configures `lua_ls` for Neovim
config/plugin development (completion, annotations and signatures of the nvim
API). [luvit-meta](https://github.com/Bilal2453/luvit-meta) supplies types for
`vim.uv`, loaded when the word `vim.uv` is found.
```lua tangle:~/.config/nvim/lua/my/dev/lazydev.lua tags:plugins,dev
vim.pack.add({
  { src = "https://github.com/Bilal2453/luvit-meta" },
  { src = "https://github.com/folke/lazydev.nvim" },
})

require("lazydev").setup({
  library = {
    { path = "luvit-meta/library", words = { "vim%.uv" } },
  },
})
```

#### fidget

LSP progress UI ([fidget.nvim](https://github.com/j-hui/fidget.nvim))
```lua tangle:~/.config/nvim/lua/my/dev/fidget.lua tags:plugins,dev
vim.pack.add({
  { src = "https://github.com/j-hui/fidget.nvim" },
})

require("fidget").setup({
  notification = {
    window = {
      winblend = 0,
    },
  },
})
```

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
