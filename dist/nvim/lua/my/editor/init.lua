vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/catgoose/nvim-colorizer.lua" },
})
require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  signs_staged = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  signs_staged_enable = true,
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end, { desc = "Jump to next git [c]hange" })

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end, { desc = "Jump to previous git [c]hange" })

    map("v", "<leader>va", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "git [a]dd selection" })
    map("v", "<leader>vr", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "git [r]eset selection" })

    map("n", "<leader>va", gitsigns.stage_hunk, { desc = "git [a]dd hunk" })
    map("n", "<leader>vr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
    map("n", "<leader>vA", gitsigns.stage_buffer, { desc = "git [A]dd buffer" })
    map("n", "<leader>vu", gitsigns.undo_stage_hunk, { desc = "git [u]ndo stage hunk" })
    map("n", "<leader>vR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })
    map("n", "<leader>vp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
    map("n", "<leader>vb", gitsigns.blame_line, { desc = "git [b]lame line" })
    map("n", "<leader>vtb", gitsigns.toggle_current_line_blame, { desc = "show [b]lame line" })
  end,
})
local wk = require("which-key")
wk.setup({
  plugins = {
    spelling = { enabled = false },
  },
  icons = {
    keys = {
      Up = "<Up> ",
      Down = "<Down> ",
      Left = "<Left> ",
      Right = "<Right> ",
      C = "<C-…> ",
      M = "<M-…> ",
      D = "<D-…> ",
      S = "<S-…> ",
      CR = "<CR> ",
      Esc = "<Esc> ",
      ScrollWheelDown = "<ScrollWheelDown> ",
      ScrollWheelUp = "<ScrollWheelUp> ",
      NL = "<NL> ",
      BS = "<BS> ",
      Space = "<Space> ",
      Tab = "<Tab> ",
      F1 = "<F1>",
      F2 = "<F2>",
      F3 = "<F3>",
      F4 = "<F4>",
      F5 = "<F5>",
      F6 = "<F6>",
      F7 = "<F7>",
      F8 = "<F8>",
      F9 = "<F9>",
      F10 = "<F10>",
      F11 = "<F11>",
      F12 = "<F12>",
    },
  },
})
wk.add({
  { "<leader>c", group = "[c]ode", mode = { "n", "x" } },
  { "<leader>ct", group = "[t]oggles", mode = { "n", "x" } },
  { "<leader>cg", group = "[g]oto", mode = { "n", "x" } },
  { "<leader>d", group = "[d]ocument" },
  { "<leader>s", group = "[s]earch" },
  { "<leader>S", group = "[S]ession" },
  { "<leader>t", group = '[t]emporary ("scratch") files' },
  { "<leader>w", group = "[w]orkspace" },
  { "<leader>v", group = "[v]ersion control", mode = { "n", "v" } },
  { "<leader>vt", group = "[t]oggles", mode = { "n", "v" } },
})
require("colorizer").setup()
