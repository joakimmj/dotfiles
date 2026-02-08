---
header: md-mode.nvim
footer: Joakim (04.01.2026)
---

# Generators

## TOC

<!-- TOC -->
- [Generators](#generators)
  - [TOC](#toc)
  - [Table](#table)
    - [Test](#test)
  - [Link](#link)
  - [Image](#image)
  - [Footnote](#footnote)
  - [Code Block](#code-block)
  - [Block Qoute](#block-qoute)
  - [Callouts](#callouts)
- [List](#list)
  - [Task list](#task-list)
- [Presentation](#presentation)
  - [Start presentation](#start-presentation)
- [some other slide](#some-other-slide)
- [Tangle](#tangle)
  - [Some files](#some-files)
<!-- /TOC -->

## Table

### Test

| Header | Header | 
| --- | --- | 
|       |       | 


## Link

Some text with a link [here](google.no).
Some text with a link here.

## Image

![some alt text](hahah)
![haha](haha)

## Footnote

some text[^1] hahah   

[^2]

Link to [Emacs][some-id]

## Code Block

```python
print("haha")
```

## Block Qoute

> This is the first level of the blockquote.
>
>> This is a nested (second level) blockquote. 
>> It is indented further than the first level.
>
> Back to the first level.

## Callouts

GitHub Flavored Markdown (GFM) supports five distinct callout types:
- NOTE
- TIP
- IMPORTANT
- WARNING
- CAUTION

> [!NOTE]
> This is a note callout with important information.

---

# List

## Task list

Some tasks

- [ ] Task 1
- [x] Task 2
- [ ] Task 3

---

# Presentation

## Start presentation

---

# some other slide

hahaha

---

# Tangle

## Some files

```python {dest: "tmp.py"}
print("haha")
```

```python {dest: ["tmp.py", "tmp2.py"]}
print("haha")
```

```python {tangle: false}
print("haha")
```

```
print("haha")
```

[^1]: some reference

[some-id]: https://www.gnu.org/software/emacs/

[^2]: yeah stuff
