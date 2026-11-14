---
created: 2026-11-14
tool: nvim
tags: [editor]
---
<!-- SYNAPSES -->
- **up:** [nvim_config](nvim_config.md)
***
<!-- /SYNAPSES -->

# Neovim: writing

<!-- TOC -->
- [Prose options](#prose-options)
- [Spell diagnostics](#spell-diagnostics)
<!-- /TOC -->

Neovim as a writing tool: soft wrap + spell for prose filetypes. No plugins, so
this group is always tangled.

Spell files: English ships with the nvim runtime. Norwegian (`nb`) is fetched on
demand by nvim's built-in `spellfile.vim` into `~/.local/share/nvim/site/spell`
the first time `spelllang` includes `nb` (accept the download prompt).

## Prose options

For `markdown`, `text` and `gitcommit` buffers:
- soft wrap at word boundaries, keeping wrapped lines indented
- `textwidth = 80` for `gq`/`gw` reflow, and no `colorcolumn` ruler
- `formatoptions = "qjnl"`: `q` allow `gq` to format, `j` drop comment leader
  on join, `n` recognize numbered lists, `l` don't auto-break long lines while
  typing
- spell for English + Norwegian Bokmål
- `j`/`k` move by display (wrapped) lines, but counts stay linewise (`5j` = 5
  real lines, works with `relativenumber`)
- misspellings published as diagnostics (see [Spell diagnostics](#spell-diagnostics))
```lua tangle:~/.config/nvim/lua/my/writing/init.lua
local spell_diagnostics = require("my.writing.spell-diagnostics")

local group = vim.api.nvim_create_augroup("writing", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "markdown", "text", "gitcommit" },
  callback = function(args)
    local buf = args.buf

    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true

    vim.opt_local.textwidth = 80
    vim.opt_local.colorcolumn = ""

    vim.opt_local.formatoptions = "qjnl"

    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en,nb"

    vim.keymap.set({ "n", "x" }, "j", function()
      return vim.v.count == 0 and "gj" or "j"
    end, { expr = true, buffer = buf, desc = "prose: j by display line" })
    vim.keymap.set({ "n", "x" }, "k", function()
      return vim.v.count == 0 and "gk" or "k"
    end, { expr = true, buffer = buf, desc = "prose: k by display line" })

    spell_diagnostics.attach(buf, group)
  end,
})
```

## Spell diagnostics

Lightweight spell → diagnostics bridge. Native spell (`SpellBad` highlight) has
no gutter/diagnostics, so this publishes misspellings as diagnostics in a
dedicated namespace. They then show up in the sign column, as virtual text and
in the quickfix/location list. It reuses the buffer's `spelllang` dicts, and the
native `SpellBad` highlight stays alongside.

`bad` words are reported as `WARN`, everything else (`rare`, `local`, `caps`) as
`HINT`.
```lua tangle:~/.config/nvim/lua/my/writing/spell-diagnostics.lua
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
```

Debounce refreshes (300ms) per buffer
```lua tangle:~/.config/nvim/lua/my/writing/spell-diagnostics.lua
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
```

Wordlist commands change spelling but don't edit the buffer, so no
`TextChanged` fires. These keys are wrapped to run the native key, then
re-check the buffer. Other buffers pick up the change lazily on `BufEnter`.
(`zg`/`zw`/`zug`/`zuw` persist to the spellfile, `zG`/`zW`/`zuG`/`zuW` are
session-only.)
```lua tangle:~/.config/nvim/lua/my/writing/spell-diagnostics.lua
local wordlist_keys = { "zg", "zw", "zug", "zuw", "zG", "zW", "zuG", "zuW" }
```

Attach the bridge to a buffer. `group` is the augroup the autocmds register
under (shared with the writing `FileType` autocmd). Re-check on text edits
(`TextChanged`/`InsertLeave`) and on `BufEnter` (to pick up wordlist changes
made while another writing buffer was focused).
```lua tangle:~/.config/nvim/lua/my/writing/spell-diagnostics.lua
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
```

