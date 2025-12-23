#!/bin/bash
# List Claude Code session files for a project
# Usage: list-sessions.sh [project-path]
# If no project path given, uses current directory

set -e

# Get project path (default to CWD)
PROJECT_PATH="${1:-$(pwd)}"

# Encode project path: /Users/foo/bar -> -Users-foo-bar
ENCODED_PATH=$(echo "$PROJECT_PATH" | sed 's|/|-|g')

# Session directory
SESSION_DIR="$HOME/.claude/projects/$ENCODED_PATH"

if [ ! -d "$SESSION_DIR" ]; then
    echo "error: No session directory found for $PROJECT_PATH" >&2
    echo "       Expected: $SESSION_DIR" >&2
    exit 1
fi

echo "Session directory: $SESSION_DIR"
echo ""

# List main sessions (UUID format, sorted by modification time, newest first)
echo "Sessions (newest first):"
for file in $(ls -t "$SESSION_DIR"/*.jsonl 2>/dev/null); do
    filename=$(basename "$file" .jsonl)
    # Skip agent files
    if [[ "$filename" == agent-* ]]; then
        continue
    fi
    size=$(ls -lh "$file" | awk '{print $5}')
    modified=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M" "$file" 2>/dev/null || stat -c "%y" "$file" 2>/dev/null | cut -d'.' -f1)
    echo "  $filename  ($size, $modified)"
done

echo ""

# List agent files
AGENT_COUNT=$(ls "$SESSION_DIR"/agent-*.jsonl 2>/dev/null | wc -l | tr -d ' ')
if [ "$AGENT_COUNT" -gt 0 ]; then
    echo "Agent files ($AGENT_COUNT):"
    ls -t "$SESSION_DIR"/agent-*.jsonl 2>/dev/null | while read -r file; do
        filename=$(basename "$file")
        size=$(ls -lh "$file" | awk '{print $5}')
        echo "  $filename  ($size)"
    done
else
    echo "Agent files: none"
fi

echo ""
echo "To search:"
echo "  rg 'pattern' $SESSION_DIR/<session-id>.jsonl"
echo "  rg 'pattern' $SESSION_DIR/agent-*.jsonl  # all agents"
