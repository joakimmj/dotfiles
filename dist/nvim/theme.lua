return {
	"folke/tokyonight.nvim",
	priority = 1000, -- Make sure to load this before all the other start plugins.
	init = function()
		require("tokyonight").setup({
			on_colors = function(colors)
				colors.bg = "#2E3434"
				colors.comment = "#577466"
				colors.fg_gutter = "#577466"
				colors.bg_statusline = "#A6E3A1"
				colors.fg_sidebar = "#577466"
				colors.bg_sidebar = "#2E3434"
			end,
		})
		-- Set colorscheme
		vim.cmd.colorscheme("tokyonight-night")

		-- Configure highlights
		vim.cmd.hi("Comment gui=none")
		vim.cmd.hi("ColorColumn guibg=#A6E3A1")
	end,
}
