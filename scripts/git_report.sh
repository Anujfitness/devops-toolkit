#!/usr/bin/env bash
# git_report.sh - kisi git repo ka quick summary: commits, authors, recent changes
set -euo pipefail
REPO="${1:-.}"
cd "$REPO"
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || { echo "Ye git repo nahi hai"; exit 1; }

echo "== Repo: $(basename "$(git rev-parse --show-toplevel)") =="
echo "Branch        : $(git rev-parse --abbrev-ref HEAD)"
echo "Total commits : $(git rev-list --count HEAD 2>/dev/null || echo 0)"
echo
echo "-- Top contributors --"
git shortlog -sn HEAD 2>/dev/null | head -5
echo
echo "-- Last 5 commits --"
git log --oneline -5 2>/dev/null
echo
echo "-- Uncommitted changes --"
git status --short
