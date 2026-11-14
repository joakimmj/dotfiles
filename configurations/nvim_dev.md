---
created: 2026-11-14
tool: nvim
tags: [editor, plugin]
---
<!-- SYNAPSES -->
- **up:** [nvim_config](nvim_config.md)
***
<!-- /SYNAPSES -->

# Neovim: dev

<!-- TOC -->
- [mason](#mason)
- [LSP](#lsp)
- [treesitter](#treesitter)
- [formatting](#formatting)
- [lazydev](#lazydev)
- [fidget](#fidget)
<!-- /TOC -->

Neovim as a dev tool: LSP, completion, treesitter, formatting, Lua dev and LSP
UI. Each submodule `vim.pack.add`s the plugins it owns.

`mason` must be loaded first, since it prepends its bin dir to `PATH` (needed
when `vim.lsp.enable()` resolves each server's `cmd`).
```lua tangle:~/.config/nvim/lua/my/dev/init.lua
require("my.dev.mason")
require("my.dev.lsp")
require("my.dev.treesitter")
require("my.dev.formatting")
require("my.dev.lazydev")
require("my.dev.fidget")
```

## mason

Tool installer ([mason.nvim](https://github.com/mason-org/mason.nvim) +
[mason-tool-installer](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim)).
Installs language servers and formatters into `stdpath("data")/mason` and
prepends its bin dir to `vim.env.PATH`. (On NixOS these come from `neovim.nix`
instead.)

`mason-lspconfig` is deliberately NOT installed: servers are configured by hand
in [lsp](#lsp) (`vim.lsp.config` + `vim.lsp.enable`), and `mason-lspconfig` v2
would fight that by auto-enabling servers itself. The tradeoff is that
`mason-tool-installer` can no longer translate lspconfig server names into
mason package names, so `ensure_installed` uses **mason package names**.

`nixd` is not in the mason registry. Drop a release binary from
[nixd](https://github.com/nix-community/nixd) on `PATH` and [lsp](#lsp) picks
it up automatically. Until then `nixfmt` handles `.nix` files.
```lua tangle:~/.config/nvim/lua/my/dev/mason.lua
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
```

## LSP

Native LSP (`vim.lsp.config` + `vim.lsp.enable`).
[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) is kept ONLY as a
data pack of `lsp/*.lua` presets that `vim.lsp.enable()` discovers on the
runtimepath. The `vim.lsp.config()` calls below layer per-server overrides on
top.
```lua tangle:~/.config/nvim/lua/my/dev/lsp.lua
vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
})
```

Snippet navigation for LSP-provided snippets (native `vim.snippet`)
```lua tangle:~/.config/nvim/lua/my/dev/lsp.lua
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
```

Manually trigger native completion. Other built-in completions: `<C-x><C-o>`
(omni), `<C-x><C-f>` (file system), `<C-x><C-l>` (matching line).
```lua tangle:~/.config/nvim/lua/my/dev/lsp.lua
vim.keymap.set("i", "<C-Space>", function()
  vim.lsp.completion.get()
end, { desc = "trigger completion" })
```

When an LSP attaches to a buffer:
- set buffer-local LSP keymaps
- enable native LSP-driven completion (replaces `nvim-cmp`)
- highlight references of the word under the cursor (on `CursorHold`)
- add toggle for inlay hints, if the server supports them
```lua tangle:~/.config/nvim/lua/my/dev/lsp.lua
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
```

Per-server overrides. Empty tables just enable the nvim-lspconfig preset.
- `angularls`: deliberately NO `cmd` override. The preset resolves the ts/ng
  probe locations itself from `exepath("ngserver")` plus the project
  `root_dir`, which is exactly what we want with a mason-installed `ngserver`.
- `basedpyright`: Python types/completion/hover. Finds the project's `.venv`
  through its `pyrightconfig.json` (`venvPath`/`venv`), which also overrides
  these settings.
- `ruff`: Python lint diagnostics + quick fixes. Hover is off, since
  basedpyright's is better.
- `gopls`:
  - `staticcheck`: extra checks (staticcheck's analyzers run inside gopls, no
    separate binary)
  - `gofumpt = false`: stay on plain `gofmt`, which is what projects' `gofmt`
    checks enforce
  - `hints`: only shown when toggled with `<leader>cth`. Handy while learning
    Go's type inference.
```lua tangle:~/.config/nvim/lua/my/dev/lsp.lua
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
```

`nixd` is not available through mason. Only enable it when the binary is on
`PATH`, so `.nix` buffers stay quiet otherwise.
```lua tangle:~/.config/nvim/lua/my/dev/lsp.lua
if vim.fn.executable("nixd") == 1 then
  servers.nixd = {}
end
```

Register overrides and enable all servers
```lua tangle:~/.config/nvim/lua/my/dev/lsp.lua
for name, cfg in pairs(servers) do
  vim.lsp.config(name, cfg)
end
vim.lsp.enable(vim.tbl_keys(servers))
```

## treesitter

[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) `main`
branch (the 0.11+ rewrite), used only as a parser installer. Highlighting is
native via `vim.treesitter.start`. The legacy `master` branch is unsupported
on Neovim 0.12 (and crashed on markdown with `node:range()`).

Parsers to install
```lua tangle:~/.config/nvim/lua/my/dev/treesitter.lua
local ENSURE = {
  "bash",
  "c",
  "comment",
  "diff",
  "html",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "query",
  "vim",
  "vimdoc",
  "javascript",
  "typescript",
  "java",
  "nix",
  "json",
  "kotlin",
  "css",
  "go",
  "gomod",
  "gosum",
  "gowork",
  "python",
}
```

Build hook: install/update parsers whenever the plugin itself is installed or
updated by `vim.pack`. Registered BEFORE `vim.pack.add` so it fires on the very
first install.
```lua tangle:~/.config/nvim/lua/my/dev/treesitter.lua
vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("nvim-treesitter-pack", { clear = true }),
  callback = function(ev)
    local d = ev.data
    if d and d.spec and d.spec.name == "nvim-treesitter" and (d.kind == "install" or d.kind == "update") then
      pcall(function()
        require("nvim-treesitter").install(ENSURE)
      end)
    end
  end,
})

vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})
```

Best-effort: install any missing parsers (e.g. after a data wipe where the
plugin is already cloned, so `PackChanged` does not fire)
```lua tangle:~/.config/nvim/lua/my/dev/treesitter.lua
pcall(function()
  local installed = require("nvim-treesitter.config").get_installed("parsers")
  local have = {}
  for _, p in ipairs(installed) do
    have[p] = true
  end
  local missing = vim.tbl_filter(function(lang)
    return not have[lang]
  end, ENSURE)
  if #missing > 0 then
    require("nvim-treesitter").install(missing)
  end
end)
```

The `main` branch does NOT auto-enable highlighting, so start it per buffer
```lua tangle:~/.config/nvim/lua/my/dev/treesitter.lua
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("nvim-treesitter-highlight", { clear = true }),
  pattern = {
    "bash",
    "sh",
    "c",
    "diff",
    "html",
    "lua",
    "markdown",
    "query",
    "vim",
    "help",
    "javascript",
    "typescript",
    "java",
    "nix",
    "json",
    "kotlin",
    "css",
    "go",
    "gomod",
    "gosum",
    "gowork",
    "python",
  },
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})
```

## formatting

Formatting via [conform.nvim](https://github.com/stevearc/conform.nvim).
`stylua`, `prettierd`, `eslint_d`, `nixfmt`, `goimports` and `ruff` are
installed by [mason](#mason), `jq` comes from the system.

No `format_on_save`: formatting is manual only, via `<leader>df`. For `go`,
`goimports` (= `gofmt` + add/remove imports) is used, with plain `gofmt` (ships
with Go) as fallback.
```lua tangle:~/.config/nvim/lua/my/dev/formatting.lua
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
```

Format code blocks injected in other filetypes (e.g. `json` in markdown)
```lua tangle:~/.config/nvim/lua/my/dev/formatting.lua
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
```

Draw tabs as indent guides in `Go` buffers. `gofmt` indents with tabs (the
runtime ftplugin sets `noexpandtab`), so render them like `leadmultispace` does
for spaces instead of a `»` on every line.
```lua tangle:~/.config/nvim/lua/my/dev/formatting.lua
vim.api.nvim_create_autocmd("FileType", {
  desc = "Go specific options",
  pattern = "go",
  group = vim.api.nvim_create_augroup("augroup-go-options", { clear = true }),
  callback = function()
    vim.opt_local.listchars:append({ tab = "| " })
  end,
})
```

## lazydev

[lazydev](https://github.com/folke/lazydev.nvim) configures `lua_ls` for Neovim
config/plugin development (completion, annotations and signatures of the nvim
API). [luvit-meta](https://github.com/Bilal2453/luvit-meta) supplies types for
`vim.uv`, loaded when the word `vim.uv` is found.
```lua tangle:~/.config/nvim/lua/my/dev/lazydev.lua
vim.pack.add({
  { src = "https://github.com/Bilal2453/luvit-meta" },
  { src = "https://github.com/folke/lazydev.nvim" },
})

require("lazydev").setup({
  library = {
    { path = "luvit-meta/library", words = { "vim%.uv" } },
  },
})
```

## fidget

LSP progress UI ([fidget.nvim](https://github.com/j-hui/fidget.nvim))
```lua tangle:~/.config/nvim/lua/my/dev/fidget.lua
vim.pack.add({
  { src = "https://github.com/j-hui/fidget.nvim" },
})

require("fidget").setup({
  notification = {
    window = {
      winblend = 0,
    },
  },
})
```

