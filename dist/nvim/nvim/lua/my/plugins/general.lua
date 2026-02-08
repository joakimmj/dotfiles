return {
	"tpope/vim-sleuth",
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
  {
    "md-mode",
    dir = "~/dev/md-mode.nvim",
    ft = "markdown",
  },
}
