{ config, pkgs, lib, ... }:

let
  # navigation
  left = "h";
  down = "j";
  up = "k";
  right = "l";

  # workspaces
  wp1 = "1:www";
  wp2 = "2:default";
  wp3 = "3:edit";
  wp4 = "4:music";
  wp5 = "5:graphics";
  wp6 = "6:chat";
  wp7 = "7";
  wp8 = "8";
  wp9 = "9";
  wp10 = "10";

  # modes
  mode-default = "default";
  mode-system = "[l]ock  |  log[o]ut  |  [h]ibernate  |  [s]uspend  |  [p]oweroff  |  [r]eboot]";
  mode-resize = "Resize windows";
  mode-layout = "[n]ormal  |  [t]abbed   |  [s]tacked  |  [f]loating  |  [F11] fullscreen  |  show scratch[p]ad  |  send to scratch[P]ad";
  mode-apps = "[t]erminal  |  [w]eb browser  |  [s]lack  |  [m] spotify";
  mode-dmenu = "[Space] desktop apps  |  [a]ll";
  mode-orientation = "Desktop orientation";
  mode-move = "[Shift] move to workspace  |  [Ctrl] move to display";
in {
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    xwayland = true;

    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      menu = "rofi -show drun";
      focus = {
        forceWrapping = false;
        followMouse = false;
      };
      fonts.names = [ "Jetbrains Mono" ];
      window = {
        hideEdgeBorders = "both";
        titlebar = false;
      };
      defaultWorkspace = "workspace ${wp2}";
      startup = [
        { command = "nm-applet"; }
        { command = "blueman-applet"; }
        { command = "kitty"; }
      ];
      bars = [{
        fonts.size = 15.0;
        command = "waybar";
        position = "top";
      }];
      output = {
        eDP-1 = {
          scale = "1"; # Set HIDP scale (pixel integer scaling)
        };
      };
      input = {
        "*" = {
          xkb_layout = "us";
          xkb_variant = "altgr-intl";
          xkb_options = "ctrl:nocaps";
        };
        "type:touchpad" = {
          natural_scroll = "enabled";
          dwt = "enabled";
          tap = "enabled";
        };
      };
      assigns = {
        # for getting program info, run: `swaymsg -t get_tree`
        "${wp1}" = [];
        "${wp2}" = [];
        "${wp3}" = [];
        "${wp4}" = [
          { class = "Spotify"; }
        ];
        "${wp5}" = [];
        "${wp6}" = [
          { class = "Slack"; }
        ];
        "${wp7}" = [];
        "${wp8}" = [];
        "${wp9}" = [];
        "${wp10}" = [];
      };
      floating = {
        modifier = "${modifier}";
        border = 3;
        titlebar = false;
        criteria = [
          # for getting program info, run: `swaymsg -t get_tree`
          { class = "XTerm"; title= "HELP"; }
          { app_id = ".blueman-manager-wrapped"; }
          { app_id = "pavucontrol"; }
          { app_id = "nm-connection-editor"; }
        ];
      };
      colors = {
        background = "#FFFFFF";
        focused = {
          border = "#4C7899";
          background = "#285577";
          text = "#FFFFFF";
          indicator = "#2E9EF4";
          childBorder = "#285577";
        };
        focusedInactive = {
          border = "#333333";
          background = "#5F676A";
          text = "#FFFFFF";
          indicator = "#484E50";
          childBorder = "#5F676A";
        };
        unfocused = {
          border = "#333333";
          background = "#222222";
          text = "#888888";
          indicator = "#292D2E";
          childBorder = "#222222";
        };
        urgent = {
          border = "#2F343A";
          background = "#900000";
          text = "#FFFFFF";
          indicator = "#900000";
          childBorder = "#900000";
        };
        placeholder = {
          border = "#000000";
          background = "#0C0C0C";
          text = "#FFFFFF";
          indicator = "#000000";
          childBorder = "#0C0C0C";
        };
     };
     modes = {
       "${mode-resize}" = {
         "Down" = "resize grow height 10 px or 10 ppt";
         "Left" = "resize shrink width 10 px or 10 ppt";
         "Right" = "resize grow width 10 px or 10 ppt";
         "Up" = "resize shrink height 10 px or 10 ppt";
         "${down}" = "resize grow height 10 px or 10 ppt";
         "${left}" = "resize shrink width 10 px or 10 ppt";
         "${right}" = "resize grow width 10 px or 10 ppt";
         "${up}" = "resize shrink height 10 px or 10 ppt";

         Escape = "mode '${mode-default}'";
         Return = "mode '${mode-default}'";
       };
       "${mode-layout}" = {
         "n" = "layout toggle split";
         "t" = "layout tabbed";
         "s" = "layout stacking";
         "f" = "floating toggle";
         "F11" = "fullscreen toggle";
         "p" = "scratchpad show";
         "Shift+p" = "move scratchpad";

         Escape = "mode '${mode-default}'";
         Return = "mode '${mode-default}'";
       };
       "${mode-apps}" = {
         # -- web browser
         "w" = "workspace ${wp1};exec firefox; mode '${mode-default}'";
         "Shift+w" = "exec firefox; mode '${mode-default}'";
         "Ctrl+w" = "exec firefox --private-window; mode '${mode-default}'";

         # -- terminal
         "t" = "exec kitty; mode '${mode-default}'";

         # -- chat
         "s" = "exec slack; mode '${mode-default}'";

         # -- music
         "m" = "exec spotify; mode '${mode-default}'";

         Escape = "mode '${mode-default}'";
         Return = "mode '${mode-default}'";
       };
       "${mode-dmenu}" = {
         Space = "exec rofi -show drun; mode '${mode-default}'";
         "a" = "exec rofi -show run; mode '${mode-default}'";

         Escape = "mode '${mode-default}'";
         Return = "mode '${mode-default}'";
       };
       "${mode-system}" = {
         "l" = "exec swaylock --image ~/.config/nixos/programmer-desk-corner.PNG --scaling fill; mode '${mode-default}'";
         "o" = "exec swaymsg exit; mode '${mode-default}'";
         "h" = "exec systemctl hibernate; mode '${mode-default}'";
         "s" = "exec systemctl suspend; mode '${mode-default}'";
         "p" = "exec systemctl poweroff; mode '${mode-default}'";
         "r" = "exec systemctl reboot; mode '${mode-default}'";

         Escape = "mode '${mode-default}'";
         Return = "mode '${mode-default}'";
       };
       "${mode-move}" = {
         Left = "move left";
         Down = "move down";
         Up = "move up";
         Right = "move right";
         "${left}" = "move left";
         "${down}" = "move down";
         "${up}" = "move up";
         "${right}" = "move right";

         "Ctrl+Left" = "move workspace to output left";
         "Ctrl+Down" = "move workspace to output down";
         "Ctrl+Up" = "move workspace to output up";
         "Ctrl+Right" = "move workspace to output right";
         "Ctrl+${left}" = "move workspace to output left";
         "Ctrl+${down}" = "move workspace to output down";
         "Ctrl+${up}" = "move workspace to output up";
         "Ctrl+${right}" = "move workspace to output right";

         "Shift+Right" = "move container to workspace next; workspace next";
         "Shift+Left" = "move container to workspace prev; workspace prev";
         "Shift+${right}" = "move container to workspace next; workspace next";
         "Shift+${left}" = "move container to workspace prev; workspace prev";

         "1" = "move container to workspace ${wp1}; workspace ${wp1}";
         "2" = "move container to workspace ${wp2}; workspace ${wp2}";
         "3" = "move container to workspace ${wp3}; workspace ${wp3}";
         "4" = "move container to workspace ${wp4}; workspace ${wp4}";
         "5" = "move container to workspace ${wp5}; workspace ${wp5}";
         "6" = "move container to workspace ${wp6}; workspace ${wp6}";
         "7" = "move container to workspace ${wp7}; workspace ${wp7}";
         "8" = "move container to workspace ${wp8}; workspace ${wp8}";
         "9" = "move container to workspace ${wp9}; workspace ${wp9}";
         "0" = "move container to workspace ${wp10}; workspace ${wp10}";

         Escape = "mode '${mode-default}'";
         Return = "mode '${mode-default}'";
       };
     };
     # for finding key codes use: `wev`
     #keybindings = lib.mkOptionDefault {
     keybindings = {
       # modes
       "${modifier}+r" = "mode '${mode-resize}'";
       "${modifier}+d" = "mode '${mode-layout}'";
       "${modifier}+a" = "mode '${mode-apps}'";
       "${modifier}+x" = "mode '${mode-system}'";
       "${modifier}+m" = "mode '${mode-move}'";
       "${modifier}+Space" = "mode '${mode-dmenu}'";

       # focus pane
       "${modifier}+Left" = "focus left";
       "${modifier}+Down" = "focus down";
       "${modifier}+Up" = "focus up";
       "${modifier}+Right" = "focus right";
       "${modifier}+${left}" = "focus left";
       "${modifier}+${down}" = "focus down";
       "${modifier}+${up}" = "focus up";
       "${modifier}+${right}" = "focus right";

       # focus workspace
       "${modifier}+1" = "workspace ${wp1}";
       "${modifier}+2" = "workspace ${wp2}";
       "${modifier}+3" = "workspace ${wp3}";
       "${modifier}+4" = "workspace ${wp4}";
       "${modifier}+5" = "workspace ${wp5}";
       "${modifier}+6" = "workspace ${wp6}";
       "${modifier}+7" = "workspace ${wp7}";
       "${modifier}+8" = "workspace ${wp8}";
       "${modifier}+9" = "workspace ${wp9}";
       "${modifier}+0" = "workspace ${wp10}";
       "${modifier}+Ctrl+Left" = "workspace prev";
       "${modifier}+Ctrl+Right" = "workspace next";

       # audio control
       "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
       "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
       "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

       # mic control
       "${modifier}+XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+";
       "${modifier}+XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-";
       "${modifier}+XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

       # brightness
       "XF86MonBrightnessDown" = "exec light -U 10";
       "XF86MonBrightnessUp" = "exec light -A 10";

       # monitors
       "XF86Display" = "exec wdisplays";
       # BIOS sends fn+F8 as super+p for matching display configuration in Windows, thus XF86Display not working anymore...
       "${modifier}+P" = "exec wdisplays";

       # system
       "${modifier}+Shift+c" = "reload";
       "${modifier}+Shift+q" = "kill";
       "Alt+F4" = "kill";

       # programs
       "${modifier}+t" = "exec kitty";
       "${modifier}+w" = "workspace ${wp1};exec firefox";
       "${modifier}+Shift+w" = "exec firefox";
       "${modifier}+Ctrl+w" = "exec firefox --private-window";

       # help
       "${modifier}+question" = "exec xterm -T \"HELP\" -bg black -fg white -ls -e 'cat ~/.config/nixos/keybindings.txt | less'";
     };
   };
  };
}

