vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<leader>wf", function()
	vim.cmd("Lex")
end, { desc = "[W]orkspace [F]iles" })

-- remove highlight from search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- move linex up/down (visual mode)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })

-- center cursor on up/down
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move cursor up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move cursor down" })

-- yank/delete to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[Y]ank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank rest of line to system clipboard" })

-- replace all of word under cursor
vim.keymap.set(
	"n",
	"<leader>dr",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "[D]ocument [R]eplace word" }
)

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>dd", vim.diagnostic.setloclist, { desc = "[D]ocument [D]iagnostic (location list)" })
vim.keymap.set("n", "<leader>wd", vim.diagnostic.setqflist, { desc = "[W]orkspace [D]iagnostic (quickfix list)" })

-- go between quickfix list entries
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Go to next quickfix list entry" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Go to previous quickfix list entry" })

-- toggle folds
vim.keymap.set("n", "<tab>", "za", { desc = "Toggle folds under cursor" })

-- disable arrow keys in normal mode
vim.keymap.set("n", "<left>", "<Nop>")
vim.keymap.set("n", "<right>", "<Nop>")
vim.keymap.set("n", "<up>", "<Nop>")
vim.keymap.set("n", "<down>", "<Nop>")