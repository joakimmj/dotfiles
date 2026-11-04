vim.pack.add({
  { src = "https://github.com/folke/snacks.nvim" },
})

require("snacks").setup({
  picker = {
    ui_select = true,
    layout = {
      preset = function()
        return vim.o.columns >= 120 and "ivy" or "ivy_split"
      end,
    },
    focus = "input",
    sources = {
      explorer = {
        layout = {
          preset = "sidebar",
          preview = true,
          layout = {
            width = 80,
          },
        },
        focus = "list",
      },
    },
  },
  explorer = {
    replace_netrw = true,
  },
  gitbrowse = {},
  indent = {},
})

local map = vim.keymap.set
map("n", "<leader>we", function()
  Snacks.picker.explorer()
end, { desc = "[e]xplorer" })
map("n", "<leader>wf", function()
  Snacks.picker.files({ hidden = true, ignored = true })
end, { desc = "[f]iles" })
map("n", "<leader>wg", function()
  Snacks.picker.grep()
end, { desc = "[g]rep" })
map("n", "<leader>ws", function()
  Snacks.picker.lsp_workspace_symbols()
end, { desc = "[s]ymbols" })
map("n", "<leader>ds", function()
  Snacks.picker.lsp_symbols()
end, { desc = "[s]ymbols" })
map("n", "<leader>sh", function()
  Snacks.picker.help()
end, { desc = "[h]elp" })
map("n", "<leader>sm", function()
  Snacks.picker.marks()
end, { desc = "[m]arks" })
map("n", "<leader>sk", function()
  Snacks.picker.keymaps()
end, { desc = "[k]eymaps" })
map("n", "<leader>sf", function()
  Snacks.picker.smart({ hidden = true })
end, { desc = "[f]iles" })
map("n", "<leader>ss", function()
  Snacks.picker.pickers()
end, { desc = "[s]elect picker" })
map("n", "<leader>sw", function()
  Snacks.picker.grep_word()
end, { desc = "current [w]ord" })
map("n", "<leader>sd", function()
  Snacks.picker.diagnostics()
end, { desc = "[d]iagnostics" })
map("n", "<leader>sr", function()
  Snacks.picker.resume()
end, { desc = "[r]esume" })
map("n", "<leader>s.", function()
  Snacks.picker.recent()
end, { desc = "recent files ('.' for repeat)" })
map("n", "<leader><space>", function()
  Snacks.picker.buffers()
end, { desc = "[ ] find existing buffers" })
map("n", "<leader>/", function()
  Snacks.picker.grep({ glob = vim.fn.expand("%:t"), need_search = false })
end, { desc = "[/] fuzzily search in current buffer" })
map("n", "<leader>s/", function()
  Snacks.picker.grep_buffers()
end, { desc = "[/] open files" })
map("n", "<leader>sn", function()
  Snacks.picker.files({ cwd = vim.fn.stdpath("config"), hidden = true })
end, { desc = "[n]eovim files" })
map("n", "<leader>vd", function()
  Snacks.picker.git_status()
end, { desc = "git [d]iff" })
map("n", "<leader>vo", function()
  Snacks.gitbrowse()
end, { desc = "[o]pen repo destination" })
map("n", "gd", function()
  Snacks.picker.lsp_definitions()
end, { desc = "[g]oto [d]efinition" })
map("n", "gr", function()
  Snacks.picker.lsp_references()
end, { desc = "[g]oto [r]eferences", nowait = true })
map("n", "gI", function()
  Snacks.picker.lsp_implementations()
end, { desc = "[g]oto [I]mplementation" })
map("n", "<leader>cgt", function()
  Snacks.picker.lsp_type_definitions()
end, { desc = "[t]ype definition" })
map("n", "<leader>tt", function()
  Snacks.scratch()
end, { desc = "[t]oggle scratch" })
map("n", "<leader>ts", function()
  Snacks.scratch.select()
end, { desc = "[s]elect scratch" })
