---
created: 2026-06-08
tool: claude
tags: [ai]
---
<!-- SYNAPSES -->
- **down:** [claude_handover](claude_handover.md), [claude_no_fluff](claude_no_fluff.md), [claude_study_notes](claude_study_notes.md)
***
<!-- /SYNAPSES -->

# Claude

<!-- TOC -->
- [Claude](#claude)
  - [Keybindings](#keybindings)
<!-- /TOC -->

Configuration for [Claude Code](https://docs.claude.com/en/docs/claude-code) — my
local plugins.

```md tangle:~/.claude/CLAUDE.md
# Global Claude memory
```

## Keybindings

Scroll with `j`/`k` in the pane (transcript) view.

```json tangle:~/.claude/keybindings.json
{
  "bindings": [
    {
      "context": "Pane",
      "bindings": { "j": "pane:scrollDown", "k": "pane:scrollUp" }
    }
  ]
}
```
