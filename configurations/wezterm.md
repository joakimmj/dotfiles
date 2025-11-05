# WexTerm

## Windows

```lua tangle:/mnt/c/Users/0IR/.wezterm.lua
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Use WSL
config.wsl_domains = {
    {
        name = 'WSL:Ubuntu',
        distribution = 'Ubuntu',
        username = "zero_ir",
        default_cwd = "/home/zero_ir/"
    },
}
config.default_domain = 'WSL:Ubuntu'

-- Theme
config.font = wezterm.font 'JetBrains Mono'
config.color_scheme = 'catppuccin-mocha'
config.colors = {
    background = '#2E3434'
}

-- Keymaps
config.disable_default_key_bindings = true

local act = wezterm.action
config.keys = {
    { key = 'c', mods = 'CTRL', action = act.CopyTo 'ClipboardAndPrimarySelection' },
    { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
    { key = 'n', mods = 'CTRL', action = act.SpawnWindow },
    { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
    { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
    { key = '0', mods = 'CTRL', action = act.ResetFontSize },
    { key = 'p', mods = 'CTRL', action = act.ActivateCommandPalette },
    { key = 'r', mods = 'CTRL|SHIFT', action = act.ReloadConfiguration },
    { key = ' ', mods = 'SHIFT|CTRL', action = act.QuickSelect },
    { key = 'F11', action = act.ToggleFullScreen },
}

-- Title bar
config.enable_tab_bar = false
config.window_decorations = 'TITLE|RESIZE'

return config
```

