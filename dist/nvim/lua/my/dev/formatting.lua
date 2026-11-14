vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim" },
})

local conform = require("conform")

conform.setup({
  notify_on_error = false,
  formatters_by_ft = {
    lua = { "stylua" },
    nix = { "nixfmt" },
    go = { "goimports", "gofmt", stop_after_first = true },
    python = { "ruff_organize_imports", "ruff_format" },
    javascript = { "eslint_d", "eslint", "prettierd", "prettier", stop_after_first = true },
    typescript = { "eslint_d", "eslint", "prettierd", "prettier", stop_after_first = true },
  },
})
conform.formatters.injected = {
  options = {
    lang_to_formatters = {
      json = { "jq" },
    },
    ft_parsers = {
      javascript = "babel",
      javascriptreact = "babel",
      typescript = "typescript",
      typescriptreact = "typescript",
    },
  },
}

vim.keymap.set("", "<leader>df", function()
  conform.format({ async = true, lsp_format = "fallback" })
end, { desc = "[f]ormat" })
vim.api.nvim_create_autocmd("FileType", {
  desc = "Go specific options",
  pattern = "go",
  group = vim.api.nvim_create_augroup("augroup-go-options", { clear = true }),
  callback = function()
    vim.opt_local.listchars:append({ tab = "| " })
  end,
})
