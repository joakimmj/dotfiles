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

		-- Configure tabline
		vim.cmd.hi("TabLine guibg=#374641 guifg=#577466")
		vim.cmd.hi("TabLineFill guibg=#2E3434")
		vim.cmd.hi("TabLineSel guibg=#374641 guifg=#A6E3A1")

		vim.o.tabline = "%!v:lua.get_tabline()"
	end,
}
