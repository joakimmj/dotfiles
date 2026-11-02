vim.pack.add({
  { src = "https://github.com/joakimmj/redox.nvim" },
})

vim.cmd.colorscheme("redox")
vim.keymap.set("n", "<leader>tb", require("redox").toggle_transparency, { desc = "[t]oggle [b]ackground" })
