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
