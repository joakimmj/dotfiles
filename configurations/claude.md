# Claude

Configuration for [Claude Code](https://docs.claude.com/en/docs/claude-code) — my
local plugins.

## Plugin: no-fluff

Token-efficient speaking style: strips conversational fluff while preserving 100%
technical accuracy. A `SessionStart` hook reads a stable state file and injects the
selected style at launch; a namespaced skill toggles it.

Modes:

* `balanced` (default) — strip fluff, fragments, code-first, full technical detail
* `terse` — telegraphic: maximum compression, drop articles/pronouns, arrows for
  causality (code/identifiers/paths kept exact)
* `verbose` — same as off (standard Claude)

### Install

In Claude Code:

* `/plugin marketplace add ~/.claude/plugins/no-fluff`
* `/plugin install no-fluff@no-fluff-local`

Changes require a Claude Code restart (the hook only fires at launch).

### Update

After editing the plugin, bump the `version` in the [plugin manifest](#plugin-manifest)
— Claude Code only treats it as an update when the version changes. Then, in Claude
Code:

* `/plugin marketplace update no-fluff-local`
* `/plugin install no-fluff@no-fluff-local`

As with install, changes require a Claude Code restart (the hook only fires at
launch).

### Usage

```text
/no-fluff:no-fluff            # show current status
/no-fluff:no-fluff on         # enable default (balanced)
/no-fluff:no-fluff off        # disable
/no-fluff:no-fluff balanced   # default mode
/no-fluff:no-fluff terse      # telegraphic mode
/no-fluff:no-fluff verbose    # same as off
```

### State

Live state lives at `~/.claude/no-fluff.state.md`. It is auto-created with
defaults (`enabled: true`, `mode: balanced`) on first run.

## Configuration

### Plugin manifest

```json tangle:~/.claude/plugins/no-fluff/.claude-plugin/plugin.json
{
  "name": "no-fluff",
  "version": "1.0.2",
  "description": "Token-efficient speaking style: strips conversational fluff while preserving technical accuracy. Default mode is high-compression; terse mode is telegraphic.",
  "author": {
    "name": "zero_ir",
    "email": "admin-cloud-0ir@gcloud.storebrand.no"
  }
}
```

### Local marketplace

```json tangle:~/.claude/plugins/no-fluff/.claude-plugin/marketplace.json
{
  "name": "no-fluff-local",
  "owner": { "name": "zero_ir" },
  "plugins": [
    {
      "name": "no-fluff",
      "source": "./",
      "description": "Token-efficient speaking style (no-fluff)."
    }
  ]
}
```

### Hook registration

```json tangle:~/.claude/plugins/no-fluff/hooks/hooks.json
{
  "description": "No-Fluff professional-concise speaking style",
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash \"${CLAUDE_PLUGIN_ROOT}/hooks-handlers/session-start.sh\""
          }
        ]
      }
    ]
  }
}
```

### SessionStart handler

Reads the state file (creating it with defaults if missing), parses the
frontmatter, and emits the style as `additionalContext` via `jq`.

```sh tangle:~/.claude/plugins/no-fluff/hooks-handlers/session-start.sh
#!/usr/bin/env bash
set -euo pipefail

# Stable, writable state path (decoupled from the versioned plugin cache).
STATE_FILE="$HOME/.claude/no-fluff.state.md"

# Create with defaults on first run so the style applies immediately post-install.
if [[ ! -f "$STATE_FILE" ]]; then
  mkdir -p "$(dirname "$STATE_FILE")"
  cat > "$STATE_FILE" << 'INIT'
---
enabled: true
mode: balanced
---

# No-Fluff State

Live state for the no-fluff speaking style. Edit via `/no-fluff:no-fluff` or by hand.

- `enabled`: `true` | `false`
- `mode`: `balanced` | `terse` | `verbose`
INIT
fi

# Extract frontmatter
FRONTMATTER=$(sed -n '/^---$/,/^---$/{ /^---$/d; p; }' "$STATE_FILE")
ENABLED=$(echo "$FRONTMATTER" | grep '^enabled:' | awk '{print $2}')
MODE=$(echo "$FRONTMATTER" | grep '^mode:' | awk '{print $2}')

# Exit if disabled or verbose
[[ "$ENABLED" != "true" ]] && exit 0
[[ "$MODE" == "verbose" ]] && exit 0

# Select instructions based on mode
if [[ "$MODE" == "terse" ]]; then
  INSTRUCTIONS="SPEAKING STYLE: No-Fluff Terse

Maximum compression. Telegraphic style.
- Drop articles, pronouns, filler, pleasantries, hedging
- Fragments only. Arrows (→) for cause/effect
- Abbreviate plain words; NEVER abbreviate code, identifiers, function/API/type names, paths
- Keep 100% technical accuracy: paths, line numbers, errors, code exact
- Code blocks, commit messages, PR text: write NORMALLY
- Auto-clarity: switch to normal prose for security warnings, irreversible-action confirmations, and ambiguous multi-step instructions; resume telegraphic style after

Examples:
❌ \"I'd be happy to help! Let me take a look at that authentication issue.\"
✅ \"Auth middleware bug. Token expiry check use \\\`<\\\` not \\\`<=\\\`. Fix line 87.\"
❌ \"Each render creates a new object reference, so the prop changes and it re-renders.\"
✅ \"New object ref each render → prop change → re-render. Wrap in \\\`useMemo\\\`.\"

Strip everything non-essential."
else
  # Default to balanced
  INSTRUCTIONS="SPEAKING STYLE: No-Fluff (default)

Maximum compression while preserving technical accuracy:
- Strip all conversational elements
- Start with the answer, not preamble
- Minimal transitions between points
- Preserve 100% technical accuracy - never sacrifice correctness for brevity
- Code-first explanations
- Fragments preferred over sentences
- Keep only actionable information: file paths, error messages, code snippets, line numbers

Examples:
❌ \"The bug is in line 87 where the token expiry check uses < instead of <=\"
✅ \"Line 87: \\\`<\\\` → \\\`<=\\\`. Token expiry logic.\"

Extreme brevity. Zero fluff."
fi

# Output hook JSON (jq escapes newlines/quotes so the string stays valid JSON)
jq -n --arg ctx "$INSTRUCTIONS" \
  '{hookSpecificOutput: {hookEventName: "SessionStart", additionalContext: $ctx}}'
```

### Skill

Defines the `/no-fluff:no-fluff` toggle command.

``` tangle:~/.claude/plugins/no-fluff/skills/no-fluff/SKILL.md
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
```
