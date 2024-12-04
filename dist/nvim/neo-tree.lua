return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "<leader>wt", ":Neotree reveal<CR>",     desc = "[W]orkspace [F]iles",   silent = true },
		{ "<leader>wb", ":Neotree buffers<CR>",    desc = "[W]orkspace [B]uffers", silent = true },
		{ "<leader>hs", ":Neotree git_status<CR>", desc = "git [s]tatus",          silent = true },
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
