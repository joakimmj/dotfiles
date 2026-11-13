---
created: 2018-11-11
tool: xmodmap
tags: [desktop]
---
# Xmodmap

## Set Caps Lock to Ctrl
```bash tangle:~/.Xmodmap
keycode 66 = Control_L
clear Lock
add Control = Control_L
```
