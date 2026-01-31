vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true
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
-- vim.opt.updatetime = 50 --default 4000
-- vim.opt.timeoutlen = 300 -- default 1000
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", leadmultispace = "|   " }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- TODO: use indent based as default
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "move line up" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "move line down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "move selection up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
vim.keymap.set("v", "<", "<gv", { desc = "indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "indent right and reselect" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "join lines and keep cursor position" })
vim.keymap.set("n", "<leader>dw", "<cmd>set wrap!<CR>", { desc = "toggle [w]rap" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move cursor up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move cursor down" })
vim.keymap.set("n", "n", "nzzzv", { desc = "next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "previous search result (centered)" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[y]ank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank rest of line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "[p]aste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<C-p>", "\"0p", { desc = "paste from yank register" })
vim.keymap.set(
	"n",
	"<leader>dr",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "[r]eplace word" }
)
vim.keymap.set(
	"v",
	"<leader>dr",
	[["hy:%s/<C-r>h//gI<left><left><left>]],
	{ desc = "[r]eplace selected text" }
)
vim.keymap.set("n", "<leader>dd", vim.diagnostic.setloclist, { desc = "[d]iagnostic (location list)" })
vim.keymap.set("n", "<leader>wd", vim.diagnostic.setqflist, { desc = "[d]iagnostic (quickfix list)" })
vim.keymap.set("n", "<leader>dj", "<cmd>try | lnext | catch | lfirst | catch | endtry<CR>zz", { desc = "go to next location list entry" })
vim.keymap.set("n", "<leader>dk", "<cmd>try | lprevious | catch | llast | catch | endtry<CR>zz", { desc = "go to previous location list entry" })
vim.keymap.set("n", "<leader>dl", function()
  local loclist_win = vim.fn.getloclist(0, { winid = 0 }).winid
  if loclist_win ~= 0 then
    vim.cmd("botright lclose")
  else
    local status, _ = pcall(vim.cmd, "botright lopen")
    if not status then
      print("Location list is empty")
    end
  end
end, { noremap = true, silent = true, desc = "[l]ocation list toggle" })
vim.keymap.set("n", "<C-j>", "<cmd>try | cnext | catch | cfirst | catch | endtry<CR>zz", { desc = "go to next quickfix list entry" })
vim.keymap.set("n", "<C-k>", "<cmd>try | cprevious | catch | clast | catch | endtry<CR>zz", { desc = "go to previous quickfix list entry" })
vim.keymap.set("n", "<C-h>", "<cmd>colder<CR>", { desc = "go to previous quickfix list" })
vim.keymap.set("n", "<C-l>", "<cmd>cnewer<CR>", { desc = "go to next quickfix list" })
vim.keymap.set("n", "<leader>q", function()
    local qf_list = vim.fn.getqflist({ winid = 0, size = 0 })
	if qf_list.winid ~= 0 then
		vim.cmd("botright cclose")
	elseif qf_list.size == 0 then
		print("Quickfix list is empty")
	else
		vim.cmd("botright copen")
	end
end, { noremap = true, silent = true, desc = "[q]uickfix list toggle" })
vim.keymap.set("n", "<left>", "<Nop>")
vim.keymap.set("n", "<right>", "<Nop>")
vim.keymap.set("n", "<up>", "<Nop>")
vim.keymap.set("n", "<down>", "<Nop>")
vim.keymap.set("n", "<leader>SS", function() vim.cmd([[mksession! .session.vim]]) end, { desc = "[S]ave" })
vim.keymap.set("n", "<leader>SR", function() vim.cmd([[source .session.vim]]) end, { desc = "[R]estore" })
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("augroup-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
vim.api.nvim_create_autocmd("VimLeave", {
	desc = "Save session on exit",
	group = vim.api.nvim_create_augroup("augroup-session-manage", { clear = true }),
	callback = function()
		vim.cmd([[silent! mksession! .session.vim]])
	end,
})
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	desc = "Check if file changed on disk",
	group = vim.api.nvim_create_augroup("augroup-file-disk-status", { clear = true }),
	pattern = { "*" },
	command = "if mode() != 'c' | checktime | endif",
})
vim.api.nvim_create_autocmd("FileType", {
	desc = "Lua specific options",
	pattern = "lua",
	group = vim.api.nvim_create_augroup("augroup-lua-options", { clear = true }),
	callback = function()
		vim.keymap.set("n", "<leader>X", "<cmd>source %<CR>", { buffer = true, desc = "e[X]ecute lua file" })
		vim.keymap.set("n", "<leader>x", ":.lua<CR>", { buffer = true, desc = "e[x]ecute lua line" })
		vim.keymap.set("v", "<leader>x", ":lua<CR>", { buffer = true, desc = "e[x]ecute lua selection" })
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	desc = "Json specific options",
	pattern = "json",
	group = vim.api.nvim_create_augroup("augroup-json-options", { clear = true }),
	callback = function()
		vim.keymap.set("n", "<leader>X", [[%!jq '.']], { buffer = true, desc = "e[X]ecute json formatting" })
	end,
})
local file_explorer_conf_exists, _ = pcall(require, "file-explorer")
if not file_explorer_conf_exists then
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
local theme_conf_exists, _ = pcall(require, "theme")
if not theme_conf_exists then
    vim.cmd.colorscheme("vim")
end
local development_conf_exists, _ = pcall(require, "development")
if not development_conf_exists then
    vim.keymap.set("n", "<leader>df", "gg=G", { desc = "[f]ormat" })
end
