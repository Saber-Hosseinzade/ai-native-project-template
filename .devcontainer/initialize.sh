#!/bin/sh
# Runs on the host before the container is built (initializeCommand), from the workspace folder.
# Usage: initialize.sh <workspace folder name>
# Creates the folders the container mounts, and the local-only Claude files CLAUDE.local.md and
# PROJECT_CONTEXT.md from their *.template.md in the repo (git-ignored).
# Existing files are never overwritten.
set -eu

name=$1
mkdir -p "$HOME/.aws-sandbox" "$HOME/.claude-projects/$name"

# Per-project local files (git-ignored), created once from the templates committed in the repo.
for file in CLAUDE.local PROJECT_CONTEXT; do
  if [ ! -e "$file.md" ] && [ -f "$file.template.md" ]; then
    cp "$file.template.md" "$file.md"
  fi
done
