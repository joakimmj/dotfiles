# Vim motions

## Normal mode

### Movement

| Key           | Action                                            |
|---------------|---------------------------------------------------| 
| h             | move cursor left                                  |
| j             | move cursor down                                  |
| k             | move cursor up                                    |
| l             | move cursor right                                 | 
| w             | move to start of next word                        |
| W             | move to start of next word (inc. punctuation)     |
| b             | move to start of previous word                    |
| B             | move to start of previous word (inc. punctuation) | 
| 0             | move to start of line                             |
| $             | move to end of line                               |
| H             | move to first line in document                    |
| G             | move to last line in document                     |
| <C-w> h/j/k/l | move between windows                              |
| gt            | next tab                                          |
| gT            | previous tab                                      |
| {i}gt         | go to tab in position i                           |
| 1gt           | go to first tab                                   |
| 1gT           | go to last tab                                    |
| *             | next occurrence of word under cursor              |
| #             | previous occurrence of word under cursor          |

### Window manipulation

| Key     | Action                  |
|---------|-------------------------| 
| <C-w> v | split window vertical   |
| <C-w> s | split window horizontal |
| <C-w> c | close current window    |
| <C-w> o | close other window      |

### Actions

| Key            | Action                     |
|----------------|----------------------------|
| i              | insert before cursor       |
| I              | insert at start of line    |
| a              | insert after cursor        | 
| A              | insert at end of line      |
| o              | add new line below cursor  |
| O              | add new line above cursor  |
| r              | replace single character   |
| cc             | replace line               |
| cw             | replace to end of word     |
| c$             | replace to end of line     |
| s              | substitute character       |
| S              | substitute line            |
| u              | undo                       |
| <C-u>          | redo                       |
| y              | yank/copy                  |
| yy             | yank a line                |
| yw             | yank a word                |
| y$             | yank to end of line        |
| p              | paste after cursor         |
| P              | paste before cursor        |
| dd             | delete/cut line            |
| dw             | delete a word              |
| D              | delete to end of line      |
| x              | delete a character         |
| /<search-term> | Search for "<search-term>" |

### Search

| Key | Action         |
|-----|----------------| 
| n   | next match     |
| N   | previous match |

## Visual mode

| Key   | Action                     |
|-------|----------------------------|
| v     | enter visual mode          | 
| V     | enter linewise visual mode |
| <C-v> | start visual block mode    |
| >     | shift text left            |
| <     | shift text right           |
| >>    | shift left by shiftwidth   |
| <<    | shift right by shiftwidth  |
| ==    | auto-indent line           |
| ~     | change case                |

## Insert mode


# UPDATE FROM QUICK REF
https://vimhelp.org/quickref.txt.html

## Left-right motions

> N is used to indicate an optional count that can be given before the command.

|   | Key     | Action                                                                         |
|---|---------|--------------------------------------------------------------------------------|
| N | h       | left (also: CTRL-H, <BS>, or <Left> key)                                       |
| N | l       | right (also: <Space> or <Right> key)                                           |
|   | 0       | to first character in the line (also: <Home> key)                              |
|   | ^       | to first non-blank character in the line                                       |
| N | $       | to the last character in the line (N-1 lines lower) (also: <End> key)          |
|   | g0      | to first character in screen line (differs from "0" when lines wrap)           |
|   | g^      | to first non-blank character in screen line (differs from "^" when lines wrap) |
| N | g$      | to last character in screen line (differs from "$" when lines wrap)            |
|   | gm      | to middle of the screen line                                                   |
|   | gM      | to middle of the line                                                          |
| N | \|      | to column N (default: 1)                                                       |
| N | f{char} | to the Nth occurrence of {char} to the right                                   |   
| N | F{char} | to the Nth occurrence of {char} to the left                                    |  
| N | t{char} | till before the Nth occurrence of {char} to the right                          |
| N | T{char} | till before the Nth occurrence of {char} to the left                           |
| N | ;       | repeat the last "f", "F", "t", or "T" N times                                  |
| N | ,       | repeat the last "f", "F", "t", or "T" N times in  opposite direction           |

## Up-down motions

k N k up N lines (also: CTRL-P and <Up>)
j N j down N lines (also: CTRL-J, CTRL-N, <NL>, and <Down>)

- N - up N lines, on the first non-blank character

+ N + down N lines, on the first non-blank character (also:
  CTRL-M and <CR>)
  _ N _ down N-1 lines, on the first non-blank character
  G N G goto line N (default: last line), on the first
  non-blank character
  gg N gg goto line N (default: first line), on the first
  non-blank character
  N% N % goto line N percentage down in the file; N must be
  given, otherwise it is the % command
  gk N gk up N screen lines (differs from "k" when line wraps)
  gj N gj down N screen lines (differs from "j" when line wraps)

------------------------------------------------------------------------------
Q_tm Text object motions

w N w N words forward
W N W N blank-separated WORDs forward
e N e forward to the end of the Nth word
E N E forward to the end of the Nth blank-separated WORD
b N b N words backward
B N B N blank-separated WORDs backward
ge N ge backward to the end of the Nth word
gE N gE backward to the end of the Nth blank-separated WORD

)    N  )        N sentences forward
(    N  (        N sentences backward
} N } N paragraphs forward
{ N { N paragraphs backward
]]    N  ]]        N sections forward, at start of section
[[    N  [[        N sections backward, at start of section
][    N  ][        N sections forward, at end of section
[]    N  []        N sections backward, at end of section
[(    N  [(        N times back to unclosed '('
[{ N  [{ N times back to unclosed '{'
[m N  [m N times back to start of method (for Java)
[M N  [M		N times back to end of method (for Java)
])    N  ])        N times forward to unclosed ')'
]} N  ]} N times forward to unclosed '}'
]m N  ]m N times forward to start of method (for Java)
]M N  ]M N times forward to end of method (for Java)
[# N  [# N times back to unclosed "#if" or "#else"
]# N  ]# N times forward to unclosed "#else" or "#endif"
[star N  [*        N times back to start of comment "/*"
]star N  ]*        N times forward to end of comment "*/"
