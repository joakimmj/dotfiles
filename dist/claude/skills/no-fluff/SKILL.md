---
name: no-fluff
description: Toggle or configure no-fluff speaking mode. Triggers: "toggle no-fluff", "change speaking style", "turn off no-fluff", "switch to terse mode", "enable verbose mode"
argument-hint: [on|off|balanced|terse|verbose]
allowed-tools: [Read, Write, Edit]
---

# No-Fluff Mode Toggle

Control the no-fluff token-efficient speaking style.

- Invoke as `/no-fluff:no-fluff` (plugin skills are namespaced).
- State file: `~/.claude/no-fluff.state.md` (stable path, outside the plugin cache).

## Usage
- `/no-fluff:no-fluff` - Show current status
- `/no-fluff:no-fluff on` - Enable default mode
- `/no-fluff:no-fluff off` - Disable (standard Claude)
- `/no-fluff:no-fluff balanced` - Default: strip fluff, fragments, code-first, full technical detail
- `/no-fluff:no-fluff terse` - Telegraphic: maximum compression, drop articles/pronouns, arrows for causality (code/identifiers/paths exact)
- `/no-fluff:no-fluff verbose` - Same as off

## Instructions

1. **Read state**: Read `~/.claude/no-fluff.state.md`. If missing, create it from the template below.

2. **Parse argument**:
   - No argument → report current `enabled` + `mode`, then stop (no write).
   - `on` → `enabled: true`, `mode: balanced`
   - `off` → `enabled: false`
   - `balanced` → `enabled: true`, `mode: balanced`
   - `terse` → `enabled: true`, `mode: terse`
   - `verbose` → `enabled: false`

3. **Update state**: Edit the frontmatter of `~/.claude/no-fluff.state.md`:
   ~~~yaml
   ---
   enabled: [true|false]
   mode: [balanced|terse|verbose]
   ---
   ~~~

4. **Inform user**: "No-fluff: [mode] (enabled: [true|false]). Restart Claude Code to apply."

5. **Note**: The SessionStart hook only fires at launch — changes require a restart.

## State template
~~~yaml
---
enabled: true
mode: balanced
---

# No-Fluff State

Live state for the no-fluff speaking style. Edit via `/no-fluff:no-fluff` or by hand.

- `enabled`: `true` | `false`
- `mode`: `balanced` | `terse` | `verbose`
~~~
