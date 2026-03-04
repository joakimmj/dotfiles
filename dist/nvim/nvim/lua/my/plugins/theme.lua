return {
  "joakimmj/redox.nvim",
  priority = 1000,
  init = function()
    vim.cmd.colorscheme("redox")
    vim.keymap.set("n", "<leader>tb", require("redox").toggle_transparency, { desc = "[t]oggle [b]ackground" })
  end,
}
