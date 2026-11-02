local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.font_size = 12.0
config.font = wezterm.font_with_fallback({
  { family = "JetBrainsMono Nerd Font", weight = "DemiBold" },
  { family = "JetBrains Mono", weight = "DemiBold" },
})
config.color_schemes = {
  ["redox"] = {
    foreground = "#DCE8E5",
    background = "#2E3434",
    cursor_bg = "#FFD7A0",
    cursor_fg = "#2E3434",
    cursor_border = "#FFD7A0",
    selection_bg = "#3F4A4A",
    selection_fg = "#E9F2EF",
    scrollbar_thumb = "#3A4141",
    split = "#3A4141",
    ansi = {
      "#2E3434",
      "#C26E63",
      "#7FB8A4",
      "#D6C38A",
      "#6FAFBD",
      "#B28FA3",
      "#8FC7B7",
      "#DCE8E5",
    },
    brights = {
      "#4A5353",
      "#E08A7F",
      "#A9D6C6",
      "#EBD9A8",
      "#92CAD4",
      "#D3ABC0",
      "#B6E3D5",
      "#F1F6F4",
    },
    tab_bar = {
      background = "#2E3434",
      active_tab = { bg_color = "#3A4141", fg_color = "#E9F2EF", intensity = "Bold" },
      inactive_tab = { bg_color = "#2E3434", fg_color = "#8FA7A3" },
      inactive_tab_hover = { bg_color = "#343A3A", fg_color = "#DCE8E5" },
      new_tab = { bg_color = "#2E3434", fg_color = "#8FA7A3" },
      new_tab_hover = { bg_color = "#343A3A", fg_color = "#E9F2EF" },
    },
  },
}
config.color_scheme = "redox"
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
local background_color = config.color_schemes.redox.background

local function background_layers(color_opacity, image_opacity)
  local layers = {
    { source = { Color = background_color }, width = "100%", height = "100%", opacity = color_opacity },
  }
  if image_opacity then
    table.insert(layers, {
      source = { File = wezterm.config_dir .. "/background.png" },
      width = "Cover",
      height = "Cover",
      horizontal_align = "Center",
      vertical_align = "Middle",
      opacity = image_opacity,
    })
  end
  return layers
end
local background_modes = {
  { name = "image", layers = background_layers(1.0, 0.15) },
  { name = "transparent", layers = background_layers(0.5) },
  { name = "solid", layers = background_layers(1.0) },
}

config.background = background_modes[1].layers
local function toggle_override(window, override, params)
  local overrides = window:get_config_overrides() or {}
  if not overrides[override] then
    overrides[override] = params
  else
    overrides[override] = nil
  end
  window:set_config_overrides(overrides)
end
wezterm.on("toggle-window-decorations", function(window, _)
  toggle_override(window, "window_decorations", "TITLE|RESIZE")
end)
local function current_background_mode(layers)
  if #layers > 1 then
    return 1
  end
  return layers[1].opacity < 1.0 and 2 or 3
end

wezterm.on("cycle-background", function(window, _)
  local overrides = window:get_config_overrides() or {}
  local current = current_background_mode(overrides.background or config.background)
  overrides.background = background_modes[current % #background_modes + 1].layers
  window:set_config_overrides(overrides)
end)
config.disable_default_key_bindings = true
local act = wezterm.action
config.keys = {
  { key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },
  { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("ClipboardAndPrimarySelection") },
  { key = "k", mods = "CTRL|SHIFT", action = act.IncreaseFontSize },
  { key = "j", mods = "CTRL|SHIFT", action = act.DecreaseFontSize },
  { key = "l", mods = "CTRL|SHIFT", action = act.ResetFontSize },
  { key = "n", mods = "CTRL|SHIFT", action = act.SpawnWindow },
  { key = "p", mods = "CTRL|SHIFT", action = act.ActivateCommandPalette },
  { key = "r", mods = "CTRL|SHIFT", action = act.ReloadConfiguration },
  { key = "w", mods = "CTRL|SHIFT", action = act.EmitEvent("toggle-window-decorations") },
  { key = "b", mods = "CTRL|SHIFT", action = act.EmitEvent("cycle-background") },
  { key = "f", mods = "CTRL|SHIFT", action = act.ToggleFullScreen },
  { key = " ", mods = "CTRL|SHIFT", action = act.QuickSelect },
  { key = "F11", action = act.ToggleFullScreen },
}
return config
