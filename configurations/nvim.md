# Nvim

## Init

Import my configurations
> `~/.config/nvim/init.lua`
```lua tangle:~/.config/nvim/init.lua
require("my.mappings")
require("my.options")
require("my.autocmd")
require("my.init-lazy")
```

Configuration for my non-plugin setup
> `~/.config/nvim-lite/init.lua`
```lua tangle:~/.config/nvim-lite/init.lua
require("my.theme")
require("my.mappings")
require("my.options")
require("my.netrw")
require("my.autocmd")
```

## Keymaps

Change `<leader>` to `Space`
> `~/.config/nvim/lua/my/mappings.lua`, `~/.config/nvim-lite/lua/my/mappings.lua`
```lua tangle:~/.config/nvim/lua/my/mappings.lua,~/.config/nvim-lite/lua/my/mappings.lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "
```

Remove highlight from search
> `~/.config/nvim/lua/my/mappings.lua`, `~/.config/nvim-lite/lua/my/mappings.lua`
```lua tangle:~/.config/nvim/lua/my/mappings.lua,~/.config/nvim-lite/lua/my/mappings.lua
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
```

Move line up/down (visual mode)
> `~/.config/nvim/lua/my/mappings.lua`, `~/.config/nvim-lite/lua/my/mappings.lua`
```lua tangle:~/.config/nvim/lua/my/mappings.lua,~/.config/nvim-lite/lua/my/mappings.lua
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move line up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move line down" })
```

Center cursor on up/down
> `~/.config/nvim/lua/my/mappings.lua`, `~/.config/nvim-lite/lua/my/mappings.lua`
```lua tangle:~/.config/nvim/lua/my/mappings.lua,~/.config/nvim-lite/lua/my/mappings.lua
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move cursor up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move cursor down" })
```

Yank to/paste from system clipboard
> `~/.config/nvim/lua/my/mappings.lua`, `~/.config/nvim-lite/lua/my/mappings.lua`
```lua tangle:~/.config/nvim/lua/my/mappings.lua,~/.config/nvim-lite/lua/my/mappings.lua
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[y]ank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank rest of line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "[p]aste from system clipboard" })
```

Paste from yank register (`"0`)
> `~/.config/nvim/lua/my/mappings.lua`, `~/.config/nvim-lite/lua/my/mappings.lua`
```lua tangle:~/.config/nvim/lua/my/mappings.lua,~/.config/nvim-lite/lua/my/mappings.lua
vim.keymap.set({"n", "v"}, "<C-p>", "\"0p", { desc = "paste from yank register" })
```

Replace all of word under cursor
> `~/.config/nvim/lua/my/mappings.lua`, `~/.config/nvim-lite/lua/my/mappings.lua`
```lua tangle:~/.config/nvim/lua/my/mappings.lua,~/.config/nvim-lite/lua/my/mappings.lua
vim.keymap.set(
	"n",
	"<leader>dr",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "[r]eplace word" }
)
```

Diagnostic keymaps
> `~/.config/nvim/lua/my/mappings.lua`, `~/.config/nvim-lite/lua/my/mappings.lua`
```lua tangle:~/.config/nvim/lua/my/mappings.lua,~/.config/nvim-lite/lua/my/mappings.lua
vim.keymap.set("n", "<leader>dd", vim.diagnostic.setloclist, { desc = "[d]iagnostic (location list)" })
vim.keymap.set("n", "<leader>wd", vim.diagnostic.setqflist, { desc = "[d]iagnostic (quickfix list)" })
```

Go between quickfix list entries
> `~/.config/nvim/lua/my/mappings.lua`, `~/.config/nvim-lite/lua/my/mappings.lua`
```lua tangle:~/.config/nvim/lua/my/mappings.lua,~/.config/nvim-lite/lua/my/mappings.lua
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "go to next quickfix list entry" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "go to previous quickfix list entry" })
```

Toggle folds
> `~/.config/nvim/lua/my/mappings.lua`, `~/.config/nvim-lite/lua/my/mappings.lua`
```lua tangle:~/.config/nvim/lua/my/mappings.lua,~/.config/nvim-lite/lua/my/mappings.lua
vim.keymap.set("n", "<tab>", "za", { desc = "toggle folds under cursor" })
```

Disable arrow keys in normal mode
> `~/.config/nvim/lua/my/mappings.lua`, `~/.config/nvim-lite/lua/my/mappings.lua`
```lua tangle:~/.config/nvim/lua/my/mappings.lua,~/.config/nvim-lite/lua/my/mappings.lua
vim.keymap.set("n", "<left>", "<Nop>")
vim.keymap.set("n", "<right>", "<Nop>")
vim.keymap.set("n", "<up>", "<Nop>")
vim.keymap.set("n", "<down>", "<Nop>")
```

Save/restore vim sessions
> `~/.config/nvim/lua/my/mappings.lua`, `~/.config/nvim-lite/lua/my/mappings.lua`
```lua tangle:~/.config/nvim/lua/my/mappings.lua,~/.config/nvim-lite/lua/my/mappings.lua
vim.keymap.set("n", "<leader>SS", function() vim.cmd([[mksession! .session.vim]]) end, { desc = "[S]ave" })
vim.keymap.set("n", "<leader>SR", function() vim.cmd([[source .session.vim]]) end, { desc = "[R]estore" })
```

## Options

Enable line number
> `~/.config/nvim/lua/my/options.lua`, `~/.config/nvim-lite/lua/my/options.lua`
```lua tangle:~/.config/nvim/lua/my/options.lua,~/.config/nvim-lite/lua/my/options.lua
vim.opt.number = true
```

Enable relative line numbers
> `~/.config/nvim/lua/my/options.lua`, `~/.config/nvim-lite/lua/my/options.lua`
```lua tangle:~/.config/nvim/lua/my/options.lua,~/.config/nvim-lite/lua/my/options.lua
vim.opt.relativenumber = true
```

Change tab spacing to four spaces
> `~/.config/nvim/lua/my/options.lua`, `~/.config/nvim-lite/lua/my/options.lua`
```lua tangle:~/.config/nvim/lua/my/options.lua,~/.config/nvim-lite/lua/my/options.lua
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
```

Sane defaults
> `~/.config/nvim/lua/my/options.lua`, `~/.config/nvim-lite/lua/my/options.lua`
```lua tangle:~/.config/nvim/lua/my/options.lua,~/.config/nvim-lite/lua/my/options.lua
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
> `~/.config/nvim/lua/my/options.lua`, `~/.config/nvim-lite/lua/my/options.lua`
```lua tangle:~/.config/nvim/lua/my/options.lua,~/.config/nvim-lite/lua/my/options.lua
vim.opt.updatetime = 50
```

Decrease mapped sequence wait time (displays which-key popup sooner)
> `~/.config/nvim/lua/my/options.lua`, `~/.config/nvim-lite/lua/my/options.lua`
```lua tangle:~/.config/nvim/lua/my/options.lua,~/.config/nvim-lite/lua/my/options.lua
vim.opt.timeoutlen = 300
```

Configure how new splits should be opened
> `~/.config/nvim/lua/my/options.lua`, `~/.config/nvim-lite/lua/my/options.lua`
```lua tangle:~/.config/nvim/lua/my/options.lua,~/.config/nvim-lite/lua/my/options.lua
vim.opt.splitright = true
vim.opt.splitbelow = true
```

Sets how neovim will display certain whitespace characters in the editor.
(See `:help 'list'` and `:help 'listchars'`)
> `~/.config/nvim/lua/my/options.lua`, `~/.config/nvim-lite/lua/my/options.lua`
```lua tangle:~/.config/nvim/lua/my/options.lua,~/.config/nvim-lite/lua/my/options.lua
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", leadmultispace = "|   " }
```

Preview substitutions live, as you type!
> `~/.config/nvim/lua/my/options.lua`, `~/.config/nvim-lite/lua/my/options.lua`
```lua tangle:~/.config/nvim/lua/my/options.lua,~/.config/nvim-lite/lua/my/options.lua
vim.opt.inccommand = "split"
```

Show which line your cursor is on
> `~/.config/nvim/lua/my/options.lua`, `~/.config/nvim-lite/lua/my/options.lua`
```lua tangle:~/.config/nvim/lua/my/options.lua,~/.config/nvim-lite/lua/my/options.lua
vim.opt.cursorline = true
```

Breakindent
> `~/.config/nvim/lua/my/options.lua`, `~/.config/nvim-lite/lua/my/options.lua`
```lua tangle:~/.config/nvim/lua/my/options.lua,~/.config/nvim-lite/lua/my/options.lua
vim.opt.breakindent = true
```

Case-insensitive searching UNLESS \C or one or more capital letters in the search term
> `~/.config/nvim/lua/my/options.lua`, `~/.config/nvim-lite/lua/my/options.lua`
```lua tangle:~/.config/nvim/lua/my/options.lua,~/.config/nvim-lite/lua/my/options.lua
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
```

Automatic folding based on treesitter
> `~/.config/nvim/lua/my/options.lua`
```lua tangle:~/.config/nvim/lua/my/options.lua
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
```

Folding based on indent
> `~/.config/nvim-lite/lua/my/options.lua`
```lua tangle:~/.config/nvim-lite/lua/my/options.lua
vim.opt.foldmethod = "indent"
```

Disable default folding when opening file
> `~/.config/nvim/lua/my/options.lua`, `~/.config/nvim-lite/lua/my/options.lua`
```lua tangle:~/.config/nvim/lua/my/options.lua,~/.config/nvim-lite/lua/my/options.lua
vim.opt.foldlevelstart = 99
```

## Netrw

> `~/.config/nvim-lite/lua/my/netrw.lua`
```lua tangle:~/.config/nvim-lite/lua/my/netrw.lua
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
```

## Autocmd

Highlight when yanking (copying) text
> `~/.config/nvim/lua/my/autocmd.lua`, `~/.config/nvim-lite/lua/my/autocmd.lua`
```lua tangle:~/.config/nvim/lua/my/autocmd.lua,~/.config/nvim-lite/lua/my/autocmd.lua
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("augroup-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
```

Automatically save session when closing nvim
> `~/.config/nvim/lua/my/autocmd.lua`, `~/.config/nvim-lite/lua/my/autocmd.lua`
```lua tangle:~/.config/nvim/lua/my/autocmd.lua,~/.config/nvim-lite/lua/my/autocmd.lua
vim.api.nvim_create_autocmd("VimLeave", {
	desc = "Save session on exit",
	group = vim.api.nvim_create_augroup("augroup-session-manage", { clear = true }),
	callback = function()
		vim.cmd([[silent! mksession! .session.vim]])
	end,
})
```

Reload files when changed on disk
> `~/.config/nvim/lua/my/autocmd.lua`, `~/.config/nvim-lite/lua/my/autocmd.lua`
```lua tangle:~/.config/nvim/lua/my/autocmd.lua,~/.config/nvim-lite/lua/my/autocmd.lua
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	desc = "Check if file changed on disk",
	group = vim.api.nvim_create_augroup("augroup-file-disk-status", { clear = true }),
	pattern = { "*" },
	command = "if mode() != 'c' | checktime | endif",
})
```

Add keymaps for executing `Lua` code (for `Lua` buffers only)
> `~/.config/nvim/lua/my/autocmd.lua`, `~/.config/nvim-lite/lua/my/autocmd.lua`
```lua tangle:~/.config/nvim/lua/my/autocmd.lua,~/.config/nvim-lite/lua/my/autocmd.lua
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

## Lazy (plugins)

Init `lazy.nvim`
> `~/.config/nvim/lua/my/init-lazy.lua`
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

General plugins
> `~/.config/nvim/lua/my/plugins/general.lua`
```lua tangle:~/.config/nvim/lua/my/plugins/general.lua
return {
```

Detect tabstop and shiftwidth automatically
```lua tangle:~/.config/nvim/lua/my/plugins/general.lua
	"tpope/vim-sleuth",
```

Highlight todo, notes, etc in comments
```lua tangle:~/.config/nvim/lua/my/plugins/general.lua
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
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

Adds git related signs to the gutter, as well as utilities for managing changes
> `~/.config/nvim/lua/my/plugins/gitsigns.lua`
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
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
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
                sources = {
                    buffers = {
                        layout = {
                            preset = "ivy",
                        },
                    },
                    explorer = {
                        layout = {
                            preset = "sidebar",
                            preview = true,

                            layout = {
                                width = 0.5,
                                min_width = 40,
                            }
                        },
                        auto_close = true,
                        focus = "input",
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

Highlight, edit, and navigate code
> `~/.config/nvim/lua/my/plugins/treesitter.lua`
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

Useful plugin to show you pending keybinds.
> `~/.config/nvim/lua/my/plugins/which-key.lua`
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

If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.

> `~/.config/nvim/lua/my/plugins/theme.lua`
```lua tangle:~/.config/nvim/lua/my/plugins/theme.lua
return {
	"folke/tokyonight.nvim",
	priority = 1000, -- Make sure to load this before all the other start plugins.
	init = function()
		require("tokyonight").setup({
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

		-- Configure statusline
		vim.cmd.hi("StatusLine guibg=#A6E3A1 guifg=#374641")
		vim.cmd.hi("StatusFlags guibg=#374641 guifg=#A6E3A1")
		vim.o.statusline = " %F [%{strlen(&fenc)?&fenc:&enc}] [%{&ff}] %y [%{&spelllang}] [0x%04B] "
			.. "%="
			.. " [%n] %l/%L (%p%%), %c "
			.. "%#StatusFlags#%{&mod?' [+] ':''}%*"
	end,
}
```

For the non-plugin version I use a theme strongly influenced by [tokyonight.nvim](https://github.com/folke/tokyonight.nvim).

> `~/.config/nvim-lite/lua/my/theme.lua`
```lua tangle:~/.config/nvim-lite/lua/my/theme.lua
local colors = {
    bg = "#2E3434",
    bg_color_column = "#374641",
    bg_dark = "#16161e",
    bg_float = "#16161e",
    bg_highlight = "#292e42",
    bg_popup = "#16161e",
    bg_search = "#3d59a1",
    bg_sidebar = "#2E3434",
    bg_statusline = "#374641",
    bg_statusline_active = "#A6E3A1",
    bg_visual = "#283457",
    black = "#15161e",
    blue = "#7aa2f7",
    blue1 = "#2ac3de",
    blue5 = "#89ddff",
    blue7 = "#394b70",
    border = "#15161e",
    border_highlight = "#27a1b9",
    comment = "#577466",
    cyan = "#7dcfff",
    dark3 = "#545c7e",
    dark5 = "#737aa2",
    diff = {
        add = "#20303b",
        change = "#1f2231",
        delete = "#37222c",
        text = "#394b70",
    },
    error = "#db4b4b",
    fg = "#c0caf5",
    fg_dark = "#a9b1d6",
    fg_float = "#c0caf5",
    fg_gutter = "#577466",
    fg_sidebar = "#374641",
    git = {
        add = "#449dab",
        change = "#6183bb",
        delete = "#914c54",
    },
    green = "#9ece6a",
    green1 = "#73daca",
    hint = "#1abc9c",
    info = "#0db9d7",
    magenta = "#bb9af7",
    magenta2 = "#ff007c",
    orange = "#ff9e64",
    red = "#f7768e",
    terminal_black = "#414868",
    warning = "#e0af68",
    yellow = "#e0af68",
}

local function getHighlightGroup(c)
    return {
        Foo                         = { bg = c.magenta2, fg = c.fg },
        Comment                     = { fg = c.comment, italic = true }, -- any comment
        ColorColumn                 = { bg = c.bg_color_column },                    -- used for the columns set with 'colorcolumn'
        Conceal                     = { fg = c.dark5 },                              -- placeholder characters substituted for concealed text (see 'conceallevel')
        Cursor                      = { fg = c.bg, bg = c.fg },                      -- character under the cursor
        lCursor                     = { fg = c.bg, bg = c.fg },                      -- the character under the cursor when |language-mapping| is used (see 'guicursor')
        CursorIM                    = { fg = c.bg, bg = c.fg },                      -- like Cursor, but used when in IME mode |CursorIM|
        CursorColumn                = { bg = c.bg_highlight },                       -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorLine                  = { bg = c.bg_highlight },                       -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
        Directory                   = { fg = c.blue },                               -- directory names (and other special names in listings)
        DiffAdd                     = { bg = c.diff.add },                           -- diff mode: Added line |diff.txt|
        DiffChange                  = { bg = c.diff.change },                        -- diff mode: Changed line |diff.txt|
        DiffDelete                  = { bg = c.diff.delete },                        -- diff mode: Deleted line |diff.txt|
        DiffText                    = { bg = c.diff.text },                          -- diff mode: Changed text within a changed line |diff.txt|
        EndOfBuffer                 = { fg = c.bg },                                 -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
        ErrorMsg                    = { fg = c.error },                              -- error messages on the command line
        VertSplit                   = { fg = c.border },                             -- the column separating vertically split windows
        WinSeparator                = { fg = c.border, bold = true },                -- the column separating vertically split windows
        Folded                      = { fg = c.blue, bg = c.fg_gutter },             -- line used for closed folds
        FoldColumn                  = { bg = c.bg, fg = c.comment },                 -- 'foldcolumn'
        SignColumn                  = { bg = c.bg, fg = c.fg_gutter },               -- column where |signs| are displayed
        SignColumnSB                = { bg = c.bg_sidebar, fg = c.fg_gutter },       -- column where |signs| are displayed
        Substitute                  = { bg = c.red, fg = c.black },                  -- |:substitute| replacement text highlighting
        LineNr                      = { fg = c.fg_gutter },                          -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        CursorLineNr                = { fg = c.orange, bold = true },                -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        LineNrAbove                 = { fg = c.fg_gutter },
        LineNrBelow                 = { fg = c.fg_gutter },
        MatchParen                  = { fg = c.orange, bold = true },           -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        ModeMsg                     = { fg = c.fg_dark, bold = true },          -- 'showmode' message (e.g., "-- INSERT -- ")
        MsgArea                     = { fg = c.fg_dark },                       -- Area for messages and cmdline
        MoreMsg                     = { fg = c.blue },                          -- |more-prompt|
        NonText                     = { fg = c.dark3 },                         -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal                      = { fg = c.fg, bg = c.bg },                 -- normal text
        NormalNC                    = { fg = c.fg, bg = c.bg },
        NormalSB                    = { fg = c.fg_sidebar, bg = c.bg_sidebar }, -- normal text in sidebar
        NormalFloat                 = { fg = c.fg_float, bg = c.bg_float },     -- Normal text in floating windows.
        FloatBorder                 = { fg = c.border_highlight, bg = c.bg_float },
        FloatTitle                  = { fg = c.border_highlight, bg = c.bg_float },
        Pmenu                       = { bg = c.bg_popup, fg = c.fg },                     -- Popup menu: normal item.
        PmenuMatch                  = { bg = c.bg_popup, fg = c.blue1 },                  -- Popup menu: Matched text in normal item.
        PmenuSel                    = { bg = c.fg_gutter },
        PmenuMatchSel               = { bg = c.fg_gutter, fg = c.blue1 },                 -- Popup menu: Matched text in selected item.
        PmenuSbar                   = { bg = c.bg_popup },                                -- Popup menu: scrollbar.
        PmenuThumb                  = { bg = c.fg_gutter },                               -- Popup menu: Thumb of the scrollbar.
        Question                    = { fg = c.blue },                                    -- |hit-enter| prompt and yes/no questions
        QuickFixLine                = { bg = c.bg_visual, bold = true },                  -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Search                      = { bg = c.bg_search, fg = c.fg },                    -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        IncSearch                   = { bg = c.orange, fg = c.black },                    -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        CurSearch                   = "IncSearch",
        SpecialKey                  = { fg = c.dark3 },                                   -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        SpellBad                    = { sp = c.error, undercurl = true },                 -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap                    = { sp = c.warning, undercurl = true },               -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal                  = { sp = c.info, undercurl = true },                  -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare                   = { sp = c.hint, undercurl = true },                  -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
        StatusLine                  = { fg = c.fg_sidebar, bg = c.bg_statusline_active }, -- status line of current window
        StatusLineNC                = { fg = c.fg_gutter, bg = c.bg_statusline },         -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        TabLine                     = { bg = c.bg_statusline, fg = c.fg_gutter },         -- tab pages line, not active tab page label
        TabLineFill                 = { bg = c.black },                                   -- tab pages line, where there are no labels
        TabLineSel                  = { fg = c.black, bg = c.blue },                      -- tab pages line, active tab page label
        Title                       = { fg = c.blue, bold = true },                       -- titles for output from ":set all", ":autocmd" etc.
        Visual                      = { bg = c.bg_visual },                               -- Visual mode selection
        VisualNOS                   = { bg = c.bg_visual },                               -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg                  = { fg = c.warning },                                 -- warning messages
        Whitespace                  = { fg = c.fg_gutter },                               -- "nbsp", "space", "tab" and "trail" in 'listchars'
        WildMenu                    = { bg = c.bg_visual },                               -- current match in 'wildmenu' completion
        WinBar                      = "StatusLine",                                       -- window bar
        WinBarNC                    = "StatusLineNC",                                     -- window bar in inactive windows
        Bold                        = { bold = true, fg = c.fg },                         -- (preferred) any bold text
        Character                   = { fg = c.green },                                   --  a character constant: 'c', '\n'
        Constant                    = { fg = c.orange },                                  -- (preferred) any constant
        Debug                       = { fg = c.orange },                                  --    debugging statements
        Delimiter                   = "Special",                                          --  character that needs attention
        Error                       = { fg = c.error },                                   -- (preferred) any erroneous construct
        Function                    = { fg = c.blue },                                    -- function name (also: methods for classes)
        Identifier                  = { fg = c.magenta },                                 -- (preferred) any variable name
        Italic                      = { italic = true, fg = c.fg },                       -- (preferred) any italic text
        Keyword                     = { fg = c.cyan, italic = true },                     --  any other keyword
        Operator                    = { fg = c.blue5 },                                   -- "sizeof", "+", "*", etc.
        PreProc                     = { fg = c.cyan },                                    -- (preferred) generic Preprocessor
        Special                     = { fg = c.blue1 },                                   -- (preferred) any special symbol
        Statement                   = { fg = c.magenta },                                 -- (preferred) any statement
        String                      = { fg = c.green },                                   --   a string constant: "this is a string"
        Todo                        = { bg = c.yellow, fg = c.bg },                       -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
        Type                        = { fg = c.blue1 },                                   -- (preferred) int, long, char, etc.
        Underlined                  = { underline = true },                               -- (preferred) text that stands out, HTML links
        debugBreakpoint             = { bg = c.info, fg = c.info },                       -- used for breakpoint colors in terminal-debug
        debugPC                     = { bg = c.bg_sidebar },                              -- used for highlighting the current line in terminal-debug
        dosIniLabel                 = "@property",
        helpCommand                 = { bg = c.terminal_black, fg = c.blue },
        htmlH1                      = { fg = c.magenta, bold = true },
        htmlH2                      = { fg = c.blue, bold = true },
        qfFileName                  = { fg = c.blue },
        qfLineNr                    = { fg = c.dark5 },

        -- These groups are for the native LSP client. Some other LSP clients may
        -- use these groups, or use their own.
        LspReferenceText            = { bg = c.fg_gutter }, -- used for highlighting "text" references
        LspReferenceRead            = { bg = c.fg_gutter }, -- used for highlighting "read" references
        LspReferenceWrite           = { bg = c.fg_gutter }, -- used for highlighting "write" references
        LspSignatureActiveParameter = { bg = c.bg_visual, bold = true },
        LspCodeLens                 = { fg = c.comment },
        LspInlayHint                = { bg = c.blue7, fg = c.dark3 },
        LspInfoBorder               = { fg = c.border_highlight, bg = c.bg_float },

        -- diagnostics
        DiagnosticError             = { fg = c.error },                     -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticWarn              = { fg = c.warning },                   -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticInfo              = { fg = c.info },                      -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticHint              = { fg = c.hint },                      -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticUnnecessary       = { fg = c.terminal_black },            -- Used as the base highlight group. Other Diagnostic highlights link to this by default
        DiagnosticVirtualTextError  = { bg = c.error, fg = c.error },       -- Used for "Error" diagnostic virtual text
        DiagnosticVirtualTextWarn   = { bg = c.warning, fg = c.warning },   -- Used for "Warning" diagnostic virtual text
        DiagnosticVirtualTextInfo   = { bg = c.info, fg = c.info },         -- Used for "Information" diagnostic virtual text
        DiagnosticVirtualTextHint   = { bg = c.hint, fg = c.hint },         -- Used for "Hint" diagnostic virtual text
        DiagnosticUnderlineError    = { undercurl = true, sp = c.error },   -- Used to underline "Error" diagnostics
        DiagnosticUnderlineWarn     = { undercurl = true, sp = c.warning }, -- Used to underline "Warning" diagnostics
        DiagnosticUnderlineInfo     = { undercurl = true, sp = c.info },    -- Used to underline "Information" diagnostics
        DiagnosticUnderlineHint     = { undercurl = true, sp = c.hint },    -- Used to underline "Hint" diagnostics

        -- Health
        healthError                 = { fg = c.error },
        healthSuccess               = { fg = c.green1 },
        healthWarning               = { fg = c.warning },

        -- diff (not needed anymore?)
        diffAdded                   = { bg = c.diff.add, fg = c.git.add },
        diffRemoved                 = { bg = c.diff.delete, fg = c.git.delete },
        diffChanged                 = { bg = c.diff.change, fg = c.git.change },
        diffOldFile                 = { fg = c.blue1, bg = c.diff.delete },
        diffNewFile                 = { fg = c.blue1, bg = c.diff.add },
        diffFile                    = { fg = c.blue },
        diffLine                    = { fg = c.comment },
        diffIndexLine               = { fg = c.magenta },
        helpExample                 = { fg = c.comment },
    }
end

local groups = getHighlightGroup(colors)

for group, hl in pairs(groups) do
    hl = type(hl) == "string" and { link = hl } or hl
    vim.api.nvim_set_hl(0, group, hl)
end

vim.cmd.hi("StatusFlags guibg=#374641 guifg=#A6E3A1")
vim.o.statusline = " %F [%{strlen(&fenc)?&fenc:&enc}] [%{&ff}] %y [%{&spelllang}] [0x%04B] "
    .. "%="
    .. " [%n] %l/%L (%p%%), %c "
    .. "%#StatusFlags#%{&mod?' [+] ':''}%*"

```

