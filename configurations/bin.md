# bin

## Cheat sheet

Cheat sheet (ref. https://cht.sh)
``` tangle:~/bin/cht-sh
#!/usr/bin/env bash

echo "---[ C-c to quit, ':help' for help ]-------------------------------------------"
while true
do
  read -p "curl https://cht.sh/" query
  curl -s cht.sh/"$query" | less -R
done
```

Cheat sheet for programming languages (e.g. `golang`, `java`, etc.)
``` tangle:~/bin/cht-lang
#!/usr/bin/env bash

read -p "Enter programming language: " language
read -p "Enter query: " query
curl -s cht.sh/"${language}${query:+/$query}" | less -R
```

Cheat sheet for core utils (e.g. `cat`, `curl`, etc.)
``` tangle:~/bin/cht-util
#!/usr/bin/env bash

read -p "Enter core util: " util
read -p "Enter query: " query
curl -s cht.sh/"${util}${query:+~$query}" | less -R
```
