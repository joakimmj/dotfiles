---
name: study-notes
description: >-
  Turn the current conversation into Zettelkasten-style learning notes (one
  markdown file per topic) under ~/documents/notes, with tag frontmatter and up/down
  cross-links to related notes. MANUAL TRIGGER ONLY — use exclusively when the user
  explicitly asks to make study/learning notes from the conversation. Never
  auto-invoke. Optional args: explicit topic name(s).
---

# Study notes

Distill learnable topics from *this* conversation into per-topic notes the user can
study and grow over time. Manual only.

## 1. Identify candidate topics

- If the user passed topic(s) as args → use those.
- Else → split the conversation into natural topic boundaries (one concept per
  note; prefer several focused notes over one broad one).

## 2. Confirm per topic

Use AskUserQuestion to confirm WHICH candidate topics to actually write. Do not
generate notes blindly — let the user drop/keep topics first.

## 3. Ensure the directory

~~~bash
mkdir -p ~/documents/notes
~~~

## 4. Scan existing notes for linking (before writing)

~~~bash
ls ~/documents/notes/
grep -rl '<tag-or-keyword>' ~/documents/notes/ 2>/dev/null
~~~

Find related existing notes (by tag or filename topic). These become `*up*`
(broader/parent) or `*down*` (narrower/children) links. Also link notes created in
THIS batch to each other where a hierarchy exists.

## 5. Write one file per confirmed topic

Path: `~/documents/notes/<subject>_<topic>.md`

- `<subject>` = the note's **first tag** (broadest/primary subject), kebab-case.
  Order `tags` so the broadest subject is first (e.g. `java`, `istio`, `kubernetes`,
  `software-design`, `cli`). Files group by subject; search notes by tag.
- `<topic>` is kebab-case.
- **No subject repetition**: if `<topic>` starts with `<subject>-`, strip that leading
  segment (subject `java` + topic `java-dynamic-proxy-exceptions` →
  `java_dynamic-proxy-exceptions.md`, NOT `java_java-…`).

Format exactly:

~~~markdown
---
tags:
  - tag1
  - tag2
  - tag3
---

- *up*: [java-lists](java_lists.md)
- *down*: [optional-map](java_optional-map.md), [optional-orelse](java_optional-orelse.md)

---

# <topic>

<content>
~~~

Format rules:
- Frontmatter holds `tags` ONLY (no `up:`/`down:` keys).
- Links live in the body. Relative filenames within `~/documents/notes/`.
- `*down*` may list multiple, comma-separated.
- ALWAYS emit BOTH `*up*` and `*down*` lines, even when there are no links — leave
  them empty (`- *up*: ` / `- *down*: `). Never drop either line.

### Collisions

Before writing, check (via step 4's `ls`) whether `<subject>_<topic>.md` already
exists. If it does, use AskUserQuestion to choose:
- **merge** — fold the new material into the existing note; keep its frontmatter and
  `*up*`/`*down*` links, add any new tags. Preferred when it's the same topic.
- **replace** — overwrite the file wholesale.
- **add new** — write to `<subject>_<topic>-2.md` (increment `-3`, … if taken).

### Content

- Source: distill what was discussed in the conversation AND enrich with your own
  knowledge for fuller learning material.
- Depth: decide per topic — teaching depth (explanations, cause→effect, code
  examples, gotchas) vs concise reference, whichever fits. Code blocks normally.

## 6. Update reciprocal links in existing notes

Links are bidirectional — a one-way link is a bug. For every link from a NEW note
to an EXISTING note, edit that existing note to add the reciprocal:

- new note's `*up*: [E]` → open E, add the new note to E's `*down*` line.
- new note's `*down*: [E]` → open E, add the new note to E's `*up*` line.

When adding to a non-empty `*down*` line, append comma-separated; keep existing
links. Touch only the `*up*`/`*down*` lines — never alter an existing note's
frontmatter or content. (New-note ↔ new-note pairs are already mutually linked from
step 5; this step is only for pre-existing files.)

## 7. Report

- Every created note path.
- Every existing note edited for reciprocal links.
