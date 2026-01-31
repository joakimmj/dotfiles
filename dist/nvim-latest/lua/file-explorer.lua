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
