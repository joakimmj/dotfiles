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
- Summaries/wrap-ups: SAME terse rules — no \"All green\", no prose recap, no pleasantries. Drift is worst here; self-check before sending.
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
- Summaries/wrap-ups: SAME rules apply — no prose recap, no pleasantries; self-check before sending

Examples:
❌ \"The bug is in line 87 where the token expiry check uses < instead of <=\"
✅ \"Line 87: \\\`<\\\` → \\\`<=\\\`. Token expiry logic.\"

Extreme brevity. Zero fluff."
fi

# Output hook JSON (jq escapes newlines/quotes so the string stays valid JSON)
jq -n --arg ctx "$INSTRUCTIONS" \
  '{hookSpecificOutput: {hookEventName: "SessionStart", additionalContext: $ctx}}'
