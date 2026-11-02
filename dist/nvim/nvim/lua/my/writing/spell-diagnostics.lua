local M = {}

local ns = vim.api.nvim_create_namespace("writing_spell")
local timers = {}

local function refresh(buf)
  if not vim.api.nvim_buf_is_valid(buf) or not vim.b[buf].writing_spell then
    return
  end
  local diags = {}
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  for lnum, line in ipairs(lines) do
    for _, m in ipairs(vim.spell.check(line)) do
      local word, kind, col = m[1], m[2], m[3] -- col is 1-based byte index
      diags[#diags + 1] = {
        lnum = lnum - 1,
        col = col - 1,
        end_col = col - 1 + #word,
        severity = (kind == "bad") and vim.diagnostic.severity.WARN or vim.diagnostic.severity.HINT,
        source = "spell",
        message = ("%s: %s"):format(kind, word),
      }
    end
  end
  vim.diagnostic.set(ns, buf, diags)
end
local function schedule(buf)
  if timers[buf] then
    timers[buf]:stop()
  end
  local t = vim.uv.new_timer()
  timers[buf] = t
  t:start(
    300,
    0,
    vim.schedule_wrap(function()
      t:stop()
      t:close()
      timers[buf] = nil
      refresh(buf)
    end)
  )
end
local wordlist_keys = { "zg", "zw", "zug", "zuw", "zG", "zW", "zuG", "zuW" }
function M.attach(buf, group)
  vim.b[buf].writing_spell = true

  vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "InsertLeave", "BufEnter" }, {
    group = group,
    buffer = buf,
    callback = function()
      schedule(buf)
    end,
  })

  for _, key in ipairs(wordlist_keys) do
    vim.keymap.set({ "n", "x" }, key, function()
      local count = vim.v.count > 0 and tostring(vim.v.count) or ""
      -- "nx": no-remap + execute now, so the wordlist is updated before refresh.
      vim.api.nvim_feedkeys(count .. key, "nx", false)
      schedule(buf)
    end, { buffer = buf, desc = "spell: " .. key .. " (+refresh diagnostics)" })
  end

  schedule(buf)
end

return M
