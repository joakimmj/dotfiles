---
created: 2026-11-14
tool: nvim
tags: [editor, plugin]
---
<!-- SYNAPSES -->
- **up:** [nvim_config](nvim_config.md)
***
<!-- /SYNAPSES -->

# Neovim: theme

Load the [redox](https://github.com/joakimmj/redox.nvim) theme. Fallback (if
this group fails) is `colorscheme vim`.
```lua tangle:~/.config/nvim/lua/my/theme/init.lua
vim.pack.add({
  { src = "https://github.com/joakimmj/redox.nvim" },
})

vim.cmd.colorscheme("redox")
vim.keymap.set("n", "<leader>tb", require("redox").toggle_transparency, { desc = "[t]oggle [b]ackground" })
```

