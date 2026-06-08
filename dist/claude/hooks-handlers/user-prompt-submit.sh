#!/usr/bin/env bash
set -euo pipefail

STATE_FILE="$HOME/.claude/no-fluff.state.md"

# No state yet → SessionStart will create it; nothing to reinforce.
[[ -f "$STATE_FILE" ]] || exit 0

FRONTMATTER=$(sed -n '/^---$/,/^---$/{ /^---$/d; p; }' "$STATE_FILE")
ENABLED=$(echo "$FRONTMATTER" | grep '^enabled:' | awk '{print $2}')
MODE=$(echo "$FRONTMATTER" | grep '^mode:' | awk '{print $2}')

[[ "$ENABLED" != "true" ]] && exit 0
[[ "$MODE" == "verbose" ]] && exit 0

if [[ "$MODE" == "terse" ]]; then
  REMINDER="No-fluff TERSE active. Fragments, arrows (→), drop articles/pronouns/pleasantries; code/paths/identifiers exact. Summaries follow same rules — no \"All green\", no prose recap. Self-check THIS reply before sending."
else
  REMINDER="No-fluff active. Strip fluff, answer-first, fragments over sentences; 100% technical accuracy. Summaries follow same rules — no prose recap. Self-check THIS reply before sending."
fi

jq -n --arg ctx "$REMINDER" \
  '{hookSpecificOutput: {hookEventName: "UserPromptSubmit", additionalContext: $ctx}}'
