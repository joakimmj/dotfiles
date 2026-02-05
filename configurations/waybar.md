# waybar

## md-tangle

### Current features

Tangle
- allow multiple destinations

CLI
```
-h, --help            show this help message and exit
--version             print version
-v, --verbose         show output
-f, --force           force overwrite of files
-d DESTINATION, --destination DESTINATION
                      overwrite output destination
-s SEPARATOR, --separator SEPARATOR
                      separator for tangle destinations (default=',')
```

### Required features

Tangle
- allow muliple destinations
- allow filtering on tags
  - include tags
  - only tangle tags?
- flags:
  - always append ??
  - always force ??

CLI
```
-h, --help            show this help message and exit
--version             print version
-v, --verbose         show output
-f, --force           force overwrite of files
-d DESTINATION, --destination DESTINATION
                      overwrite output destination
-t TAGS, --tags TAGS
                      include tagged code blocks (separator: ',')
-filter TAGS/FILES
                      only tangle the code blocks with tags/filenames (separator: '|')
//-s SEPARATOR, --separator SEPARATOR
//                      separator for tangle destinations (default=',')
```

- override destination
- force
- include-tags

```json tangle:{"dest":["~/.config/waybar/modules.json"],"tags":["work"]}

```

```lua tangle:{"dest":["~/.config/nvim/init.lua","~/.config/nvim-lite/init.lua"],"tags":["work"]}

```

## Modules

```json tangle:~/.config/waybar/modules.json
{
    "network": {
        "format": "{ifname}",
        "format-wifi": " {signalStrength}%",
        "format-ethernet": "  {ifname}",
        "format-disconnected": "Disconnected ⚠",
        "tooltip-format": " {ifname} via {gwaddri}",
        "tooltip-format-wifi": "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\nUp: {bandwidthUpBits} Down: {bandwidthDownBits}",
        "tooltip-format-ethernet": " {ifname}\nIP: {ipaddr}\n up: {bandwidthUpBits} down: {bandwidthDownBits}",
        "tooltip-format-disconnected": "Disconnected",
        "max-length": 50,
        "on-click": "nm-connection-editor"
    },
    "pulseaudio": {
        "format": "{volume}% {icon} {format_source}",
        "format-bluetooth": "{volume}% {icon} {format_source}",
        "format-bluetooth-muted": " {icon} {format_source}",
        "format-muted": " {format_source}",
        "format-source": "{volume}% ",
        "format-source-muted": "",
        "format-icons": {
            "headphone": "",
            "hands-free": "",
            "headset": "",
            "phone": "",
            "portable": "",
            "car": "",
            "default": ["", "", ""]
        },
        "on-click": "pavucontrol"
    },
    "bluetooth": {
        "format": " {status}",
        "format-disabled": "",
        "format-off": "",
        "interval": 30,
        "on-click": "blueman-manager",
        "tooltip-format-connected": "Connected devices: {num_connections} connected\n\n{device_enumerate}",
        "tooltip-format-enumerate-connected": "{device_alias}",
        "tooltip-format-enumerate-connected-battery": "{device_alias}\t| Battery life: {device_battery_percentage}%",
        "format-no-controller": ""
    },
    "idle_inhibitor": {
        "format": "{icon}",
        "format-icons": {
            "activated": "",
            "deactivated": ""
        }
    },
    "tray": {
        "spacing": 10
    },
    "clock": {
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
        "format-alt": "{:%Y-%m-%d}"
    },
    "cpu": {
        "format": " {usage}% | ",
        "tooltip": false
    },
    "memory": {
        "format": " {}% | "
    },
    "temperature": {
        "format": " {temperatureC}°C | ",
        "critical-threshold": 80
    },
    "backlight": {
        "format": "{icon} {percent}% | ",
        "format-icons": ["", "", "", "", "", "", "", "", ""]
    },
    "battery": {
        "states": {
            "good": 80,
            "warning": 30,
            "critical": 15
        },
        "format": "{icon} {capacity}% ({time})",
        "format-charging": " {capacity}%",
        "format-plugged": " {capacity}%",
        "format-alt": "{time} {icon}",
        "format-time": "{H}h {M}m",
        "format-icons": ["", "", "", "", ""]
    }
}
```

### Sway

```json tangle:~/.config/waybar/modules-sway.json
{
  "sway/workspaces": {
    "disable-scroll": true,
    "all-outputs": true,
    "format": "{icon} {value}",
    "format-icons": {
      "www": "",
      "terminal": "",
      "edit": "",
      "music": "",
      "chat": "",
      "urgent": "",
      "focused": "",
      "default": "",
      "high-priority-named": [
        "www",
        "terminal",
        "edit"
      ]
    }
  },
  "sway/scratchpad": {
    "format": "{icon} {count}",
    "show-empty": true,
    "format-icons": [""],
    "tooltip": true,
    "tooltip-format": "{app}: {title}"
  },
  "sway/mode": {
    "format": "{}",
    "align": 0
  },
  "sway/window": {
    "format": "{title}",
    "max-length": 50,
    "rewrite": {
      "bash": " bash"
    }
  }
}
```

### Groups

```json tangle:~/.config/waybar/modules-groups.json
{
  "group/hardware": {
    "orientation": "horizontal",
    "modules": [
      "cpu",
      "memory",
      "temperature",
      "backlight",
      "battery"
    ]
  },
  "custom/tools": {
    "format": "",
    "tooltip-format": "Tools",
    "on-scroll-up": "true",
    "on-scroll-down": "true"
  },
  "group/tools": {
    "orientation": "inherit",
    "drawer": {
      "transition-duration": 300,
      "children-class": "not-tools",
      "transition-left-to-right": false
    },
    "modules": [
      "custom/tools",
      "custom/calculator",
      "custom/appmenu"
    ]
  }
}
```

### Custom
```json tangle:~/.config/waybar/modules-custom.json
{
  "custom/calculator": {
    "format": "",
    "on-click": "gnome-calculator",
    "tooltip-format": "Open calculator"
  },
  "custom/appmenu": {
    "format": "Apps",
    "on-click": "rofi -show drun",
    "on-click-right": "rofi -show run",
    "tooltip-format": "Left: Open the application launcher\nRight: Show all keybindings"
  }
}
```

## Config

```json tangle:~/.config/waybar/config.jsonc
{
    "position": "top",
    "height": 34, // Waybar height (to be removed for auto height)
    "spacing": 4, // Gaps between modules (4px)

    // Load Modules
    "include": [
        "~/.config/waybar/modules.json",
        "~/.config/waybar/modules-custom.json",
        "~/.config/waybar/modules-sway.json",
        "~/.config/waybar/modules-groups.json"
    ],

    // Choose the order of the modules
    "modules-left": [
        "idle_inhibitor",
        "sway/mode",
        "sway/workspaces",
        "sway/scratchpad",
        "sway/window"
    ],
    "modules-center": [
    ],
    "modules-right": [
        "group/tools",
        "group/hardware",
        "pulseaudio",
        "bluetooth",
        "network",
        "tray",
        "sway/language",
        "clock"
    ]
}
```

## Styling

```css tangle:~/.config/waybar/style.css
* {
  font-family: "JetBrainsMono Nerd Font", monospace;
  font-size: 14px;
  font-weight: bold;
  border: none;
  border-radius: 6px;
}

window#waybar {
  background: #2E3434;
  color: #DCE8E5;
}

tooltip {
  background: #3A4141;
  color: #AFC3BE;
}

/* Spacing */
#bluetooth,
#clock,
#custom-appmenu,
#custom-calculator,
#custom-tools,
#hardware,
#idle_inhibitor,
#language,
#network,
#pulseaudio,
#scratchpad,
#tray,
#window,
#workspaces button {
  padding: 0 10px;
  margin: 4px 2px;
}

#idle_inhibitor {
  margin-left: 5px;
  margin-right: 5px;
}

#clock {
  margin-right: 5px;
}

#mode {
  background: #E3A36F;
  color: #2E3434;
  font-size: 14px;
  font-weight: bold;
  border-radius: 0px;
  padding: 0 10px;
  margin-right: -800px; /* allow "floating" over next modules */
  min-width: 800px;
}

/* Colors */
#bluetooth,
#clock,
#hardware,
#idle_inhibitor,
#language,
#network,
#pulseaudio,
#scratchpad,
#tray,
#workspaces button.focused,
#workspaces button:hover {
  background: #3A4141;
  color: #AFC3BE;
}

#battery.critical { color: #CD8980; }
#battery.warning { color: #E3B86F; }
#custom-tools { background: #C97A3D; }
#workspaces button.focused { border-bottom: 2px solid #C97A3D; }
#workspaces button.urgent { color: #CD8980; }
```
