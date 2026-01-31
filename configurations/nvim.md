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

## Lua setup
> `~/.config/nvim/.luarc.json`, `~/.config/nvim-lite/.luarc.json`

Add Lua settings to configuration folder.
```json tangle:~/.config/nvim/.luarc.json,~/.config/nvim-lite/.luarc.json
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
```toml tangle:~/.config/nvim/.stylua.toml,~/.config/nvim-lite/.stylua.toml
indent_type = "Spaces"
indent_width = 2
```

```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
-- TODO: make fullscreen floating window with current buffer?? :thinking
-- vim.keymap.set("n", "<leader>wz", function ()
--     local ls = vim.opt.laststatus:get()
--     if ls == 0 then
--         vim.opt.laststatus = 2
--         vim.opt.cmdheight = 1
--     else
--         vim.opt.laststatus = 0
--         vim.opt.cmdheight = 0
--     end
-- end, { desc = "[z]en mode" })
--
-- -- In init.lua
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   callback = function()
--     vim.opt_local.textwidth = 80 -- Set max width
--     vim.opt_local.formatoptions:append("a") -- Auto-format paragraphs
--   end,
-- })
```

## Init
> `~/.config/nvim/init.lua`, `~/.config/nvim-lite/init.lua`

Import my configurations
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
require("my.theme")
```

### Keymaps

Change `<leader>` to `Space`
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "
```

Remove highlight from search
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
```

Move line up/down
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "move line up" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "move line down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "move selection up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
```

Better indenting in visual mode
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.keymap.set("v", "<", "<gv", { desc = "indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "indent right and reselect" })
```

Better J behavior
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.keymap.set("n", "J", "mzJ`z", { desc = "join lines and keep cursor position" })
```

Toggle line wrap for current buffer
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.keymap.set("n", "<leader>dw", "<cmd>set wrap!<CR>", { desc = "toggle [w]rap" })
```

Center cursor on up/down
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move cursor up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move cursor down" })
```

Center cursor on next/previous search result
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.keymap.set("n", "n", "nzzzv", { desc = "next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "previous search result (centered)" })
```

Yank to/paste from system clipboard
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[y]ank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank rest of line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "[p]aste from system clipboard" })
```

Paste from yank register (`"0`)
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.keymap.set({ "n", "v" }, "<C-p>", "\"0p", { desc = "paste from yank register" })
```

Replace all of word under cursor
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.keymap.set(
	"n",
	"<leader>dr",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "[r]eplace word" }
)
```

Replace selected text
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.keymap.set(
	"v",
	"<leader>dr",
	[["hy:%s/<C-r>h//gI<left><left><left>]],
	{ desc = "[r]eplace selected text" }
)
```

Diagnostic keymaps
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.keymap.set("n", "<leader>dd", vim.diagnostic.setloclist, { desc = "[d]iagnostic (location list)" })
vim.keymap.set("n", "<leader>wd", vim.diagnostic.setqflist, { desc = "[d]iagnostic (quickfix list)" })
```

Quickfix list keymaps
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.keymap.set("n", "<C-j>", "<cmd>try | cnext | catch | cfirst | catch | endtry<CR>zz", { desc = "go to next quickfix list entry" })
vim.keymap.set("n", "<C-k>", "<cmd>try | cprevious | catch | clast | catch | endtry<CR>zz", { desc = "go to previous quickfix list entry" })
vim.keymap.set("n", "<C-h>", "<cmd>colder<CR>", { desc = "go to previous quickfix list" })
vim.keymap.set("n", "<C-l>", "<cmd>cnewer<CR>", { desc = "go to next quickfix list" })
vim.keymap.set("n", "<leader>q", function()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  local action = qf_winid > 0 and "cclose" or "copen"
  vim.cmd("botright " .. action)
end, { noremap = true, silent = true, desc = "[q]uickfix list toggle" })
```

Disable arrow keys in normal mode
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.keymap.set("n", "<left>", "<Nop>")
vim.keymap.set("n", "<right>", "<Nop>")
vim.keymap.set("n", "<up>", "<Nop>")
vim.keymap.set("n", "<down>", "<Nop>")
```

Save/restore vim sessions
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.keymap.set("n", "<leader>SS", function() vim.cmd([[mksession! .session.vim]]) end, { desc = "[S]ave" })
vim.keymap.set("n", "<leader>SR", function() vim.cmd([[source .session.vim]]) end, { desc = "[R]estore" })
```

### Options

Enable line number
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.opt.number = true
```

Enable relative line numbers
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.opt.relativenumber = true
```

Change tab spacing to four spaces
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
```

Sane defaults
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
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
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.opt.updatetime = 50
-- vim.opt.updatetime = 50 -- default: 4000
```

Decrease mapped sequence wait time (displays which-key popup sooner)
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.opt.timeoutlen = 300
-- vim.opt.timeoutlen = 300 -- default: 1000
```

Configure how new splits should be opened
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.opt.splitright = true
vim.opt.splitbelow = true
```

Sets how neovim will display certain whitespace characters in the editor.
(See `:help 'list'` and `:help 'listchars'`)
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", leadmultispace = "|   " }
```

Preview substitutions live, as you type!
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.opt.inccommand = "split"
```

Show which line your cursor is on
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.opt.cursorline = true
```

Breakindent
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.opt.breakindent = true
```

Case-insensitive searching UNLESS \C or one or more capital letters in the search term
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
```

Automatic folding based on treesitter
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
```

Disable default folding when opening file
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.opt.foldlevelstart = 99
```

### Autocmd

Highlight when yanking (copying) text
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("augroup-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
```

Automatically save session when closing nvim
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.api.nvim_create_autocmd("VimLeave", {
	desc = "Save session on exit",
	group = vim.api.nvim_create_augroup("augroup-session-manage", { clear = true }),
	callback = function()
		vim.cmd([[silent! mksession! .session.vim]])
	end,
})
```

Reload files when changed on disk
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	desc = "Check if file changed on disk",
	group = vim.api.nvim_create_augroup("augroup-file-disk-status", { clear = true }),
	pattern = { "*" },
	command = "if mode() != 'c' | checktime | endif",
})
```

Add keymaps for executing `Lua` code (for `Lua` buffers only)
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.api.nvim_create_autocmd('FileType', {
	desc = 'Lua specific options',
	pattern = 'lua',
	group = vim.api.nvim_create_augroup('augroup-lua-options', { clear = true }),
	callback = function()
		vim.keymap.set("n", "<leader>X", "<cmd>source %<CR>", { buffer = true, desc = "e[X]ecute lua file" })
		vim.keymap.set("n", "<leader>x", ":.lua<CR>", { buffer = true, desc = "e[x]ecute lua line" })
		vim.keymap.set("v", "<leader>x", ":lua<CR>", { buffer = true, desc = "e[x]ecute lua selection" })
	end,
})
```

Add keymaps for formatting `JSON` (for `json` buffers only)
```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
vim.api.nvim_create_autocmd('FileType', {
	desc = 'Json specific options',
	pattern = 'json',
	group = vim.api.nvim_create_augroup('augroup-json-options', { clear = true }),
	callback = function()
		vim.keymap.set("n", "<leader>X", [[%!jq '.']], { buffer = true, desc = "e[X]ecute json formatting" })
	end,
})
```

### Lite vs. plugins

```lua tangle:~/.config/nvim/init.lua,~/.config/nvim-lite/init.lua
local use_lazy_packages, _ = pcall(require, "my.init-lazy")
if not use_lazy_packages then
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

## Lazy (plugins)
> `~/.config/nvim/lua/my/init-lazy.lua`

Init `lazy.nvim`
```lua tangle:~/.config/nvim/lua/my/init-lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = "my.plugins",
	change_detection = { notify = false },
})
```

### general
> `~/.config/nvim/lua/my/plugins/general.lua`

General plugins
```lua tangle:~/.config/nvim/lua/my/plugins/general.lua
return {
```

Detect tabstop and shiftwidth automatically
```lua tangle:~/.config/nvim/lua/my/plugins/general.lua
	"tpope/vim-sleuth",
```

Show colors in Neovim
```lua tangle:~/.config/nvim/lua/my/plugins/general.lua
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
```

```lua tangle:~/.config/nvim/lua/my/plugins/general.lua
}
```

### autocompletion
> `~/.config/nvim/lua/my/plugins/autocomplete.lua`

```lua tangle:~/.config/nvim/lua/my/plugins/autocomplete.lua
return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://muithub.com/rafamadriz/friendly-snippets
					-- {
					--   'rafamadriz/friendly-snippets',
					--   config = function()
					--     require('luasnip.loaders.from_vscode').lazy_load()
					--   end,
					-- },
				},
			},
			"saadparwaiz1/cmp_luasnip",

			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({
					-- Select the [n]ext item
					["<C-n>"] = cmp.mapping.select_next_item(),
					-- Select the [p]revious item
					["<C-p>"] = cmp.mapping.select_prev_item(),

					-- Scroll the documentation window [b]ack / [f]orward
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- Accept ([y]es) the completion.
					--  This will auto-import if your LSP supports it.
					--  This will expand snippets if the LSP sent a snippet.
					["<C-y>"] = cmp.mapping.confirm({ select = true }),

					-- If you prefer more traditional completion keymaps,
					-- you can uncomment the following lines
					--['<CR>'] = cmp.mapping.confirm { select = true },
					--['<Tab>'] = cmp.mapping.select_next_item(),
					--['<S-Tab>'] = cmp.mapping.select_prev_item(),

					-- Manually trigger a completion from nvim-cmp.
					--  Generally you don't need this, because nvim-cmp will display
					--  completions whenever it has completion options available.
					["<C-Space>"] = cmp.mapping.complete({}),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),

					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				}),
				sources = {
					{
						name = "lazydev",
						-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
						group_index = 0,
					},
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})
		end,
	},
}
```

### formatting
> `~/.config/nvim/lua/my/plugins/formatting.lua`

```lua tangle:~/.config/nvim/lua/my/plugins/formatting.lua
return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>df",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[f]ormat",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = "never"
				else
					lsp_format_opt = "fallback"
				end
				return {
					timeout_ms = 500,
					lsp_format = lsp_format_opt,
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use 'stop_after_first' to run the first available formatter from the list
				javascript = { "eslint_d", "eslint", "prettierd", "prettier", stop_after_first = true },
				typescript = { "eslint_d", "eslint", "prettierd", "prettier", stop_after_first = true },
			},
		},
		config = function()
			require("conform").formatters.injected = {
				-- Set the options field
				options = {
					-- Set individual option values
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
		end,
	},
}
```

### gitsigns.nvim
> `~/.config/nvim/lua/my/plugins/gitsigns.lua`

Adds git related signs to the gutter, as well as utilities for managing changes
```lua tangle:~/.config/nvim/lua/my/plugins/gitsigns.lua
return {
	"lewis6991/gitsigns.nvim",
	opts = {
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

			-- Navigation
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

			-- visual mode
			map("v", "<leader>va", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "git [a]dd selection" })
			map("v", "<leader>vr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "git [r]eset selection" })

			-- normal mode
			map("n", "<leader>va", gitsigns.stage_hunk, { desc = "git [a]dd hunk" })
			map("n", "<leader>vr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
			map("n", "<leader>vA", gitsigns.stage_buffer, { desc = "git [A]dd buffer" })
			map("n", "<leader>vu", gitsigns.undo_stage_hunk, { desc = "git [u]ndo stage hunk" })
			map("n", "<leader>vR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })
			map("n", "<leader>vp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
			map("n", "<leader>vb", gitsigns.blame_line, { desc = "git [b]lame line" })
			map("n", "<leader>vtb", gitsigns.toggle_current_line_blame, { desc = "show [b]lame line" })
		end,
	},
}
```

### LSP
> `~/.config/nvim/lua/my/plugins/lsp.lua`

```lua tangle:~/.config/nvim/lua/my/plugins/lsp.lua
return {
	{ "nvim-java/nvim-java" },
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- Allows extra capabilities provided by nvim-cmp
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- Brief aside: **What is LSP?**
			--
			-- LSP is an initialism you've probably heard, but might not understand what it is.
			--
			-- LSP stands for Language Server Protocol. It's a protocol that helps editors
			-- and language tooling communicate in a standardized fashion.
			--
			-- In general, you have a "server" which is some tool built to understand a particular
			-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
			-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
			-- processes that communicate with some "client" - in this case, Neovim!
			--
			-- LSP provides Neovim with features like:
			--  - Go to definition
			--  - Find references
			--  - Autocompletion
			--  - Symbol Search
			--  - and more!
			--
			-- Thus, Language Servers are external tools that must be installed separately from
			-- Neovim. This is where `mason` and related plugins come into play.
			--
			-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
			-- and elegantly composed help section, `:help lsp-vs-treesitter`

			--  This function gets run when an LSP attaches to a particular buffer.
			--    That is to say, every time a new file is opened that is associated with
			--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
			--    function will be executed to configure the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- NOTE: Remember that Lua is a real programming language, and as such it is possible
					-- to define small helper and utility functions so you don't have to repeat yourself.
					--
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("<leader>wr", vim.lsp.buf.rename, "[r]ename")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "[a]ction", { "n", "x" })

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")

					map("<leader>cd", function()
						vim.diagnostic.open_float({ scope = 'line' })
					end, "show [d]iagnostic")
					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
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

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>cth", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "inlay [h]ints")
					end
				end,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				-- clangd = {},
				-- gopls = {},
				-- pyright = {},
				-- rust_analyzer = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`ts_ls`) will work just fine
				ts_ls = {},
				--
				kotlin_language_server = {},
				jdtls = {},
				lua_ls = {
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
				},
			}

			-- Must be setup before jdtls server is setup
			require("java").setup()

			-- Ensure the servers and tools above are installed
			--  To check the current status of installed tools and/or manually install
			--  other tools, you can run
			--    :Mason
			--
			--  You can press `g?` for help in this menu.
			require("mason").setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
```

### snacks.nvim
> `~/.config/nvim/lua/my/plugins/snacks.lua`

```lua tangle:~/.config/nvim/lua/my/plugins/snacks.lua
return {
    {
        "folke/snacks.nvim",
        lazy = false,
        ---@type snacks.Config
        opts = {
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
            gitbrowse = {},
            indent = {},
        },
        keys = {
            -- workspace
            { "<leader>we",      function() Snacks.picker.explorer() end,                                                 desc = "[e]xplorer" },
            { "<leader>wf",      function() Snacks.picker.files({ hidden = true, ignored = true }) end,                   desc = "[f]iles" },
            { "<leader>wg",      function() Snacks.picker.grep() end,                                                     desc = "[g]rep" },
            { "<leader>ws",      function() Snacks.picker.lsp_workspace_symbols() end,                                    desc = "[s]ymbols" },

            -- document
            { "<leader>ds",      function() Snacks.picker.lsp_symbols() end,                                              desc = "[s]ymbols" },

            -- search
            { "<leader>sh",      function() Snacks.picker.help() end,                                                     desc = "[h]elp" },
            { "<leader>sm",      function() Snacks.picker.marks() end,                                                    desc = "[m]arks" },
            { "<leader>sk",      function() Snacks.picker.keymaps() end,                                                  desc = "[k]eymaps" },
            { "<leader>sf",      function() Snacks.picker.smart({ hidden = true }) end,                                   desc = "[f]iles" },
            { "<leader>ss",      function() Snacks.picker.pickers() end,                                                  desc = "[s]elect picker" },
            { "<leader>sw",      function() Snacks.picker.grep_word() end,                                                desc = "current [w]ord" },
            { "<leader>sd",      function() Snacks.picker.diagnostics() end,                                              desc = "[d]iagnostics" },
            { "<leader>sr",      function() Snacks.picker.resume() end,                                                   desc = "[r]esume" },
            { "<leader>s.",      function() Snacks.picker.recent() end,                                                   desc = "recent files ('.' for repeat)" },
            { "<leader><space>", function() Snacks.picker.buffers() end,                                                  desc = "[ ] find existing buffers" },
            { "<leader>/",       function() Snacks.picker.grep({ glob = vim.fn.expand("%:t"), need_search = false }) end, desc = "[/] fuzzily search in current buffer" },
            { "<leader>s/",      function() Snacks.picker.grep_buffers() end,                                             desc = "[/] open files" },
            { "<leader>sn",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config"), hidden = true }) end,   desc = "[n]eovim files" },

            -- version control
            { "<leader>vd",      function() Snacks.picker.git_status() end,                                               desc = "git [d]iff" },
            { "<leader>vo",      function() Snacks.gitbrowse() end,                                                       desc = "[o]pen repo destination" },

            -- LSP
            { "gd",              function() Snacks.picker.lsp_definitions() end,                                          desc = "[g]oto [d]efinition" },
            { "gr",              function() Snacks.picker.lsp_references() end,                                           desc = "[g]oto [r]eferences",                 nowait = true },
            { "gI",              function() Snacks.picker.lsp_implementations() end,                                      desc = "[g]oto [I]mplementation" },
            { "<leader>cgt",     function() Snacks.picker.lsp_type_definitions() end,                                     desc = "[t]ype definition" },

            -- scratch (tmp files)
            { "<leader>tt",      function() Snacks.scratch() end,                                                         desc = "[t]oggle scratch" },
            { "<leader>ts",      function() Snacks.scratch.select() end,                                                  desc = "[s]elect scratch" },
        },
    }
}
```

### treesitter
> `~/.config/nvim/lua/my/plugins/treesitter.lua`

Highlight, edit, and navigate code
```lua tangle:~/.config/nvim/lua/my/plugins/treesitter.lua
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs", -- Sets main module to use for opts
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		opts = {
			ensure_installed = {
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
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	},
}
```

### which-key
> `~/.config/nvim/lua/my/plugins/which-key.lua`

Useful plugin to show you pending keybinds.
```lua tangle:~/.config/nvim/lua/my/plugins/which-key.lua
return {
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	opts = {
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

		-- Document existing key chains
		spec = {
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
		},
	},
}
```

## Theme
> `~/.config/nvim/lua/my/theme.lua`, `~/.config/nvim-lite/lua/my/theme.lua`

Color palette
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
local redox = {
    bg = "#2E3434",
    bg_alt = "#343A3A",
    surface = "#3A4141",
    overlay = "#414949",
    fg = "#DCE8E5",
    muted = "#AFC3BE",
    subtle = "#919D9B",
    rust = "#CD8B64",
    orange = "#E3A36F",
    teal = "#7EC1AE",
    sea = "#9FD8C4",
    cyan = "#8FC7B7",
    amber = "#D6C38A",
    red = "#CD8980",
    warn = "#E3B86F",
    info = "#8EC6C4",
    hint = "#98C3B1",
    cursor = "#FFD7A0",
    selection = "#3F4A4A",
}
```

Set options for new theme
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.opt.termguicolors = true
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end
vim.g.colors_name = "redox"
```

### Highlight groups

#### Core UI

```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "Normal", { fg = redox.fg, bg = redox.bg })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = redox.fg, bg = redox.bg_alt })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = redox.overlay, bg = redox.bg_alt })
```

Line numbers / cursorline / columns
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "LineNr", { fg = redox.subtle, bg = "NONE" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#323838" })
vim.api.nvim_set_hl(0, "CursorColumn", { link = "CursorLine" })
vim.api.nvim_set_hl(0, "ColorColumn", { link = "CursorLine" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = redox.orange, bold = true })
```

Statusline / tabline
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "StatusLine", { fg = redox.bg, bg = redox.orange, bold = true })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = redox.muted, bg = redox.surface })
vim.api.nvim_set_hl(0, "TabLine", { link = "StatusLineNC" })
vim.api.nvim_set_hl(0, "TabLineSel", { link = "StatusLine" })
vim.api.nvim_set_hl(0, "TabLineFill", { link = "Normal" })
```

Splits / borders
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "VertSplit", { fg = redox.overlay })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = redox.overlay })
```

Selection / popup menu
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "Visual", { bg = redox.selection })
vim.api.nvim_set_hl(0, "Pmenu", { fg = redox.fg, bg = redox.surface })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = redox.bg, bg = redox.orange })
vim.api.nvim_set_hl(0, "PmenuSbar", { bg = redox.surface })
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = redox.overlay })
```

Search / matching
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "Search", { fg = redox.bg, bg = redox.teal })
vim.api.nvim_set_hl(0, "IncSearch", { fg = redox.bg, bg = redox.rust })
vim.api.nvim_set_hl(0, "CurSearch", { fg = redox.bg, bg = redox.rust })
vim.api.nvim_set_hl(0, "MatchParen", { fg = redox.orange, underline = true })
```

Invisible characters / misc UI
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "NonText", { fg = redox.subtle })
vim.api.nvim_set_hl(0, "SpecialKey", { fg = redox.overlay })
vim.api.nvim_set_hl(0, "Whitespace", { fg = redox.overlay })
vim.api.nvim_set_hl(0, "SignColumn", { fg = redox.muted, bg = redox.bg })
vim.api.nvim_set_hl(0, "Folded", { fg = redox.muted, bg = redox.surface })
vim.api.nvim_set_hl(0, "FoldColumn", { fg = redox.subtle, bg = redox.bg })
```

Titles / directories / prompts and messages
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "Title", { fg = redox.orange, bold = true, underline = true })
vim.api.nvim_set_hl(0, "Directory", { fg = redox.teal })
vim.api.nvim_set_hl(0, "WildMenu", { link = "PmenuSel" })
vim.api.nvim_set_hl(0, "ModeMsg", { link = "Normal" })
vim.api.nvim_set_hl(0, "MoreMsg", { fg = redox.teal })
vim.api.nvim_set_hl(0, "ErrorMsg", { link = "DiagnosticError" })
vim.api.nvim_set_hl(0, "WarningMsg", { link = "DiagnosticWarn" })
```

#### Syntax

```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "@comment", { fg = redox.subtle, italic = true })
vim.api.nvim_set_hl(0, "Todo", { bg = redox.hint, fg = redox.bg, bold = true })
vim.api.nvim_set_hl(0, "@comment.todo", { link = "Todo" })
vim.api.nvim_set_hl(0, "@keyword", { fg = redox.orange, bold = true })
vim.api.nvim_set_hl(0, "@conditional", { fg = redox.orange })
vim.api.nvim_set_hl(0, "@function", { fg = redox.teal })
vim.api.nvim_set_hl(0, "@method", { link = "@function" })
vim.api.nvim_set_hl(0, "@type", { fg = redox.amber })
vim.api.nvim_set_hl(0, "@type.builtin", { fg = redox.amber })
vim.api.nvim_set_hl(0, "@constant", { fg = redox.amber })
vim.api.nvim_set_hl(0, "@string", { fg = redox.sea })
vim.api.nvim_set_hl(0, "@number", { link = "@constant" })
vim.api.nvim_set_hl(0, "@boolean", { link = "@constant" })
vim.api.nvim_set_hl(0, "@operator", { fg = "#C9D4D2" })
vim.api.nvim_set_hl(0, "@field", { fg = "#CFE3DE" })
vim.api.nvim_set_hl(0, "@property", { link = "@field" })
vim.api.nvim_set_hl(0, "@variable", { fg = redox.fg })
vim.api.nvim_set_hl(0, "@variable.builtin", { fg = "#E6D4A3" })
vim.api.nvim_set_hl(0, "@variable.member", { link = "@type.builtin" })
vim.api.nvim_set_hl(0, "@attribute", { link = "@function" })
```

Markdown headings (Tree-sitter)
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "@markup.heading",   { fg = redox.orange, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.1", { fg = redox.orange, bold = true, underline = true })
vim.api.nvim_set_hl(0, "@markup.heading.2", { fg = redox.rust, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.3", { fg = redox.teal, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.4", { fg = redox.amber, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.5", { fg = redox.cyan, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.6", { fg = redox.sea, bold = true })
```

#### Diagnostics 

```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = redox.red })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = redox.warn })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = redox.info })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = redox.hint })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = redox.red, bg = redox.bg_alt })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = redox.warn, bg = redox.bg_alt })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = redox.info, bg = redox.bg_alt })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = redox.hint, bg = redox.bg_alt })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = redox.red })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = redox.warn })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = redox.info })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = redox.hint })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = "#4A5353" })
```

LSP
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = redox.subtle, bg = redox.bg_alt, italic = true })
vim.api.nvim_set_hl(0, "LspReferenceText", { bg = redox.bg_alt })
vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = redox.bg_alt })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = redox.bg_alt })
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bg = redox.selection, bold = true })
vim.api.nvim_set_hl(0, "LspCodeLens", { fg = redox.subtle })
vim.api.nvim_set_hl(0, "LspInfoBorder", { fg = redox.overlay, bg = redox.bg_alt })
```

#### Diff & VCS

```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#33403B" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = "#403F30" })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#4A3333" })
vim.api.nvim_set_hl(0, "DiffText", { bg = redox.orange })
vim.api.nvim_set_hl(0, "diffAdded", { bg = "#33403B", fg = "#449dab" })
vim.api.nvim_set_hl(0, "diffRemoved", { bg = "#4A3333", fg = "#914c54" })
vim.api.nvim_set_hl(0, "diffChanged", { bg = "#403F30", fg = "#6183bb" })
vim.api.nvim_set_hl(0, "diffOldFile", { fg = redox.orange, bg = "#4A3333" })
vim.api.nvim_set_hl(0, "diffNewFile", { fg = redox.orange, bg = "#33403B" })
vim.api.nvim_set_hl(0, "diffFile", { fg = redox.teal })
vim.api.nvim_set_hl(0, "diffLine", { fg = redox.subtle })
vim.api.nvim_set_hl(0, "diffIndexLine", { fg = redox.cyan })
```

GitSigns
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = redox.teal })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = redox.amber })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = redox.red })
```

#### Quickfix / Location list

```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "QFFileName", { fg = redox.teal })
vim.api.nvim_set_hl(0, "QuickFixLine", { fg = redox.bg, bg = redox.orange })
```

#### LSP Semantic tokens

Types & type-like
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "@lsp.type.class", { link = "@type" })
vim.api.nvim_set_hl(0, "@lsp.type.struct", { link = "@type" })
vim.api.nvim_set_hl(0, "@lsp.type.interface", { link = "@function" })
vim.api.nvim_set_hl(0, "@lsp.type.enum", { link = "@type" })
vim.api.nvim_set_hl(0, "@lsp.type.enumMember", { link = "@constant" })
vim.api.nvim_set_hl(0, "@lsp.type.type", { link = "@type" })
vim.api.nvim_set_hl(0, "@lsp.type.typeParameter", { link = "@type" })
vim.api.nvim_set_hl(0, "@lsp.type.union", { link = "@type" })
```

Functions & callables
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "@lsp.type.function", { link = "@function" })
vim.api.nvim_set_hl(0, "@lsp.type.method", { link = "@method" })
vim.api.nvim_set_hl(0, "@lsp.type.macro", { link = "@function" })
vim.api.nvim_set_hl(0, "@lsp.type.constructor", { link = "@function" })
```

Variables & members
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "@lsp.type.variable", { link = "@variable" })
vim.api.nvim_set_hl(0, "@lsp.type.parameter", { link = "@variable" })
vim.api.nvim_set_hl(0, "@lsp.type.property", { link = "@type.builtin" })
vim.api.nvim_set_hl(0, "@lsp.type.field", { link = "@field" })
vim.api.nvim_set_hl(0, "@lsp.type.namespace", { link = "@variable" })
vim.api.nvim_set_hl(0, "@lsp.type.package", { link = "@type" })
```

Literals & operators
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "@lsp.type.number", { link = "@constant" })
vim.api.nvim_set_hl(0, "@lsp.type.boolean", { link = "@constant" })
vim.api.nvim_set_hl(0, "@lsp.type.string", { link = "@string" })
vim.api.nvim_set_hl(0, "@lsp.type.escapeSequence", { link = "@string" })
vim.api.nvim_set_hl(0, "@lsp.type.formatSpecifier", { link = "@string" })
vim.api.nvim_set_hl(0, "@lsp.type.operator", { link = "@operator" })
```

Keywords & modifiersua/my/theme.lua
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "@lsp.type.keyword", { link = "@keyword" })
vim.api.nvim_set_hl(0, "@lsp.type.modifier", { link = "@keyword" })
```

Comments, regexps, decorators/attributes
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "@lsp.type.comment", { link = "@comment" })
vim.api.nvim_set_hl(0, "@lsp.type.regexp", { link = "@string" })
vim.api.nvim_set_hl(0, "@lsp.type.decorator", { fg = "#E6D4A3", italic = true })
```

Builtins/special identifiersm-lite/lua/my/theme.lua
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "@lsp.type.builtinType", { link = "@type.builtin" })
vim.api.nvim_set_hl(0, "@lsp.type.selfKeyword", { link = "@variable.builtin" })
vim.api.nvim_set_hl(0, "@lsp.type.null", { link = "@constant" })
```

LSP modifiers
```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.api.nvim_set_hl(0, "@lsp.mod.deprecated", { strikethrough = true })
vim.api.nvim_set_hl(0, "@lsp.mod.readonly", { underline = true, sp = "#4A5353" })
vim.api.nvim_set_hl(0, "@lsp.mod.static", { italic = true })
vim.api.nvim_set_hl(0, "@lsp.mod.abstract", { italic = true })
vim.api.nvim_set_hl(0, "@lsp.mod.unused", { fg = "#4A5353" })
vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary", { link = "@variable.builtin" })
```

### Tabline

```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
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

```lua tangle:~/.config/nvim/lua/my/theme.lua,~/.config/nvim-lite/lua/my/theme.lua
vim.o.statusline = " %f [%{strlen(&fenc)?&fenc:&enc}] [%{&ff}] %y [%{&spelllang}] [0x%04B] "
    .. "%="
    .. " [%n] %l/%L (%p%%), %c "
    .. "%#StatusLineNC#%{&mod?' [+] ':''}%*"
```
