# bin

## Cheat sheet

Cheat sheet for programming languages (e.g. `golang`, `java`, etc.)
``` tangle:~/bin/cht-lang
#!/usr/bin/env bash

read -p "Enter programming language: " language
read -p "Enter query: " query
curl -s cht.sh/"$language"/"$query" | less -R
```

Cheat sheet for core utils (e.g. `cat`, `curl`, etc.)
``` tangle:~/bin/cht-util
#!/usr/bin/env bash

read -p "Enter core util: " util
read -p "Enter query: " query
curl -s cht.sh/"$util"~"$query" | less -R
```
