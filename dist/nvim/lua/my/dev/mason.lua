vim.pack.add({
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
})

require("mason").setup()

require("mason-tool-installer").setup({
  integrations = { ["mason-lspconfig"] = false },
  ensure_installed = {
    -- language servers
    "lua-language-server",
    "bash-language-server",
    "typescript-language-server",
    "angular-language-server",
    "html-lsp",
    "gopls",
    "basedpyright",
    "ruff",
    -- formatters
    "stylua",
    "prettierd",
    "eslint_d",
    "nixfmt",
    "goimports",
  },
})
