# Yazi

## Config

```toml tangle:~/.config/yazi/yazi.toml
[manager]
show_hidden = true # toggle with '.'
show_symlink = true
ratio = [2, 2, 4]
linemode = "size"

[preview]
wrap = "yes"
tab_size = 2
```

## Keymap

```toml tangle:~/.config/yazi/keymap.toml
```

## Theme

```toml tangle:~/.config/yazi/theme.toml
[flavor]
dark  = "my-theme"
light  = "my-theme"
```

### Flavor

```toml tangle:~/.config/yazi/flavors/my-theme.yazi/flavor.toml
[manager]
cwd = { fg = "#A6E3A1" }

# Hovered
hovered         = { reversed = true }
preview_hovered = { underline = true }

# Find
find_keyword  = { fg = "#f9e2af", bold = true, italic = true, underline = true }
find_position = { fg = "#f5c2e7", bg = "reset", bold = true, italic = true }

# Marker
marker_copied   = { fg = "#a6e3a1", bg = "#a6e3a1" }
marker_cut      = { fg = "#f38ba8", bg = "#f38ba8" }
marker_marked   = { fg = "#94e2d5", bg = "#94e2d5" }
marker_selected = { fg = "#f9e2af", bg = "#f9e2af" }

# Tab
tab_active   = { reversed = true }
tab_inactive = {}
tab_width    = 1

# Count
count_copied   = { fg = "#1e1e2e", bg = "#a6e3a1" }
count_cut      = { fg = "#1e1e2e", bg = "#f38ba8" }
count_selected = { fg = "#1e1e2e", bg = "#f9e2af" }

# Border
border_symbol = "│"
border_style  = { fg = "#7f849c" }

[mode]
normal_main = { fg = "#1e1e2e", bg = "#A6E3A1", bold = true }
normal_alt  = { fg = "#A6E3A1", bg = "#313244" }

# Select mode
select_main = { fg = "#1e1e2e", bg = "#a6e3a1", bold = true }
select_alt  = { fg = "#a6e3a1", bg = "#313244" }

# Unset mode
unset_main = { fg = "#1e1e2e", bg = "#f2cdcd", bold = true }
unset_alt  = { fg = "#f2cdcd", bg = "#313244" }

[status]
separator_open  = ""
separator_close = ""

# Progress
progress_label  = { fg = "#ffffff", bold = true }
progress_normal = { fg = "#A6E3A1", bg = "#45475a" }
progress_error  = { fg = "#f38ba8", bg = "#45475a" }

# Permissions
perm_sep   = { fg = "#7f849c" }
perm_type  = { fg = "#A6E3A1" }
perm_read  = { fg = "#f9e2af" }
perm_write = { fg = "#f38ba8" }
perm_exec  = { fg = "#a6e3a1" }

[pick]
border   = { fg = "#A6E3A1" }
active   = { fg = "#f5c2e7", bold = true }
inactive = {}

[input]
border   = { fg = "#A6E3A1" }
title    = {}
value    = {}
selected = { reversed = true }

[completion]
border = { fg = "#A6E3A1" }

[tasks]
border  = { fg = "#A6E3A1" }
title   = {}
hovered = { fg = "#f5c2e7", underline = true }

[which]
mask            = { bg = "#313244" }
cand            = { fg = "#94e2d5" }
rest            = { fg = "#9399b2" }
desc            = { fg = "#f5c2e7" }
separator       = "  "
separator_style = { fg = "#585b70" }

[help]
on      = { fg = "#94e2d5" }
run     = { fg = "#f5c2e7" }
hovered = { reversed = true, bold = true }
footer  = { fg = "#313244", bg = "#cdd6f4" }

[notify]
title_info  = { fg = "#a6e3a1" }
title_warn  = { fg = "#f9e2af" }
title_error = { fg = "#f38ba8" }

[filetype]
rules = [
	# Images
	{ mime = "image/*", fg = "#94e2d5" },

	# Media
	{ mime = "{audio,video}/*", fg = "#f9e2af" },

	# Archives
	{ mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}", fg = "#f5c2e7" },

	# Documents
	{ mime = "application/{pdf,doc,rtf}", fg = "#a6e3a1" },

	# Fallback
	{ name = "*", fg = "#A9B1D6" },
	{ name = "*/", fg = "#A6E3A1" }
]
```

