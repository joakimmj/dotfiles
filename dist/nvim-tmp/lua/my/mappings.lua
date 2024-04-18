vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", function() vim.cmd("Lex") end)

-- remove highlight from search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- move linex up/down (visual mode)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- center cursor on up/down
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- yank/delete to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- format code (does not work on this version)
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- replace all of word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- go between quickfix list entries
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<Nop>')
vim.keymap.set('n', '<right>', '<Nop>')
vim.keymap.set('n', '<up>', '<Nop>')
vim.keymap.set('n', '<down>', '<Nop>')

