#!/usr/bin/env bash
set -euo pipefail

STATE_FILE="$HOME/.claude/no-fluff.state.md"

# No state yet → SessionStart will create it; nothing to reinforce.
[[ -f "$STATE_FILE" ]] || exit 0

FRONTMATTER=$(sed -n '/^---$/,/^---$/{ /^---$/d; p; }' "$STATE_FILE")
ENABLED=$(echo "$FRONTMATTER" | grep '^enabled:' | awk '{print $2}')
MODE=$(echo "$FRONTMATTER" | grep '^mode:' | awk '{print $2}')
SESSION_MODE=$(echo "$FRONTMATTER" | grep '^session_mode:' | awk '{print $2}')

[[ "$ENABLED" != "true" ]] && exit 0
[[ "$MODE" == "verbose" ]] && exit 0

# Detect mid-session mode switch: session_mode (set at SessionStart) differs from
# current mode (changed via skill). Emit full override rules to replace stale
# SessionStart context instead of a short reminder.
MODE_SWITCHED=false
if [[ -n "$SESSION_MODE" && "$SESSION_MODE" != "$MODE" ]]; then
  MODE_SWITCHED=true
fi

if [[ "$MODE_SWITCHED" == "true" ]]; then
  # Full override — read from shared rule file, prepend override preamble.
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  PLUGIN_ROOT="$(dirname "$SCRIPT_DIR")"
  RULES=$(cat "$PLUGIN_ROOT/rules/$MODE.md")
  REMINDER="OVERRIDE previous speaking style instructions — mode switched mid-session.

$RULES"
else
  # Normal per-turn reminder (mode unchanged since session start)
  if [[ "$MODE" == "terse" ]]; then
    REMINDER="No-fluff TERSE active. Fragments, arrows (→), drop articles/pronouns/pleasantries; code/paths/identifiers exact. Summaries follow same rules — no \"All green\", no prose recap. Self-check THIS reply before sending."
  else
    REMINDER="No-fluff active. Strip fluff, answer-first, fragments over sentences; 100% technical accuracy. Summaries follow same rules — no prose recap. Self-check THIS reply before sending."
  fi
fi

jq -n --arg ctx "$REMINDER" \
  '{hookSpecificOutput: {hookEventName: "UserPromptSubmit", additionalContext: $ctx}}'
