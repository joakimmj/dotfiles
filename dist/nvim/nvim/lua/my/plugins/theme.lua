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
