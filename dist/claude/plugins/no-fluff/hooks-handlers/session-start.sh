#!/usr/bin/env bash
set -euo pipefail

# Hook event name from caller (SessionStart, SubagentStart); defaults to SessionStart.
EVENT_NAME="${1:-SessionStart}"

# Stable, writable state path (decoupled from the versioned plugin cache).
STATE_FILE="$HOME/.claude/no-fluff.state.md"

# Create with defaults on first run so the style applies immediately post-install.
# Uses atomic write (mktemp + mv) to avoid races when parallel sessions start.
if [[ ! -f "$STATE_FILE" ]]; then
  mkdir -p "$(dirname "$STATE_FILE")"
  TMPFILE=$(mktemp "${STATE_FILE}.XXXXXX")
  cat > "$TMPFILE" << 'INIT'
---
enabled: true
mode: balanced
---

# No-Fluff State

Live state for the no-fluff speaking style. Edit via `/no-fluff:no-fluff` or by hand.

- `enabled`: `true` | `false`
- `mode`: `balanced` | `terse` | `verbose`
INIT
  mv "$TMPFILE" "$STATE_FILE"
fi

# Extract frontmatter
FRONTMATTER=$(sed -n '/^---$/,/^---$/{ /^---$/d; p; }' "$STATE_FILE")
ENABLED=$(echo "$FRONTMATTER" | grep '^enabled:' | awk '{print $2}')
MODE=$(echo "$FRONTMATTER" | grep '^mode:' | awk '{print $2}')

# Exit if disabled or verbose
[[ "$ENABLED" != "true" ]] && exit 0
[[ "$MODE" == "verbose" ]] && exit 0

# Record which mode was injected at session start so UserPromptSubmit can detect
# mid-session switches and emit a full override instead of a short reminder.
# Only write on SessionStart (not SubagentStart) to avoid clobbering the session record.
if [[ "$EVENT_NAME" == "SessionStart" ]]; then
  if grep -q '^session_mode:' "$STATE_FILE"; then
    sed -i "s/^session_mode:.*/session_mode: $MODE/" "$STATE_FILE"
  else
    sed -i "/^mode:/a session_mode: $MODE" "$STATE_FILE"
  fi
fi

# Read style rules from shared file (single source of truth).
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(dirname "$SCRIPT_DIR")"
INSTRUCTIONS=$(cat "$PLUGIN_ROOT/rules/$MODE.md")

# Output hook JSON (jq escapes newlines/quotes so the string stays valid JSON)
jq -n --arg ctx "$INSTRUCTIONS" --arg evt "$EVENT_NAME" \
  '{hookSpecificOutput: {hookEventName: $evt, additionalContext: $ctx}}'
