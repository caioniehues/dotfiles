#!/bin/bash
set -e

# Run from user-level hooks directory
cd "/home/caio/.claude/hooks"
cat | npx tsx skill-activation-prompt.ts
