# bat

## Theme

The [redox](https://github.com/joakimmj/redox.nvim) theme is copied to bat's
theme dir. `assets/redox.tmTheme` is a copy of
[`extras/bat/redox.tmTheme`](https://github.com/joakimmj/redox.nvim/blob/main/extras/bat/redox.tmTheme)
in `redox.nvim`, so update it from there when the theme changes.
<!-- TANGLE_CP:../assets/redox.tmTheme tangle:~/.config/bat/themes/redox.tmTheme -->

bat only picks up new themes after rebuilding its cache:
```bash
bat cache --build
```

## Config

Set theme
``` tangle:~/.config/bat/config
--theme="redox"
```

Show line numbers, Git modifications and file header (but no grid)
``` tangle:~/.config/bat/config
--style="numbers,changes,header"
```

Always show colors
``` tangle:~/.config/bat/config
--color=always
```

Always show decorations
``` tangle:~/.config/bat/config
--decorations=always
```

