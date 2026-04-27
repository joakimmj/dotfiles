# Sway

## Config

### Variables

Modifier
```bash tangle:~/.config/sway/config
set $mod Mod4
```

Navigation
```bash tangle:~/.config/sway/config
set $left h
set $down j
set $up k
set $right l
```

Workspaces
```bash tangle:~/.config/sway/config
set $wp1 1:www
set $wp2 2:terminal
set $wp3 3:edit
set $wp4 4:music
set $wp5 5:graphics
set $wp6 6:chat
set $wp7 7
set $wp8 8
set $wp9 9
set $wp10 10
```

Modes
```bash tangle:~/.config/sway/config
set $mode-default "default"
set $mode-resize "Resize windows"
set $mode-layout "[n]ormal  |  [t]abbed   |  [s]tacked  |  [f]loating  |  [F11] fullscreen"
set $mode-move "[Shift] move to workspace  |  [Ctrl] move to display"
set $mode-system "[l]ock  |  log[o]ut  |  [h]ibernate  |  [s]uspend  |  [p]oweroff  |  [r]eboot"
```

Apps
```bash tangle:~/.config/sway/config
set $term wezterm
set $menu rofi -show run
set $menu-daemon rofi -show drun
set $web-browser firefox
set $web-browser-private firefox --private-window
set $file-browser wezterm -e yazi
set $editor wezterm -e nvim
```

Load system-wide defaults
```bash tangle:~/.config/sway/config
include /etc/sway/config-vars.d/*
```

### Input configuration

```bash tangle:~/.config/sway/config
input "*" {
    xkb_layout "us"
    xkb_variant "altgr-intl"
    xkb_options "ctrl:nocaps"
}
input "type:touchpad" {
    natural_scroll enabled
    dwt enabled
    tap enabled
}
```

### Output configuration

Example configuration:
> output HDMI-A-1 resolution 1920x1080 position 1920,0

You can get the names of your outputs by running: swaymsg -t get_outputs

```bash tangle:~/.config/sway/config
output * bg ~/.config/sway/wallpaper.png fill
```

### Idle configuration


This will lock your screen after 300 seconds of inactivity, then turn off
your displays after another 300 seconds, and turn your screens back on when
resumed. It will also lock your screen before your computer goes to sleep.

```bash tangle:~/.config/sway/config
# exec swayidle -w \
#          timeout 300 'swaylock -f -c 000000' \
#          timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
#          before-sleep 'swaylock -f -c 000000'
```

### Font
```bash tangle:~/.config/sway/config
font pango:JetBrainsMono Nerd Font 11
```

### Looks and feels
```bash tangle:~/.config/sway/config
default_border none
default_floating_border pixel 3
titlebar_padding 1
titlebar_border_thickness 0
hide_edge_borders both
default_orientation auto
workspace_layout default

# Base colors
set $bg        #2E3434
set $bg_alt    #3A4141
set $border    #505959
set $fg        #E6ECEC
set $muted     #8A9494

# Accents
set $teal      #4FB3A2
set $blue      #5A9BD4
set $orange    #C97A3D
set $error     #D16D6A

# window colours        border  background text    indicator childBorder
client.focused          $orange  $bg     $fg     $orange   $orange
client.focused_inactive $border  $bg_alt $muted  $border   $border
client.unfocused        $border  $bg     $muted  $border   $border
client.urgent           $error   $error  $fg     $error    $error
client.placeholder      $border  $bg     $fg     $border   $border
client.background       $bg

focus_follows_mouse no
workspace_auto_back_and_forth no
```

### Floating windows
Use Mouse+$super to drag floating windows to their wanted position
```bash tangle:~/.config/sway/config
floating_modifier $mod normal
```

### Autostart
```bash tangle:~/.config/sway/config
# exec_always --no-startup-id chmod 755 ~/config/sway/autostart.sh
# exec_always --no-startup-id chmod 755 ~/config/sway/win_menu.py
# exec_always --no-startup-id chmod 755 ~/config/sway/init_json.sh
# exec_always --no-startup-id chmod 755 ~/config/sway/spotify_info.sh
# exec --no-startup-id ~/config/sway/autostart.sh
# exec_always --no-startup-id i3-msg 'workspace $wp2'
# exec --no-startup-id gnome-terminal
```

### Keybindings

#### Applications

Terminal
```bash tangle:~/.config/sway/config
bindsym $mod+t exec $term
for_window [app_id="term-popup"] floating enable, resize set 80 ppt 80 ppt, border pixel 3
bindsym $mod+Shift+t exec wezterm start --class term-popup
```

Web browser
```bash tangle:~/.config/sway/config
bindsym $mod+w workspace $wp1;exec $web-browser
bindsym Shift+$mod+w exec $web-browser
bindsym Ctrl+$mod+w exec $web-browser-private
```

File browser
```bash tangle:~/.config/sway/config
bindsym $mod+f exec $file-browser
```

Editor
```bash tangle:~/.config/sway/config
bindsym $mod+e workspace $wp3;exec $editor
bindsym Shift+$mod+e exec $editor
```

#### System

Print help
```bash tangle:~/.config/sway/config
for_window [app_id="term-popup-help"] floating enable, resize set 830 px 80 ppt, border pixel 3
bindsym $mod+p exec wezterm start --class term-popup-help -- less ~/.config/sway/keybindings.txt
```

Task manager
```bash tangle:~/.config/sway/config
for_window [app_id="term-popup-task-manager"] floating enable, resize set 80 ppt 80 ppt, border pixel 3
bindsym Ctrl+Alt+Delete exec wezterm start --class term-popup-task-manager -- htop
```

Start app launcher
```bash tangle:~/.config/sway/config
bindsym $mod+Return exec $menu-daemon
bindsym $mod+Shift+Return exec $menu
```

Reload the configuration file
```bash tangle:~/.config/sway/config
bindsym $mod+Shift+c reload
```

Kill focused pane
```bash tangle:~/.config/sway/config
bindsym $mod+Shift+q kill
bindsym Alt+F4 kill
```

Fullscreen focused pane
```bash tangle:~/.config/sway/config
bindsym $mod+F11 fullscreen
```

#### Scratchpad

Sway has a "scratchpad", which is a bag of holding for windows.
You can send windows there and get them back later.

Move the currently focused window to the scratchpad
```bash tangle:~/.config/sway/config
bindsym $mod+Shift+minus move scratchpad
```

Show the next scratchpad window or hide the focused scratchpad window.
If there are multiple scratchpad windows, this command cycles through them.
```bash tangle:~/.config/sway/config
bindsym $mod+minus scratchpad show
```

#### Desktop navigation

Focus pane
```bash tangle:~/.config/sway/config
bindsym $mod+$left focus left
bindsym $mod+Left focus left
bindsym $mod+$down focus down
bindsym $mod+Down focus down
bindsym $mod+$up focus up
bindsym $mod+Up focus up
bindsym $mod+$right focus right
bindsym $mod+Right focus right
```

Move pane
```bash tangle:~/.config/sway/config
bindsym $mod+Shift+$left move left
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+$down move down
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+$up move up
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+$right move right
bindsym $mod+Shift+Right move right
```

Switch to workspace
```bash tangle:~/.config/sway/config
bindsym $mod+1 workspace $wp1
bindsym $mod+2 workspace $wp2
bindsym $mod+3 workspace $wp3
bindsym $mod+4 workspace $wp4
bindsym $mod+5 workspace $wp5
bindsym $mod+6 workspace $wp6
bindsym $mod+7 workspace $wp7
bindsym $mod+8 workspace $wp8
bindsym $mod+9 workspace $wp9
bindsym $mod+0 workspace $wp10

bindsym $mod+CTRL+Right workspace next
bindsym $mod+CTRL+$right workspace next
bindsym ALT+TAB workspace next

bindsym $mod+CTRL+Left workspace prev
bindsym $mod+CTRL+$left workspace prev
bindsym Shift+ALT+TAB workspace prev
```

Move focused pane to workspace
```bash tangle:~/.config/sway/config
bindsym $mod+Shift+1 move container to workspace $wp1; workspace $wp1
bindsym $mod+Shift+2 move container to workspace $wp2; workspace $wp2
bindsym $mod+Shift+3 move container to workspace $wp3; workspace $wp3
bindsym $mod+Shift+4 move container to workspace $wp4; workspace $wp4
bindsym $mod+Shift+5 move container to workspace $wp5; workspace $wp5
bindsym $mod+Shift+6 move container to workspace $wp6; workspace $wp6
bindsym $mod+Shift+7 move container to workspace $wp7; workspace $wp7
bindsym $mod+Shift+8 move container to workspace $wp8; workspace $wp8
bindsym $mod+Shift+9 move container to workspace $wp9; workspace $wp9
bindsym $mod+Shift+0 move container to workspace $wp10; workspace $wp10
```

### Modes

#### System

```bash tangle:~/.config/sway/config
mode $mode-system {
    # bindsym s exec --no-startup-id gksudo pm-suspend, mode $mode-default, exec pkill i3-nagbar
    # bindsym h exec --no-startup-id gksudo pm-hibernate, mode $mode-default, exec pkill i3-nagbar
    # bindsym r exec gksudo reboot
    # bindsym p exec gksudo poweroff
    bindsym l exec swaylock --image ~/.config/sway/wallpaper.png --scaling fill; mode $mode-default
    bindsym o exec swaymsg exit;

    # return to default mode
    bindsym Return mode $mode-default
    bindsym Escape mode $mode-default
}
bindsym $mod+x mode $mode-system
```

#### Resize
Resize window (you can also use the mouse for that)

```bash tangle:~/.config/sway/config
mode $mode-resize {
    bindsym $left resize shrink width 10px
    bindsym Left resize shrink width 10px
    bindsym $down resize grow height 10px
    bindsym Down resize grow height 10px
    bindsym $up resize shrink height 10px
    bindsym Up resize shrink height 10px
    bindsym $right resize grow width 10px
    bindsym Right resize grow width 10px

    # return to default mode
    bindsym Return mode $mode-default
    bindsym Escape mode $mode-default
}
bindsym $mod+r mode $mode-resize
```

#### Desktop layout
```bash tangle:~/.config/sway/config
mode $mode-layout {
    bindsym n layout toggle split
    bindsym t layout tabbed
    bindsym s layout stacking
    bindsym F11 fullscreen
    bindsym f floating toggle ; [floating] resize set 80 ppt 80 ppt ; move position center ; border pixel 3
    bindsym Shift+f focus mode_toggle

    # return to default mode
    bindsym Return mode $mode-default
    bindsym Escape mode $mode-default
}
bindsym $mod+o mode $mode-layout
```

#### Move
```bash tangle:~/.config/sway/config
mode $mode-move  {
    # move focused window
    bindsym $left move left
    bindsym Left move left
    bindsym $down move down
    bindsym Down move down
    bindsym $up move up
    bindsym Up move up
    bindsym $right move right
    bindsym Right move right

    # move focused container to workspace
    bindsym 1 move container to workspace $wp1; workspace $wp1
    bindsym 2 move container to workspace $wp2; workspace $wp2
    bindsym 3 move container to workspace $wp3; workspace $wp3
    bindsym 4 move container to workspace $wp4; workspace $wp4
    bindsym 5 move container to workspace $wp5; workspace $wp5
    bindsym 6 move container to workspace $wp6; workspace $wp6
    bindsym 7 move container to workspace $wp7; workspace $wp7
    bindsym 8 move container to workspace $wp8; workspace $wp8
    bindsym 9 move container to workspace $wp9; workspace $wp9
    bindsym 0 move container to workspace $wp10; workspace $wp10

    bindsym Shift+$left move to workspace prev; workspace prev
    bindsym Shift+Left move to workspace prev; workspace prev
    bindsym Shift+$right move to workspace next; workspace next
    bindsym Shift+Right move to workspace next; workspace next

    # move workspace to display
    bindsym Ctrl+$left move workspace to output left
    bindsym Ctrl+Left move workspace to output left
    bindsym Ctrl+Down move workspace to output down
    bindsym Ctrl+Up move workspace to output up
    bindsym Ctrl+$right move workspace to output right
    bindsym Ctrl+Right move workspace to output right

    # return to default mode
    bindsym Return mode $mode-default
    bindsym Escape mode $mode-default
}
bindsym $mod+m mode $mode-move
```

### Bar

```bash tangle:~/.config/sway/config
bar {
    swaybar_command waybar
    position top
    font pango:JetBrains Mono 15
}
```

### Additional config

Load additional, modular configuration snippets 

```bash tangle:~/.config/sway/config
include /etc/sway/config.d/*
```

## Help text

```text tangle:~/.config/sway/keybindings.txt
====[ KEYBINDINGS  ]============================================================

# programs
<modifier>+t         : Terminal                     (workspace: current)
<modifier>+w         : Web browser                  (workspace: '1:www')
<modifier>+<shift>+w : Web browser                  (workspace: current)
<modifier>+<ctrl>+w  : Private web browser          (workspace: current)

# system
<modifier>+<shift>+c : Reload Sway
<modifier>+<shift>+q : Kill focused window
<alt>+<F4>           : Kill focused window

#--[ (<modifier>+a) APPLICATION  ]---------------------------------------------#

Terminal - t
Web-browser - w (current workspace: Shift+w)
Web-browser Incognito - $ctrl+w
Editor - $super+e (current workspace: Shift+e)
--IDE - $super+i
--Graphic - $super+g (current workspace: Shift+$super+g)
--Spotify - $super+s (current workspace: Shift+$super+s)
--File-browser - $super+f
Dmenu - Space

#--[ SYSTEM  ]-----------------------------------------------------------------#

Volume - $super+v
System menu - $super+x
List windows - $super+Tab
Printscreen - $print
Monitor manager - $super+$f8
Task Manager - Ctrl+Alt+Delete
Reload the configuration file - $super+Shift+c
Restart i3 inplace - $super+Shift+r

#--[ Desktop orientation  ]----------------------------------------------------#

Change focus - $super+[arrows]
Kill focused window - $super+q, $alt+F4
Fullscreen mode - $super+F11
Switch to workspace - $super+[0-9]
Switch to next workspace - $super+$ctrl+Right
Switch to prev workspace - $super+$ctrl+Left

#--[ Modes  ]------------------------------------------------------------------#

Exit mode - Escape, Return
Enter mode
    System - $super + x
    Resize - $super + r
    Layout - $super + l
    Orientation - $super + o
    Move - $super + m
    IDE's - $super + i

================================================================================
q = quit

```
