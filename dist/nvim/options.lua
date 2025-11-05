vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.colorcolumn = "80"

vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99
vim.cmd "highlight StatusGeneral guibg=#A6E3A1 guifg=#2E3434"
vim.cmd "highlight StatusFlags guibg=#FABD2F guifg=#2E3434"
vim.cmd "highlight StatusBlank guibg=none guifg=#2E3434"

vim.o.statusline = "%#StatusGeneral#"
	.. " %F "
	.. "%#StatusFlags#"
	.. " [%{strlen(&fenc)?&fenc:&enc}] [%{&ff}] %y [%{&spelllang}] [0x%04B] %m "
	.. "%#StatusBlank#"
	.. "%="
	.. "%#StatusGeneral#"
	.. " [%n] %l/%L (%p%%), %c "
