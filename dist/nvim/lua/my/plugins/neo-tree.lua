return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "<leader>wf", ":Neotree reveal<CR>",     desc = "[f]iles",      silent = true },
		{ "<leader>wb", ":Neotree buffers<CR>",    desc = "[b]uffers",    silent = true },
		{ "<leader>vs", ":Neotree git_status<CR>", desc = "git [s]tatus", silent = true },
	},
	config = function()
		require("neo-tree").setup({
			window = {
				position = "float",
				mappings = {
					["P"]     = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
					["<C-u>"] = { "scroll_preview", config = { direction = 10 } },
					["<C-d>"] = { "scroll_preview", config = { direction = -10 } },
					["A"]     = "git_add_all",
					["gu"]    = "git_unstage_file",
					["ga"]    = "git_add_file",
					["gr"]    = "git_revert_file",
					["?"]     = "show_help",
					["h"]     = "close_node",
					["l"]     = { "toggle_node", nowait = false },
				},
			},
			filesystem = {
				filtered_items = {
					visible = true,
				},
			},
		})
	end
}
