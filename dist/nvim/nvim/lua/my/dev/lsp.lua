vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
})
vim.keymap.set({ "i", "s" }, "<C-l>", function()
  if vim.snippet.active({ direction = 1 }) then
    return vim.snippet.jump(1)
  end
end, { desc = "snippet jump forward" })
vim.keymap.set({ "i", "s" }, "<C-h>", function()
  if vim.snippet.active({ direction = -1 }) then
    return vim.snippet.jump(-1)
  end
end, { desc = "snippet jump backward" })
vim.keymap.set("i", "<C-Space>", function()
  vim.lsp.completion.get()
end, { desc = "trigger completion" })
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("<leader>wr", vim.lsp.buf.rename, "[r]ename")
    map("<leader>ca", vim.lsp.buf.code_action, "[a]ction", { "n", "x" })
    map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
    map("<leader>cd", function()
      vim.diagnostic.open_float({ scope = "line" })
    end, "show [d]iagnostic")

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
        end,
      })
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map("<leader>cth", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, "inlay [h]ints")
    end
  end,
})
local servers = {
  bashls = {},
  html = {},
  ts_ls = {},
  angularls = {},
  basedpyright = {
    settings = {
      basedpyright = {
        analysis = { typeCheckingMode = "standard" },
      },
    },
  },
  ruff = {
    on_attach = function(client)
      client.server_capabilities.hoverProvider = false
    end,
  },
  gopls = {
    settings = {
      gopls = {
        staticcheck = true,
        analyses = { unusedparams = true, unusedwrite = true, nilness = true, shadow = true },
        gofumpt = false,
        usePlaceholders = true,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          constantValues = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        telemetry = { enable = false },
        completion = { callSnippet = "Replace" },
      },
    },
  },
}
if vim.fn.executable("nixd") == 1 then
  servers.nixd = {}
end
for name, cfg in pairs(servers) do
  vim.lsp.config(name, cfg)
end
vim.lsp.enable(vim.tbl_keys(servers))
