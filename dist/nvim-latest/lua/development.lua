vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

local TS = require("nvim-treesitter")

TS.install({
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
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lang then
      return
    end

    local ok, parsers = pcall(require, "nvim-treesitter.parsers")
    if ok and parsers[lang] then
      TS.install(lang)
      -- TODO: fails if not installed yet
      -- vim.treesitter.start()
      -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      -- vim.wo.foldmethod = "expr"
      -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = TS.get_installed(),
  callback = function(args)
    -- syntax highlighting, provided by Neovim
    vim.treesitter.start()
    -- folds, provided by Neovim
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    -- indentation, provided by nvim-treesitter
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "PackChanged",
	callback = function(ev)
		if ev.data.spec.name == "nvim-treesitter" then
			vim.cmd("TSUpdate")
		end
	end,
})
-- add gitsigns.nvim
vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require('gitsigns').setup({
  current_line_blame = true,
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end, { desc = "Jump to next git [c]hange" })

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end, { desc = "Jump to previous git [c]hange" })

    -- visual mode
    map("v", "<leader>va", function()
	    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "git [a]dd selection" })
    map("v", "<leader>vr", function()
	    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "git [r]eset selection" })

    -- normal mode
    map("n", "<leader>va", gitsigns.stage_hunk, { desc = "git [a]dd hunk" })
    map("n", "<leader>vA", gitsigns.stage_buffer, { desc = "git [A]dd buffer" })
    map("n", "<leader>vr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
    map("n", "<leader>vR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })
    map("n", "<leader>vu", gitsigns.undo_stage_hunk, { desc = "git [u]ndo stage hunk" })
    map("n", "<leader>vp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
    map("n", "<leader>vb", function() gitsigns.blame_line({ full = true }) end, { desc = "git [b]lame line" })
    map("n", "<leader>vB", gitsigns.blame, { desc = "git [B]lame buffer" })
    map("n", "<leader>vtb", gitsigns.toggle_current_line_blame, { desc = "show [b]lame line" })
    map('n', '<leader>vq', gitsigns.setqflist, { desc = "add document changes to [q]uickfix list" })
    map('n', '<leader>vQ', function() gitsigns.setqflist("all") end, { desc = "add all changes to [Q]uickfix list" })

  end
})

-- show lines changed in statusline
function _G.get_git_status_tag()
    -- TODO: show if git repo by e.g. using vim.g.gitsigns_head ??
    local git_status = vim.b.gitsigns_status
    if git_status == nil or #git_status == 0 then
        return ""
    end
    return " [" .. git_status .. "] "
end

vim.o.statusline = vim.o.statusline .. "%{%v:lua.get_git_status_tag()%}"
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
	    "angularls",
	    "bashls",
	    "eslint",
	    "html",
	    "jdtls",
	    "lua_ls",
	    "stylua",
	    "ts_ls",
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			telemetry = {
				enable = false,
			},
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})

-- do not automatically choose first option
vim.cmd("set completeopt+=noselect")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client ~= nil and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

vim.keymap.set("n", "<leader>df", function() vim.lsp.buf.format() end, { desc = "[f]ormat" })
vim.pack.add({
	{ src = "https://github.com/norcalli/nvim-colorizer.lua" },
})
