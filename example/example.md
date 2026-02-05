# Example

This is a document for showing the features of `md-tangle`.

## Features

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

json tangle:{"dest":["~/.config/waybar/modules.json"],"tags":["work"]}
lua tangle:{"dest":["~/.config/nvim/init.lua","~/.config/nvim-lite/init.lua"],"tags":["work"]}

## Testing

Should be different files:

### Regular usage

Tangle files without any tags or filters

### Destination override

### Filtered

### Tags

### Filtered and tags

