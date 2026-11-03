---@param expr string
---@return boolean # true if expr is a bare JS identifier (valid object shorthand)
local function is_identifier(expr)
  return expr:match("^[%a_$][%w_$]*$") ~= nil
end

---@param expr string
---@param lnum integer? line to insert after, 1-indexed; defaults to the cursor line
local function insert_log(expr, lnum)
  expr = vim.trim(expr)
  if expr == "" then
    return
  end

  lnum = lnum or vim.api.nvim_win_get_cursor(0)[1]

  local file = vim.fn.expand("%:t")
  if file == "" then
    file = "[No Name]"
  end

  local value = is_identifier(expr) and ("{ %s }"):format(expr) or ('{ ["%s"]: %s }'):format(expr, expr)

  local indent = (vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1] or ""):match("^%s*")
  local line = ('%sconsole.log("-- [%s:%d] %s", %s)'):format(indent, file, lnum + 1, expr, value)

  vim.api.nvim_buf_set_lines(0, lnum, lnum, false, { line })
  vim.api.nvim_win_set_cursor(0, { lnum + 1, #indent })
end
---@return string expr
---@return integer lnum # last line of the selection
local function selection()
  local from, to = vim.fn.getpos("v"), vim.fn.getpos(".")
  local region = vim.fn.getregion(from, to, { type = vim.fn.mode() })
  return table.concat(vim.tbl_map(vim.trim, region), " "), math.max(from[2], to[2])
end

vim.api.nvim_create_autocmd("FileType", {
  desc = "console.log scaffolding for JS/TS",
  group = vim.api.nvim_create_augroup("dev-console-log", { clear = true }),
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
  callback = function(args)
    vim.keymap.set("n", "<leader>cl", function()
      insert_log(vim.fn.expand("<cword>"))
    end, { buffer = args.buf, desc = "console [l]og word under cursor" })
    vim.keymap.set("x", "<leader>cl", function()
      local expr, lnum = selection()
      vim.cmd.normal({ vim.keycode("<Esc>"), bang = true })
      insert_log(expr, lnum)
    end, { buffer = args.buf, desc = "console [l]og selection" })
  end,
})
