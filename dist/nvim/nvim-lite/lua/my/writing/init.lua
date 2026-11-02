local spell_diagnostics = require("my.writing.spell-diagnostics")

local group = vim.api.nvim_create_augroup("writing", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "markdown", "text", "gitcommit" },
  callback = function(args)
    local buf = args.buf

    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true

    vim.opt_local.textwidth = 80
    vim.opt_local.colorcolumn = ""

    vim.opt_local.formatoptions = "qjnl"

    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en,nb"

    vim.keymap.set({ "n", "x" }, "j", function()
      return vim.v.count == 0 and "gj" or "j"
    end, { expr = true, buffer = buf, desc = "prose: j by display line" })
    vim.keymap.set({ "n", "x" }, "k", function()
      return vim.v.count == 0 and "gk" or "k"
    end, { expr = true, buffer = buf, desc = "prose: k by display line" })

    spell_diagnostics.attach(buf, group)
  end,
})
