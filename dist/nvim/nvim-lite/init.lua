vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.diagnostic.config({
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({ bufnr = bufnr })
    end,
  },
  update_in_insert = false,
  float = {
    source = true,
    focusable = false,
    border = "rounded",
    style = "minimal",
  },
  virtual_lines = false,
  virtual_text = false,
})
vim.keymap.set("n", "<leader>td", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "[t]oggle [d]iagnostic" })
vim.keymap.set("n", "<leader>tl", function()
  local current = vim.diagnostic.config().virtual_lines or false
  vim.diagnostic.config({ virtual_lines = not current })
end, { desc = "[t]oggle virtual [l]ines" })
vim.keymap.set("n", "<leader>tv", function()
  local current = vim.diagnostic.config().virtual_text or false
  vim.diagnostic.config({ virtual_text = not current })
end, { desc = "[t]oggle [v]irtual text" })
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
vim.keymap.set({ "n", "v" }, "<C-p>", '"0p', { desc = "paste from yank register" })
vim.keymap.set("n", "<leader>dr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "[r]eplace word" })
vim.keymap.set("v", "<leader>dr", [["hy:%s/<C-r>h//gI<left><left><left>]], { desc = "[r]eplace selected text" })
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
vim.api.nvim_create_user_command("Make", function(opts)
  vim.cmd("silent make! " .. opts.args)
  vim.cmd("redraw!")
  vim.cmd("botright cwindow")
end, { nargs = "*", complete = "file", desc = "make → quickfix" })
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
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("augroup-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
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
    vim.keymap.set("n", "<leader>X", "<cmd>%!jq '.'<CR>", { buffer = true, desc = "e[X]ecute json formatting" })
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
vim.o.completeopt = "menuone,noselect,noinsert,fuzzy,popup"
local function group(name, fallback)
  local mod = "my." .. name
  local ok, err = pcall(require, mod)
  if ok then
    return
  end

  err = tostring(err)
  local missing = err:find(("module '%s' not found"):format(mod), 1, true) ~= nil
  local msg
  if not missing then
    msg = ("%s failed: %s"):format(mod, err)
  elseif fallback then
    msg = ("%s not found, using fallback"):format(mod)
  end
  if msg then
    vim.schedule(function()
      vim.notify(msg, vim.log.levels.WARN)
    end)
  end

  if fallback then
    fallback()
  end
end
group("editor")
group("writing")
group("theme", function()
  vim.cmd.colorscheme("vim")
end)
group("file-explorer", function()
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
end)
group("dev", function()
  vim.keymap.set("n", "<leader>df", "gg=G", { desc = "[f]ormat" })
end)
