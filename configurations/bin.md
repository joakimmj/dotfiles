# bin

## Cheat sheet

Cheat sheet (ref. https://cht.sh)
```bash tangle:~/bin/cht-sh
#!/usr/bin/env bash

echo "---[ C-c to quit, ':help' for help ]-------------------------------------------"
while true
do
  read -p "curl https://cht.sh/" query
  curl -s cht.sh/"$query" | less -R
done
```

Cheat sheet for programming languages (e.g. `golang`, `java`, etc.)
```bash tangle:~/bin/cht-lang
#!/usr/bin/env bash

read -p "Enter programming language: " language
read -p "Enter query: " query
curl -s cht.sh/"${language}${query:+/$query}" | less -R
```

Cheat sheet for core utils (e.g. `cat`, `curl`, etc.)
```bash tangle:~/bin/cht-util
#!/usr/bin/env bash

read -p "Enter core util: " util
read -p "Enter query: " query
curl -s cht.sh/"${util}${query:+~$query}" | less -R
```

## JWT

Decode JWT token
```js tangle:~/bin/decode-jwt
#!/bin/node

function parseJwt(token) {
    const base64Url = token?.split('.')?.[1];
    const base64 = base64Url?.replace(/-/g, '+')?.replace(/_/g, '/');
    const jsonPayload = decodeURIComponent(
        Buffer.from(base64, 'base64')
            .toString()
            .split('')
            .map(c => '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2))
            .join('')
    );
    console.dir(JSON.parse(jsonPayload), {depth: null});
}

const token = process.argv?.[2];
try {
    parseJwt(token);
} catch {
    console.warn(`Invalid JWT token [token='${token}']`);
}
```

## `fzf` previewer

```bash tangle:~/bin/fzf-preview
#!/usr/bin/env bash

if type bat >/dev/null; then
    bat "$@"
else
    cat "$@"
fi
```

