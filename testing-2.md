---
header_left: Joakim (04.01.2026)
header_center: md-mode.nvim
---

# Generators

## TOC

<!-- TOC -->
- [Generators](#generators)
  - [TOC](#toc)
  - [Table](#table)
    - [Example](#example)
  - [Link](#link)
  - [Reference-style link](#reference-style-link)
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
- [References](#references)
<!-- /TOC -->

---

## Table

### Example

| Header | Header | Header | Header | 
| --- | --- | --- | --- | 
|       |       |       |       | 

| Header | Header | 
| --- | --- | 
|       |       | 


## Link

This is some text [clic](google.no)k [here](hahahahaa). 

[sd](ds)
some text with a link .

some text with a link here.

## Reference-style link

[Emacs][emacs]

[something][something]

This is written in[Neovim][neovim] 

> >> This is written in[Neovim][neovim] 

## Image

![alt text](image-path)

![alt-text](jsdjfsd)
hei

---

## Footnote

Some factual sentence[^3]. Another one[^6].

[^1][^2][^4][^5] 


## Code Block

```python { "tangle": true, "dest": "~/tmp.py" }
print("DS")
```

```python

```


## Block Qoute

> somethin
> somethin
> [!NOTE]
> 
>> somethin
> somethin

## Callouts

GitHub Flavored Markdown (GFM) supports five distinct callout types:
- NOTE
- TIP
- IMPORTANT
- WARNING
- CAUTION

> [!NOTE]
> This is a note callout with important information.

> [!TIP]
> 


> haha
> haha
> haha
> haha


---

# List

## Task list

Some tasks

* [ ] fdf
+ [ ] sdfsdf
1. sdfs
a. 32
a) 3232
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

```python {dest: "~/tmp.py"}
print("haha")
```

```python {dest: ["~/tmp.py", "~/tmp2.py"]}
print("haha")
```

```python {tangle: false}
print("haha")
```

```
print("haha")
```

---

# References

[emacs]: https://www.gnu.org/software/emacs/

[^3]: true

[^1]: a

[^2]: b

[^4]: c

[^5]: d

[something]: haha-haha

[neovim]: jjj

[^6]: true story, bro
