vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vim.keymap.set('n', '<leader>ss', ':set spell!<CR>', { desc = 'Toggle Spellcheck' })
-- vim.keymap.set('n', '<leader>sn', ']s', { desc = 'Next Spell Error' })
-- vim.keymap.set('n', '<leader>sp', '[s', { desc = 'Previous Spell Error' })
-- vim.keymap.set('n', '<leader>sa', 'zg', { desc = 'Add Word to Dictionary' })
-- vim.keymap.set('n', '<leader>s=', 'z=', { desc = 'Suggest Spellings' })

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
})

vim.diagnostic.config({
  jump = {
    float = true, -- open float when jumping to diagnostic
  },
  update_in_insert = false,
  float = {
    source = true, -- Always show the source of the diagnostic
    focusable = false,
    border = "rounded", -- Use a 'single' line border style (other options: 'rounded', 'double', 'none')
    style = "minimal",
  },
  virtual_lines = false,
  -- virtual_lines = {
  --   current_line = true, -- Only show for current line
  -- },
  virtual_text = false, -- Disable inline virtual text if you prefer only floats
  -- virtual_text = {
  --   current_line = true, -- Only show for current line
  -- },
})
vim.keymap.set("n", "<leader>td", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "[t]oggle [d]iagnostic" })
vim.keymap.set("n", "<C-w>D", function()
  local current = vim.diagnostic.config().virtual_lines or false
  vim.diagnostic.config({ virtual_lines = not current })
end, { desc = "Toggle diagnostics" })
vim.keymap.set("n", "<leader>tl", function()
  local current = vim.diagnostic.config().virtual_lines or false
  vim.diagnostic.config({ virtual_lines = not current })
end, { desc = "[t]oggle virtual [l]ines" })
vim.keymap.set("n", "<leader>tv", function()
  local current = vim.diagnostic.config().virtual_text or false
  vim.diagnostic.config({ virtual_text = not current })
end, { desc = "[t]oggle [v]irtual text" })

-- theme = require("my.theme")
-- theme.setup({ transparent = true, })
-- TODO: <leader>t prefix is used for tmp scratch files today..
-- vim.keymap.set("n", "<leader>tb", theme.toggle_transparancy, { desc = "[t]oggle [b]ackground" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "move line up" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "move line down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "move selection up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "move selection down" })
vim.keymap.set("v", "<", "<gv", { desc = "indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "indent right and reselect" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "join lines and keep cursor position" })
vim.keymap.set("n", "<leader>dw", "<cmd>set wrap!<CR>", { desc = "toggle [w]rap" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move cursor up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move cursor down" })
vim.keymap.set("n", "n", "nzzzv", { desc = "next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "previous search result (centered)" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[y]ank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank rest of line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "[p]aste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<C-p>", "\"0p", { desc = "paste from yank register" })
vim.keymap.set(
	"n",
	"<leader>dr",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "[r]eplace word" }
)
vim.keymap.set(
	"v",
	"<leader>dr",
	[["hy:%s/<C-r>h//gI<left><left><left>]],
	{ desc = "[r]eplace selected text" }
)
vim.keymap.set("n", "<leader>dd", vim.diagnostic.setloclist, { desc = "[d]iagnostic (location list)" })
vim.keymap.set("n", "<leader>wd", vim.diagnostic.setqflist, { desc = "[d]iagnostic (quickfix list)" })
vim.keymap.set(
  "n",
  "<c-j>",
  "<cmd>try | cnext | catch | cfirst | catch | endtry<cr>zz",
  { desc = "go to next quickfix list entry" }
)
vim.keymap.set(
  "n",
  "<c-k>",
  "<cmd>try | cprevious | catch | clast | catch | endtry<cr>zz",
  { desc = "go to previous quickfix list entry" }
)
vim.keymap.set("n", "<C-h>", "<cmd>colder<CR>", { desc = "go to previous quickfix list" })
vim.keymap.set("n", "<C-l>", "<cmd>cnewer<CR>", { desc = "go to next quickfix list" })
vim.keymap.set("n", "<leader>q", function()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  local action = qf_winid > 0 and "cclose" or "copen"
  vim.cmd("botright " .. action)
end, { noremap = true, silent = true, desc = "[q]uickfix list toggle" })
vim.keymap.set("n", "<left>", "<Nop>")
vim.keymap.set("n", "<right>", "<Nop>")
vim.keymap.set("n", "<up>", "<Nop>")
vim.keymap.set("n", "<down>", "<Nop>")
vim.keymap.set("n", "<leader>SS", function()
  vim.cmd([[mksession! .session.vim]])
end, { desc = "[S]ave" })
vim.keymap.set("n", "<leader>SR", function()
  vim.cmd([[source .session.vim]])
end, { desc = "[R]estore" })
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.colorcolumn = "80,120"

vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", leadmultispace = "|   " }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("augroup-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
vim.api.nvim_create_autocmd("VimLeave", {
  desc = "Save session on exit",
  group = vim.api.nvim_create_augroup("augroup-session-manage", { clear = true }),
  callback = function()
    vim.cmd([[silent! mksession! .session.vim]])
  end,
})
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  desc = "Check if file changed on disk",
  group = vim.api.nvim_create_augroup("augroup-file-disk-status", { clear = true }),
  pattern = { "*" },
  command = "if mode() != 'c' | checktime | endif",
})
vim.api.nvim_create_autocmd("FileType", {
  desc = "Lua specific options",
  pattern = "lua",
  group = vim.api.nvim_create_augroup("augroup-lua-options", { clear = true }),
  callback = function()
    vim.keymap.set("n", "<leader>X", "<cmd>source %<CR>", { buffer = true, desc = "e[X]ecute lua file" })
    vim.keymap.set("n", "<leader>x", ":.lua<CR>", { buffer = true, desc = "e[x]ecute lua line" })
    vim.keymap.set("v", "<leader>x", ":lua<CR>", { buffer = true, desc = "e[x]ecute lua selection" })
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  desc = "Json specific options",
  pattern = "json",
  group = vim.api.nvim_create_augroup("augroup-json-options", { clear = true }),
  callback = function()
    vim.keymap.set("n", "<leader>X", [[%!jq '.']], { buffer = true, desc = "e[X]ecute json formatting" })
  end,
})
function _G.get_tabline()
  local s = ""
  for tabnr = 1, vim.fn.tabpagenr("$") do
    local winnr = vim.fn.tabpagewinnr(tabnr)
    local buflist = vim.fn.tabpagebuflist(tabnr)[winnr]
    local bufname = vim.fn.bufname(buflist)
    local bufname_short = vim.fn.fnamemodify(bufname, ":t")
    if #bufname_short == 0 then
      bufname_short = "[No Name]"
    end
    if tabnr == vim.fn.tabpagenr() then
      s = s .. "%#TabLineSel#"
    else
      s = s .. "%#TabLine#"
    end
    s = s .. " " .. tabnr .. ": " .. bufname_short .. " "
  end
  s = s .. "%#TabLineFill#"
  return s
end

vim.o.tabline = "%!v:lua.get_tabline()"
vim.o.statusline = " %f [%{strlen(&fenc)?&fenc:&enc}] [%{&ff}] %y [%{&spelllang}] [0x%04B] "
  .. "%="
  .. " [%n] %l/%L (%p%%), %c "
  .. "%#StatusLineNC#%{&mod?' [+] ':''}%*"
local use_lazy_packages, _ = pcall(require, "my.init-lazy")
if not use_lazy_packages then
  if require("lazy.core.config").plugins["redox.nvim"] == nil then
    require("my.theme")
  end

  vim.g.netrw_bufsettings = "noma nomod nu rnu nobl nowrap ro"
  vim.g.netrw_liststyle = 3
  vim.g.netrw_browse_split = 0
  vim.g.netrw_banner = 0
  vim.g.netrw_winsize = 25

  vim.keymap.set("n", "<leader>we", ":Lex<CR>", { desc = "[e]xplorer" })
  vim.keymap.set(
    "n",
    "<leader>wg",
    [[:vimgrep //j ** | copen<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]],
    { desc = "[g]rep" }
  )
  vim.keymap.set("n", "<leader>wf", ":Lex<CR>", { desc = "[f]iles" })
  vim.keymap.set("n", "<leader><space>", ":ls<CR>:b<Space>", { desc = "[ ] find existing buffers" })
  vim.keymap.set(
    "n",
    "<leader>sw",
    [[:execute "vimgrep /" . expand("<cword>") . "/j **" | cw<CR>]],
    { desc = "current [w]ord" }
  )
end
