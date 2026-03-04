return {
  "joakimmj/md-tangle.nvim",
  ft = "markdown",
  config = function()
    local md = require("md-tangle")
    md.setup({
      prompt_tags = true,
    })

    vim.keymap.set("n", "<leader>cmi", function()
      md.insert_block()
    end, { buffer = true, desc = "[m]arkdown [i]nsert code block" })
    vim.keymap.set("n", "<leader>cmt", function()
      md.tangle()
    end, { buffer = true, desc = "[m]arkdown [t]angle current file" })
    vim.keymap.set("n", "<leader>cmT", function()
      md.tangle({ force = true })
    end, { buffer = true, desc = "[m]arkdown force [T]angle current file" })
  end,
}
