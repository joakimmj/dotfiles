---
name: handover
description: >-
  Snapshot the current session's context into a markdown handover file under
  ~/documents/handovers so a fresh Claude session can be brought up to speed by
  reading it. MANUAL TRIGGER ONLY — use exclusively when the user explicitly asks
  to "create a handover", "hand off", "save session context", or similar. Never
  auto-invoke. Optional arg: a slug/name for the file.
---

# Handover

Capture *this* conversation's working context → one markdown file the user can feed
to a new session ("read <path> to get up to speed"). Manual only.

## 1. Determine the slug

- If the user passed an arg → use it (kebab-case it) as `<slug>`.
- Else → derive a short kebab-case topic slug from the conversation (e.g.
  `auth-refactor`, `nix-flake-debug`).

## 2. Compute the date

~~~bash
date +%F   # → YYYY-MM-DD
~~~

Use shell `date` — do not rely on any in-harness clock. Used for the H1 and any
`## UPDATE <date>` sections in the body.

## 3. Ensure the directory

~~~bash
mkdir -p ~/documents/handovers
~~~

## 4. Write the file

Path: `~/documents/handovers/handover-<slug>.md`

Filename is ALWAYS `handover-<slug>.md` (literal `handover-` prefix + kebab slug +
`.md`), whether the slug came from an arg or was auto-derived. Chronology lives in the
content: the H1 date and any `## UPDATE <date>` sections are the only date markers, so
never omit them.

Content — keep it lean, exactly these sections:

~~~markdown
# Handover: <topic>  (<YYYY-MM-DD>)

## Environment & location
- Repo / project root: <absolute path, or "none — not in a repo">
- Working dir at handover time: <absolute path>
- Git branch + state: <branch, dirty/clean, ahead/behind>
- Runtime notes: dev-shells, env vars, services needed to resume

## Goal & current state
- Original task / intent
- Progress so far: done vs pending

## Decisions & next steps
- Key decisions made (+ rationale)
- Open questions
- Explicit next actions for the new session
~~~

**Project-agnostic — the document must stand alone.** The new session may start in
a DIFFERENT cwd, repo, or even outside any project. Therefore:

- Use ABSOLUTE paths everywhere; never rely on an implied/relative cwd.
- State explicitly where the work lives (repo root + branch) so the reader can
  `cd` there themselves — do not assume they are already there.
- Spell out any environment needed to resume (dev-shell, services, env vars).
- Never reference "this project" / "the current repo" implicitly — name it.

Fill from the actual conversation. Be concrete: real paths, branch names, command
results, blockers. The new session has ZERO prior context — write so it can resume
cold from any directory.

### Collisions

Before writing, check whether `handover-<slug>.md` already exists. If it does, use
AskUserQuestion to choose:
- **merge** — append an `## UPDATE <YYYY-MM-DD> — <summary>` section to the existing
  file (lead with `> Read this section first; it supersedes …` when it overrides
  earlier analysis). Keeps one file per subject with a running history.
- **replace** — overwrite the file wholesale.
- **add new** — write to `handover-<slug>-2.md` (increment `-3`, … if taken).

## 5. Report

Print the absolute path written, plus a one-liner:

> Start a new session and tell Claude: `read <path>`
