# Rofi

Application launcher and `dmenu` replacement, used by [sway](sway.md)
(`$menu` → `rofi -show run`, `$menu-daemon` → `rofi -show drun`).

The theme is a horizontal, `dmenu`-style bar using the
[redox](https://github.com/joakimmj/redox.nvim) colors. It is a copy of
[`extras/rofi/redox.rasi`](https://github.com/joakimmj/redox.nvim/blob/main/extras/rofi/redox.rasi)
in `redox.nvim`, so update it from there when the theme changes.

## Config

Enable the `drun` (apps) and `run` (commands) modes, and show the generic name
of apps next to their name. Load the theme from `redox.rasi`.
```css tangle:~/.config/rofi/config.rasi
configuration {
    modi:                       "drun,run";
    show-icons:                 false;
    display-drun:               "Apps";
    display-run:                "";
    display-filebrowser:        "";
    display-window:             "";
    drun-display-format:        "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
    window-format:              "{w} · {c} · {t}";
}

@theme "./redox.rasi"
```

## Theme

### Global properties

Font
```css tangle:~/.config/rofi/redox.rasi
* {
    font: "JetBrains Mono 10";
}
```

Redox colors
- `background`: `bg`
- `background-alt`: `bg_alt` (search entry, buttons, text boxes)
- `foreground`: `fg`
- `selected`: `rust` (selected element, prompt, borders)
- `active`: `teal`
- `urgent`: `red`
```css tangle:~/.config/rofi/redox.rasi
* {
    background:     #2E3434;
    background-alt: #343A3A;
    foreground:     #DCE8E5;
    selected:       #CD8B64;
    active:         #7EC1AE;
    urgent:         #CD8980;
}
```

Map the colors to the variables used by the widgets
```css tangle:~/.config/rofi/redox.rasi
* {
    border-colour:               var(selected);
    handle-colour:               var(selected);
    background-colour:           var(background);
    foreground-colour:           var(foreground);
    alternate-background:        var(background-alt);
    normal-background:           var(background);
    normal-foreground:           var(foreground);
    urgent-background:           var(urgent);
    urgent-foreground:           var(background);
    active-background:           var(active);
    active-foreground:           var(background);
    selected-normal-background:  var(selected);
    selected-normal-foreground:  var(background);
    selected-urgent-background:  var(active);
    selected-urgent-foreground:  var(background);
    selected-active-background:  var(urgent);
    selected-active-foreground:  var(background);
    alternate-normal-background: var(background);
    alternate-normal-foreground: var(foreground);
    alternate-urgent-background: var(urgent);
    alternate-urgent-foreground: var(background);
    alternate-active-background: var(active);
    alternate-active-foreground: var(background);
}
```

Main window: full width bar at the top of the screen (`north`), with real transparency.
```css tangle:~/.config/rofi/redox.rasi
window {
    transparency:                "real";
    location:                    north;
    anchor:                      north;
    fullscreen:                  false;
    width:                       100%;
    x-offset:                    0px;
    y-offset:                    0px;

    enabled:                     true;
    margin:                      0px;
    padding:                     0px;
    border:                      0px solid;
    border-radius:               0px;
    border-color:                @border-colour;
    cursor:                      "default";
    background-color:            @background-colour;
}
```

Main box: prompt, search entry and results laid out horizontally on one line.
```css tangle:~/.config/rofi/redox.rasi
mainbox {
    enabled:                     true;
    spacing:                     5px;
    margin:                      0px;
    padding:                     5px;
    border:                      0px solid;
    border-radius:               0px 0px 0px 0px;
    border-color:                @border-colour;
    background-color:            transparent;
    children:                    [ "prompt", "entry", "listview" ];
    orientation:                 horizontal;
}
```

Input bar, prompt and search entry. Prompt and entry are rounded pills, the prompt in the accent color.
```css tangle:~/.config/rofi/redox.rasi
inputbar {
    enabled:                     true;
    spacing:                     0px;
    margin:                      0px;
    padding:                     0px;
    border:                      0px;
    border-radius:               0px;
    border-color:                @border-colour;
    background-color:            @background-colour;
    text-color:                  @foreground-colour;
    children:                    [ "prompt", "entry" ];
}

prompt {
    enabled:                     true;
    padding:                     5px 10px;
    border:                      0px;
    border-radius:               100%;
    border-color:                @border-colour;
    background-color:            @border-colour;
    text-color:                  @background-colour;
}
textbox-prompt-colon {
    enabled:                     true;
    expand:                      false;
    str:                         "::";
    background-color:            inherit;
    text-color:                  inherit;
}
entry {
    enabled:                     true;
    expand:                      false;
    padding:                     5px 10px;
    width:                       200px;
    border-radius:               100%;
    background-color:            @alternate-background;
    text-color:                  @foreground-colour;
    cursor:                      text;
    placeholder:                 "Search...";
    placeholder-color:           inherit;
    vertical-align:              0.5;
    horizontal-align:            0.5;
}
```

Results list: horizontal, cycling, no scrollbar.
```css tangle:~/.config/rofi/redox.rasi
listview {
    enabled:                     true;
    lines:                       100;
    cycle:                       true;
    dynamic:                     true;
    scrollbar:                   false;
    layout:                      horizontal;
    reverse:                     false;
    fixed-height:                true;
    fixed-columns:               true;

    spacing:                     5px;
    margin:                      0px;
    padding:                     0px;
    border:                      0px solid;
    border-radius:               0px;
    border-color:                @border-colour;
    background-color:            transparent;
    text-color:                  @foreground-colour;
    cursor:                      "default";
}
scrollbar {
    handle-width:                5px ;
    handle-color:                @handle-colour;
    border-radius:               0px;
    background-color:            @alternate-background;
}
```

Result elements (rounded pills), colored by state (normal/urgent/active × normal/selected/alternate).
```css tangle:~/.config/rofi/redox.rasi
element {
    enabled:                     true;
    spacing:                     10px;
    margin:                      0px;
    padding:                     5px 10px;
    border:                      0px solid;
    border-radius:               100%;
    border-color:                @border-colour;
    background-color:            transparent;
    text-color:                  @foreground-colour;
    cursor:                      pointer;
}
element normal.normal {
    background-color:            var(normal-background);
    text-color:                  var(normal-foreground);
}
element normal.urgent {
    background-color:            var(urgent-background);
    text-color:                  var(urgent-foreground);
}
element normal.active {
    background-color:            var(active-background);
    text-color:                  var(active-foreground);
}
element selected.normal {
    background-color:            var(selected-normal-background);
    text-color:                  var(selected-normal-foreground);
}
element selected.urgent {
    background-color:            var(selected-urgent-background);
    text-color:                  var(selected-urgent-foreground);
}
element selected.active {
    background-color:            var(selected-active-background);
    text-color:                  var(selected-active-foreground);
}
element alternate.normal {
    background-color:            var(alternate-normal-background);
    text-color:                  var(alternate-normal-foreground);
}
element alternate.urgent {
    background-color:            var(alternate-urgent-background);
    text-color:                  var(alternate-urgent-foreground);
}
element alternate.active {
    background-color:            var(alternate-active-background);
    text-color:                  var(alternate-active-foreground);
}
element-icon {
    background-color:            transparent;
    text-color:                  inherit;
    size:                        24px;
    cursor:                      inherit;
}
element-text {
    background-color:            transparent;
    text-color:                  inherit;
    highlight:                   inherit;
    cursor:                      inherit;
    vertical-align:              0.5;
    horizontal-align:            0.0;
}
```

Mode switcher buttons
```css tangle:~/.config/rofi/redox.rasi
mode-switcher{
    enabled:                     true;
    spacing:                     10px;
    margin:                      0px;
    padding:                     0px;
    border:                      0px solid;
    border-radius:               0px;
    border-color:                @border-colour;
    background-color:            transparent;
    text-color:                  @foreground-colour;
}
button {
    padding:                     10px;
    border:                      0px solid;
    border-radius:               0px;
    border-color:                @border-colour;
    background-color:            @alternate-background;
    text-color:                  inherit;
    cursor:                      pointer;
}
button selected {
    background-color:            var(selected-normal-background);
    text-color:                  var(selected-normal-foreground);
}
```

Message and error boxes
```css tangle:~/.config/rofi/redox.rasi
message {
    enabled:                     true;
    margin:                      0px;
    padding:                     0px;
    border:                      0px solid;
    border-radius:               0px 0px 0px 0px;
    border-color:                @border-colour;
    background-color:            transparent;
    text-color:                  @foreground-colour;
}
textbox {
    padding:                     5px;
    border:                      0px solid;
    border-radius:               0px;
    border-color:                @border-colour;
    background-color:            @alternate-background;
    text-color:                  @foreground-colour;
    vertical-align:              0.5;
    horizontal-align:            0.0;
    highlight:                   none;
    placeholder-color:           @foreground-colour;
    blink:                       true;
    markup:                      true;
}
error-message {
    padding:                     0px;
    border:                      0px solid;
    border-radius:               0px;
    border-color:                @border-colour;
    background-color:            @background-colour;
    text-color:                  @foreground-colour;
}
```
