#!/bin/sh
# Runs on the host before the container is built (initializeCommand), from the workspace folder.
# Usage: initialize.sh <workspace folder name>
# Creates the folders the container mounts, and wires in optional personal Claude notes:
#   ~/.claude-base/CLAUDE.md           personal rules for every project (imported at user level)
#   ~/.claude-base/CLAUDE.local.md     starting CLAUDE.local.md for a new project
#   ~/.claude-base/PROJECT_CONTEXT.md  starting project record for a new project
# Existing files are never overwritten. With an empty ~/.claude-base nothing else happens.
set -eu

name=$1
base="$HOME/.claude-base"
claude_home="$HOME/.claude-projects/$name"

mkdir -p "$HOME/.aws-sandbox" "$claude_home" "$base"

# User-level instructions for this project's Claude config: import the shared personal rules.
if [ ! -f "$claude_home/CLAUDE.md" ]; then
  printf '%s\n' "@~/.claude-base/CLAUDE.md" >"$claude_home/CLAUDE.md"
fi

# Per-project local files (git-ignored), created once from the personal templates.
for file in CLAUDE.local.md PROJECT_CONTEXT.md; do
  if [ ! -e "$file" ] && [ -f "$base/$file" ]; then
    cp "$base/$file" "$file"
  fi
done
