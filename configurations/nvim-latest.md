# Nvim

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

## General setup

Add Lua settings to configuration folder.
```json tangle:~/.config/nvim-latest/.luarc.json
{
    "runtime": {
        "version": "LuaJIT"
    },
    "diagnostics": {
        "globals": [
            "vim",
            "require"
        ]
    },
    "workspace": {
        "library":  ["$VIMRUNTIME/lua"]
    },
    "telemetry": {
        "enable": false
    }
}
```

Set style rules for our `Lua` files
```toml tangle:~/.config/nvim-latest/.stylua.toml
indent_type = "Spaces"
indent_width = 2
```

### Options

Enable line number
```lua tangle:~/.config/nvim-latest/init.lua
vim.opt.number = true
```

Enable relative line numbers
```lua tangle:~/.config/nvim-latest/init.lua
vim.opt.relativenumber = true
```

Change tab spacing to four spaces
```lua tangle:~/.config/nvim-latest/init.lua
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true
```

Sane defaults
```lua tangle:~/.config/nvim-latest/init.lua
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
```lua tangle:~/.config/nvim-latest/init.lua
-- vim.opt.updatetime = 50 --default 4000
```

Decrease mapped sequence wait time (displays which-key popup sooner)
```lua tangle:~/.config/nvim-latest/init.lua
-- vim.opt.timeoutlen = 300 -- default 1000
```

Configure how new splits should be opened
```lua tangle:~/.config/nvim-latest/init.lua
vim.opt.splitright = true
vim.opt.splitbelow = true
```

Sets how neovim will display certain whitespace characters in the editor.
(See `:help 'list'` and `:help 'listchars'`)
```lua tangle:~/.config/nvim-latest/init.lua
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", leadmultispace = "|   " }
```

Preview substitutions live, as you type!
```lua tangle:~/.config/nvim-latest/init.lua
vim.opt.inccommand = "split"
```

Show which line your cursor is on
```lua tangle:~/.config/nvim-latest/init.lua
vim.opt.cursorline = true
```

Breakindent
```lua tangle:~/.config/nvim-latest/init.lua
vim.opt.breakindent = true
```

Case-insensitive searching UNLESS \C or one or more capital letters in the search term
```lua tangle:~/.config/nvim-latest/init.lua
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
```

Automatic folding based on treesitter
```lua tangle:~/.config/nvim-latest/init.lua
-- TODO: use indent based as default
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
```

Disable default folding when opening file
```lua tangle:~/.config/nvim-latest/init.lua
vim.opt.foldlevelstart = 99
```

### Keymaps

Change `<leader>` to `Space`
```lua tangle:~/.config/nvim-latest/init.lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "
```

Remove highlight from search
```lua tangle:~/.config/nvim-latest/init.lua
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
```

Move line up/down
```lua tangle:~/.config/nvim-latest/init.lua
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "move line up" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "move line down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "move selection up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
```

Better indenting in visual mode
```lua tangle:~/.config/nvim-latest/init.lua
vim.keymap.set("v", "<", "<gv", { desc = "indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "indent right and reselect" })
```

Better J behavior
```lua tangle:~/.config/nvim-latest/init.lua
vim.keymap.set("n", "J", "mzJ`z", { desc = "join lines and keep cursor position" })
```

Toggle line wrap for current buffer
```lua tangle:~/.config/nvim-latest/init.lua
vim.keymap.set("n", "<leader>dw", "<cmd>set wrap!<CR>", { desc = "toggle [w]rap" })
```

Center cursor on up/down
```lua tangle:~/.config/nvim-latest/init.lua
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move cursor up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move cursor down" })
```

Center cursor on next/previous search result
```lua tangle:~/.config/nvim-latest/init.lua
vim.keymap.set("n", "n", "nzzzv", { desc = "next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "previous search result (centered)" })
```

Yank to/paste from system clipboard
```lua tangle:~/.config/nvim-latest/init.lua
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[y]ank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank rest of line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "[p]aste from system clipboard" })
```

Paste from yank register (`"0`)
```lua tangle:~/.config/nvim-latest/init.lua
vim.keymap.set({ "n", "v" }, "<C-p>", "\"0p", { desc = "paste from yank register" })
```

Replace all of word under cursor
```lua tangle:~/.config/nvim-latest/init.lua
vim.keymap.set(
	"n",
	"<leader>dr",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "[r]eplace word" }
)
```

Replace selected text
```lua tangle:~/.config/nvim-latest/init.lua
vim.keymap.set(
	"v",
	"<leader>dr",
	[["hy:%s/<C-r>h//gI<left><left><left>]],
	{ desc = "[r]eplace selected text" }
)
```

Diagnostic keymaps
```lua tangle:~/.config/nvim-latest/init.lua
vim.keymap.set("n", "<leader>dd", vim.diagnostic.setloclist, { desc = "[d]iagnostic (location list)" })
vim.keymap.set("n", "<leader>wd", vim.diagnostic.setqflist, { desc = "[d]iagnostic (quickfix list)" })
```

Location list keymaps
```lua tangle:~/.config/nvim-latest/init.lua
vim.keymap.set("n", "<leader>dj", "<cmd>try | lnext | catch | lfirst | catch | endtry<CR>zz", { desc = "go to next location list entry" })
vim.keymap.set("n", "<leader>dk", "<cmd>try | lprevious | catch | llast | catch | endtry<CR>zz", { desc = "go to previous location list entry" })
vim.keymap.set("n", "<leader>dl", function()
  local loclist_win = vim.fn.getloclist(0, { winid = 0 }).winid
  if loclist_win ~= 0 then
    vim.cmd("botright lclose")
  else
    local status, _ = pcall(vim.cmd, "botright lopen")
    if not status then
      print("Location list is empty")
    end
  end
end, { noremap = true, silent = true, desc = "[l]ocation list toggle" })
```

Quickfix list keymaps
```lua tangle:~/.config/nvim-latest/init.lua
vim.keymap.set("n", "<C-j>", "<cmd>try | cnext | catch | cfirst | catch | endtry<CR>zz", { desc = "go to next quickfix list entry" })
vim.keymap.set("n", "<C-k>", "<cmd>try | cprevious | catch | clast | catch | endtry<CR>zz", { desc = "go to previous quickfix list entry" })
vim.keymap.set("n", "<C-h>", "<cmd>colder<CR>", { desc = "go to previous quickfix list" })
vim.keymap.set("n", "<C-l>", "<cmd>cnewer<CR>", { desc = "go to next quickfix list" })
vim.keymap.set("n", "<leader>q", function()
    local qf_list = vim.fn.getqflist({ winid = 0, size = 0 })
	if qf_list.winid ~= 0 then
		vim.cmd("botright cclose")
	elseif qf_list.size == 0 then
		print("Quickfix list is empty")
	else
		vim.cmd("botright copen")
	end
end, { noremap = true, silent = true, desc = "[q]uickfix list toggle" })
```

Disable arrow keys in normal mode
```lua tangle:~/.config/nvim-latest/init.lua
vim.keymap.set("n", "<left>", "<Nop>")
vim.keymap.set("n", "<right>", "<Nop>")
vim.keymap.set("n", "<up>", "<Nop>")
vim.keymap.set("n", "<down>", "<Nop>")
```

Save/restore vim sessions
```lua tangle:~/.config/nvim-latest/init.lua
vim.keymap.set("n", "<leader>SS", function() vim.cmd([[mksession! .session.vim]]) end, { desc = "[S]ave" })
vim.keymap.set("n", "<leader>SR", function() vim.cmd([[source .session.vim]]) end, { desc = "[R]estore" })
```

### Autocmd

Highlight when yanking (copying) text
```lua tangle:~/.config/nvim-latest/init.lua
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("augroup-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
```

Automatically save session when closing nvim
```lua tangle:~/.config/nvim-latest/init.lua
vim.api.nvim_create_autocmd("VimLeave", {
	desc = "Save session on exit",
	group = vim.api.nvim_create_augroup("augroup-session-manage", { clear = true }),
	callback = function()
		vim.cmd([[silent! mksession! .session.vim]])
	end,
})
```

Reload files when changed on disk
```lua tangle:~/.config/nvim-latest/init.lua
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	desc = "Check if file changed on disk",
	group = vim.api.nvim_create_augroup("augroup-file-disk-status", { clear = true }),
	pattern = { "*" },
	command = "if mode() != 'c' | checktime | endif",
})
```

Add keymaps for executing `Lua` code (for `Lua` buffers only)
```lua tangle:~/.config/nvim-latest/init.lua
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
```lua tangle:~/.config/nvim-latest/init.lua
vim.api.nvim_create_autocmd("FileType", {
	desc = "Json specific options",
	pattern = "json",
	group = vim.api.nvim_create_augroup("augroup-json-options", { clear = true }),
	callback = function()
		vim.keymap.set("n", "<leader>X", [[%!jq '.']], { buffer = true, desc = "e[X]ecute json formatting" })
	end,
})
```

### File explorer
```lua tangle:~/.config/nvim-latest/init.lua
local file_explorer_conf_exists, _ = pcall(require, "file-explorer")
if not file_explorer_conf_exists then
    vim.g.netrw_bufsettings = "noma nomod nu rnu nobl nowrap ro"
    vim.g.netrw_liststyle=3
    vim.g.netrw_browse_split = 0
    vim.g.netrw_banner = 0
    vim.g.netrw_winsize = 25

    vim.keymap.set("n", "<leader>we", ":Lex<CR>", { desc = "[e]xplorer" })
    vim.keymap.set("n", "<leader>wg", [[:vimgrep //j ** | copen<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]], { desc = "[g]rep" })
    vim.keymap.set("n", "<leader>wf", ":Lex<CR>", { desc = "[f]iles" })
    vim.keymap.set("n", "<leader><space>", ":ls<CR>:b<Space>", { desc = "[ ] find existing buffers" })
    vim.keymap.set("n", "<leader>sw", [[:execute "vimgrep /" . expand("<cword>") . "/j **" | cw<CR>]], { desc = "current [w]ord" })
end
```

Setup `Snacks.nvim` for file exploration.
```lua tangle:~/.config/nvim-latest/lua/file-explorer.lua
vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim", load = false },
})

local Snacks = require("snacks")

Snacks.setup({
    picker = {
	ui_select = true,
	layout = {
	    --- Use the default layout or vertical if the window is too narrow
	    preset = function()
		return vim.o.columns >= 120 and "ivy" or "ivy_split"
	    end,
	},
	focus = "input",
	sources = {
	    explorer = {
		layout = {
		    preset = "sidebar",
		    preview = true,
		    layout = {
			width = 80,
		    }
		},
		focus = "list",
	    },
	},
    },
    explorer = {
	replace_netrw = true, -- Replace netrw with the snacks explorer
    },
    indent = {},
})

-- workspace
vim.keymap.set("n", "<leader>we", function() Snacks.picker.explorer() end, { desc = "[e]xplorer" })
vim.keymap.set("n", "<leader>wf", function() Snacks.picker.files({ hidden = true, ignored = true }) end, { desc = "[f]iles" })
vim.keymap.set("n", "<leader>wg", function() Snacks.picker.grep() end, { desc = "[g]rep" })
vim.keymap.set("n", "<leader>ws", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "[s]ymbols" })

-- document
vim.keymap.set("n", "<leader>ds", function() Snacks.picker.lsp_symbols() end, { desc = "[s]ymbols" })

-- search
vim.keymap.set("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "[h]elp" })
vim.keymap.set("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "[m]arks" })
vim.keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "[k]eymaps" })
vim.keymap.set("n", "<leader>sf", function() Snacks.picker.smart({ hidden = true }) end, { desc = "[f]iles" })
vim.keymap.set("n", "<leader>ss", function() Snacks.picker.pickers() end, { desc = "[s]elect picker" })
vim.keymap.set("n", "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "current [w]ord" })
vim.keymap.set("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "[d]iagnostics" })
vim.keymap.set("n", "<leader>sr", function() Snacks.picker.resume() end, { desc = "[r]esume" })
vim.keymap.set("n", "<leader>s.", function() Snacks.picker.recent() end, { desc = "recent files ('.' for repeat)" })
vim.keymap.set("n", "<leader><space>", function() Snacks.picker.buffers() end, { desc = "[ ] find existing buffers" })
vim.keymap.set("n", "<leader>/", function() Snacks.picker.grep({ glob = vim.fn.expand("%:t"), need_search = false }) end, { desc = "[/] fuzzily search in current buffer" })
vim.keymap.set("n", "<leader>s/", function() Snacks.picker.grep_buffers() end, { desc = "[/] open files" })
vim.keymap.set("n", "<leader>sn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config"), hidden = true }) end, { desc = "[n]eovim files" })

-- version control
vim.keymap.set("n", "<leader>vd", function() Snacks.picker.git_diff() end, { desc = "git [d]iff" })
-- vim.keymap.set("n", "<leader>vd", function() Snacks.picker.git_status() end, { desc = "git [d]iff" })
vim.keymap.set("n", "<leader>vo", function() Snacks.gitbrowse() end, { desc = "[o]pen repo destination" })

-- LSP
vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "[g]oto [d]efinition" })
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "[g]oto [r]eferences", nowait = true })
vim.keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "[g]oto [I]mplementation" })
vim.keymap.set("n", "<leader>cgt", function() Snacks.picker.lsp_type_definitions() end, { desc = "[t]ype definition" })

-- scratch (tmp files)
vim.keymap.set("n", "<leader>tt", function() Snacks.scratch() end, { desc = "[t]oggle scratch" })
vim.keymap.set("n", "<leader>ts", function() Snacks.scratch.select() end, { desc = "[s]elect scratch" })
```

## Theme/visual

Load theme module if available

Best builtin themes:
- slate -> a bit to brown
- sorbet -> a bit to purple
- unokai -> a bit to yellow
- vim -> popups in awful pink color
- evening -> a bit popping
- default -> black background

```lua tangle:~/.config/nvim-latest/init.lua
local theme_conf_exists, _ = pcall(require, "theme")
if not theme_conf_exists then
    vim.cmd.colorscheme("vim")
end
```

### Set theme

Add tokyonight theme and adjust some colors
```lua tangle:~/.config/nvim-latest/lua/theme.lua
vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim" },
})

local Theme = require("tokyonight")
Theme.setup({
    on_colors = function(colors)
	colors.bg = "#2E3434"
	colors.comment = "#577466"
	colors.fg_gutter = "#577466"
	colors.bg_statusline = "#374641"
	colors.fg_sidebar = "#374641"
	colors.bg_sidebar = "#2E3434"
    end,
})

-- Set colorscheme
vim.cmd.colorscheme("tokyonight-night")

-- Configure highlights
vim.cmd.hi("ColorColumn guibg=#374641")
```

### Status line

Configure and style status line
```lua tangle:~/.config/nvim-latest/lua/theme.lua
vim.cmd.hi("StatusLine guibg=#A6E3A1 guifg=#374641")
vim.cmd.hi("StatusFlags guibg=#374641 guifg=#A6E3A1")
vim.o.statusline = " %f [%{strlen(&fenc)?&fenc:&enc}] [%{&ff}] %y [%{&spelllang}] [0x%04B] "
    .. "%="
    .. " [%n] %l/%L (%p%%), %c "
    .. "%#StatusFlags#%{&mod?' [+] ':''}%*"
```

### Tab line

Configure and style tab line
```lua tangle:~/.config/nvim-latest/lua/theme.lua
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

vim.cmd.hi("TabLine guibg=#374641 guifg=#577466")
vim.cmd.hi("TabLineSel guibg=#374641 guifg=#A6E3A1")
vim.cmd.hi("TabLineFill guibg=#2E3434")

vim.o.tabline = "%!v:lua.get_tabline()"
```

### Which-key

```lua tangle:~/.config/nvim-latest/lua/theme.lua
vim.pack.add({
	"https://github.com/folke/which-key.nvim",
})

local wk = require("which-key")
wk.setup()

wk.add({
    { "<leader>c",  group = "[c]ode",            mode = { "n", "x" } },
    { "<leader>ct", group = "[t]oggles",         mode = { "n", "x" } },
    { "<leader>cg", group = "[g]oto",            mode = { "n", "x" } },
    { "<leader>d",  group = "[d]ocument" },
    { "<leader>s",  group = "[s]earch" },
    { "<leader>S",  group = "[S]ession" },
    { "<leader>t",  group = "[t]emporary (\"scratch\") files" },
    { "<leader>w",  group = "[w]orkspace" },
    { "<leader>v",  group = "[v]ersion control", mode = { "n", "v" } },
    { "<leader>vt", group = "[t]oggles",         mode = { "n", "v" } },
})
```

## Development environment

```lua tangle:~/.config/nvim-latest/init.lua
local development_conf_exists, _ = pcall(require, "development")
if not development_conf_exists then
    vim.keymap.set("n", "<leader>df", "gg=G", { desc = "[f]ormat" })
end
```

### Treesitter

```lua tangle:~/.config/nvim-latest/lua/development.lua
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

local TS = require("nvim-treesitter")

TS.install({
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
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lang then
      return
    end

    local ok, parsers = pcall(require, "nvim-treesitter.parsers")
    if ok and parsers[lang] then
      TS.install(lang)
      -- TODO: fails if not installed yet
      -- vim.treesitter.start()
      -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      -- vim.wo.foldmethod = "expr"
      -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = TS.get_installed(),
  callback = function(args)
    -- syntax highlighting, provided by Neovim
    vim.treesitter.start()
    -- folds, provided by Neovim
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    -- indentation, provided by nvim-treesitter
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "PackChanged",
	callback = function(ev)
		if ev.data.spec.name == "nvim-treesitter" then
			vim.cmd("TSUpdate")
		end
	end,
})
```

### Git

Add git status in gutter and more
```lua tangle:~/.config/nvim-latest/lua/development.lua
-- add gitsigns.nvim
vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require('gitsigns').setup({
  current_line_blame = true,
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end, { desc = "Jump to next git [c]hange" })

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end, { desc = "Jump to previous git [c]hange" })

    -- visual mode
    map("v", "<leader>va", function()
	    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "git [a]dd selection" })
    map("v", "<leader>vr", function()
	    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "git [r]eset selection" })

    -- normal mode
    map("n", "<leader>va", gitsigns.stage_hunk, { desc = "git [a]dd hunk" })
    map("n", "<leader>vA", gitsigns.stage_buffer, { desc = "git [A]dd buffer" })
    map("n", "<leader>vr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
    map("n", "<leader>vR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })
    map("n", "<leader>vu", gitsigns.undo_stage_hunk, { desc = "git [u]ndo stage hunk" })
    map("n", "<leader>vp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
    map("n", "<leader>vb", function() gitsigns.blame_line({ full = true }) end, { desc = "git [b]lame line" })
    map("n", "<leader>vB", gitsigns.blame, { desc = "git [B]lame buffer" })
    map("n", "<leader>vtb", gitsigns.toggle_current_line_blame, { desc = "show [b]lame line" })
    map('n', '<leader>vq', gitsigns.setqflist, { desc = "add document changes to [q]uickfix list" })
    map('n', '<leader>vQ', function() gitsigns.setqflist("all") end, { desc = "add all changes to [Q]uickfix list" })

  end
})

-- show lines changed in statusline
function _G.get_git_status_tag()
    -- TODO: show if git repo by e.g. using vim.g.gitsigns_head ??
    local git_status = vim.b.gitsigns_status
    if git_status == nil or #git_status == 0 then
        return ""
    end
    return " [" .. git_status .. "] "
end

vim.o.statusline = vim.o.statusline .. "%{%v:lua.get_git_status_tag()%}"
```

### LSP

```lua tangle:~/.config/nvim-latest/lua/development.lua
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
	    "angularls",
	    "bashls",
	    "eslint",
	    "html",
	    "jdtls",
	    "lua_ls",
	    "stylua",
	    "ts_ls",
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			telemetry = {
				enable = false,
			},
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})

-- do not automatically choose first option
vim.cmd("set completeopt+=noselect")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client ~= nil and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

vim.keymap.set("n", "<leader>df", function() vim.lsp.buf.format() end, { desc = "[f]ormat" })
```

### Helpers

```lua tangle:~/.config/nvim-latest/lua/development.lua
vim.pack.add({
	{ src = "https://github.com/norcalli/nvim-colorizer.lua" },
})
```
