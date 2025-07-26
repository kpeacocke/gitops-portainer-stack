#!/bin/bash

set -euo pipefail

REPO=${1:?Usage: bash sync-labels.sh owner/repo}

# Define desired labels: name|color|description
labels=(
  "bug|d73a4a|Something isn't working"
  "documentation|0075ca|Improvements or additions to documentation"
  "duplicate|cfd3d7|This issue or pull request already exists"
  "enhancement|a2eeef|New feature or request"
  "good first issue|7057ff|Good for newcomers"
  "help wanted|008672|Extra attention is needed"
  "invalid|e4e669|This doesn't seem right"
  "question|d876e3|Further information is requested"
  "wontfix|ffffff|This will not be worked on"
  "feature|1d76db|Implements a new capability"
  "config|c2e0c6|Changes to CI/CD or automation settings"
  "dependencies|0366d6|Dependency-related update"
  "stale|cccccc|Marked due to inactivity"
  "needs-review|fbca04|Waiting for code review"
  "needs-tests|f9d0c4|Requires test coverage"
  "wip|bfdadc|Work in progress — not ready to merge"
  "ready-to-merge|0e8a16|Meets requirements and ready to go"
  "blocked|e99695|Cannot proceed until external issue resolved"
  "ci|5319e7|Continuous integration/workflow"
  "docker|38434f|Container-specific changes"
  "docs|0b5cdd|Documentation or markdown edits"
)

for label in "${labels[@]}"; do
  IFS='|' read -r name color desc <<< "$label"
  echo "🔁 Creating/updating: $name"
  gh label create "$name" --color "$color" --description "$desc" --repo "$REPO" 2>/dev/null || \
  gh label edit "$name" --color "$color" --description "$desc" --repo "$REPO"
done

echo "✅ Label sync complete for $REPO"
