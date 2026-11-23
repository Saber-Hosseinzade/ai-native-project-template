#!/bin/sh
# Runs on the host before the container is built (initializeCommand), from the workspace folder.
# Usage: initialize.sh <workspace folder name>
# Creates the folders the container mounts, and sets up the local-only Claude files:
#   ~/.claude-base/CLAUDE.md   optional personal rules for every project (imported at user level)
#   CLAUDE.local.md, PROJECT_CONTEXT.md   created from their *.template.md in the repo (git-ignored)
# Existing files are never overwritten.
set -eu

name=$1
base="$HOME/.claude-base"
claude_home="$HOME/.claude-projects/$name"

mkdir -p "$HOME/.aws-sandbox" "$claude_home" "$base"

# User-level instructions for this project's Claude config: import the shared personal rules.
if [ ! -f "$claude_home/CLAUDE.md" ]; then
  printf '%s\n' "@~/.claude-base/CLAUDE.md" >"$claude_home/CLAUDE.md"
fi

# Per-project local files (git-ignored), created once from the templates committed in the repo.
for file in CLAUDE.local PROJECT_CONTEXT; do
  if [ ! -e "$file.md" ] && [ -f "$file.template.md" ]; then
    cp "$file.template.md" "$file.md"
  fi
done
