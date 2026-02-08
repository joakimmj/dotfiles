# md-mode.nvim

`md-mode.nvim` is a modern Neovim plugin for an enhanced Markdown editing
experience. It provides a suite of tools to streamline your workflow, from
generating tables of content to advanced code block tangling and a built-in
presentation mode. The plugin is designed to be lightweight, configurable,
and easy to use.

The plugin tries to use `nvim-treesitter` to achieve most of the heavy lifting.

I have some issues I want to fix.

# Testing

## Generate TOC

ok

## Add Table

ok

## Add Link

We have some issues with the add link functionality.

When no text is selected and I run MDAddLink, I do not get prompted for a link
text. It seems like it believes I'm in visual mode and have something selected.
It just asks for the url.

I still have some issues in visual mode:

Test text: `some text with a link here.`

With selected `here` the result is:
`some text with a link [her](google.no)e.`
Should be
`some text with a link [here](google.no).`

And how should I correctly make a keymapping for the visual mode version?

I currently have:
```lua
vim.keymap.set({"n", "v"}, "<leader>ml", md.generator.add_link, { desc = "Add Link" })
```
And this does not see any selection, and thus asks for text and link.

With selected `here` the result is:
`some text with a link [her](google.no)e.`
Should be
`some text with a link [here](google.no).`


With the cursor over the space between `link` and `.` I get:
some text with a link[here](google.no).
`some text with a link[here](google.no).`
Should be
`some text with a link [here](google.no).`

With the cursor over the `.` I get:
`some text with a link . [here](google.no)`
Which is correct

Seems like there is some issue with the rule for when to prefix with space.


Selection style link almost works now:
`some text with a link here.`
with `here` selected I now get:
`some text with a link [her](google.no)e.`

and for not selected I get the exact same issue as I mentioned in previous message

ref.
- cursor at empty space after `link`, I get:
  `some text with a link .` -> `some text with a link [here](google.no) .`
  should be `some text with a link [here](google.no).`
- cursor at `k` in `link`, I get:
  `some text with a link` -> `some text with a lin [here](google.no)k`
  should be `some text with a link [here](google.no)`
`some text with a link [here](google.no) .`



## Add reference style link
I want the same two features when adding reference style links.

- Add link after cursor
  `This is written in (cursor here)` -> `This is written in[Neovim][neovim] `
  Should be:
  `This is written in [Neovim][neovim]`
- If used on selection, use the selection as link text

So if some of the code for adding regular link can be reused, extract those
parts into shared functions for these two features

## Add Image

- Add image on the next line if already text on current line

## Add Footnote

ok

## add code block

ok

## add block qoute

- not working on current line (only if marked or already a block qoute)
- if already block qoute, it add qoute on line above not current

## callouts

not working if triggered from indented qoute
e.g. if done on:
```
> somethin
> somethin
>> somethin (cursor on this line)
> somethin
```
we get:
```
> somethin
> somethin
> [!NOTE]
> 
>> somethin
> somethin
```

## task list

- does not work on numbered list


## Presentation

ok

## Tangle

- I get: Error executing Lua callback: /usr/local/share/nvim/runtime/lua/vim/treesitter.lua:179: attempt to call method 'range' (a nil value)
stack traceback:
        /usr/local/share/nvim/runtime/lua/vim/treesitter.lua:179: in function 'get_range'
        /usr/local/share/nvim/runtime/lua/vim/treesitter.lua:214: in function 'get_node_text'
        ...joakimmj/dev/md-mode.nvim/lua/md-mode/modules/tangle.lua:64: in function 'tangle_code_blocks'
        /home/joakimmj/dev/md-mode.nvim/plugin/md-mode.lua:37: in function </home/joakimmj/dev/md-mode.nvim/plugin/md-mode.lua:28>


# md-mode.nvim

## Changes

I have some changes I want to apply to this plugin:

### Generators

- generate TOC should:
  if TOC exists, update it
  else create it
- generate table should be called "add_table" also it fails with:
  Error executing Lua callback: ...kimmj/dev/md-mode.nvim/lua/md-mode/modules/generator.lua:45: attempt to call field 'insert' (a nil value)
  stack traceback: ...kimmj/dev/md-mode.nvim/lua/md-mode/modules/generator.lua:45: in function <...kimmj/dev/md-mode.nvim/lua/md-mode/modules/generator.lua:32>
- generate link should be called "add_link" also we should end up with the cursor right behind the link, not on a new line
- add footnote does not work as expected.
  - It always generates the footnote "[^1]", if I create a new footnote, it should update the footnote number
  - Also the cursor should end up right after the added footnote
- add code block should:
  - end up with the cursor inside the code block
  - ask if it should be setup for tangle (default: false)

### List

- what is "add_todo_to_list_item" supposed to do?
- what is "add_checkbox_to_list_item" supposed to do?
- toggle_checkbox_status should
  - be renamed to "toggle_task"
  - work as long as the cursor is on the list item (not only if inside the brackets]
  - should toggle between no checkbox, empty checkbox ("[ ]") and checked checkbox ("[x]")

### Presentation

- Margin should be set by setup config (set some sane default)
- Current solution fails with: Error executing Lua callback: ...mj/dev/md-mode.nvim/lua/md-mode/modules/presentation.lua:90: 'for' limit must be a number
stack traceback:
      ...mj/dev/md-mode.nvim/lua/md-mode/modules/presentation.lua:90: in function 'show_slide'
      ...mj/dev/md-mode.nvim/lua/md-mode/modules/presentation.lua:147: in function <...mj/dev/md-mode.nvim/lua/md-mode/modules/presentation.lua:5>

### Tangle

This does not work.. no files are created

### Config

I want a config for if user commands shoudl be added or not. E.g. "addCommands". This should be default false.

### Keymaps

I do not want any keymaps configured in this plugin anymore. I instead want to add to the README how user can create keymaps that only exists if in markdown file.

### Other

Remember to also update the user commands and the README

## New generators

### Add block qoute

add block qoute (if adding block qoute in block qoute it should be nested)
E.g.
> This is the first level of the blockquote.
>
>> This is a nested (second level) blockquote. 
>> It is indented further than the first level.
>
> Back to the first level.


### Add callout

add callout. This method should accept a callout type or if none; ask user which of the configured callout types to use. The default callout types (if not overridden by config) is the GitHub Flavored Markdown (GFM) callout types:
- NOTE
- TIP
- IMPORTANT
- WARNING
- CAUTION

Example of callout:
> [!NOTE]
> This is a note callout with important information.

## Add reference-style link

I want to be able to add a reference-style link.

E.g.
```markdown

I want to talk about [Emacs][emacs]

...
...
...

This is the bottom of the document


[emacs]: https://www.gnu.org/software/emacs/
```

If the reference already exists, do not ask for link.

