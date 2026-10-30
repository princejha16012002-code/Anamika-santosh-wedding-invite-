#!/usr/bin/env bash
# Publishes the wedding invitation to GitHub Pages (free).
# You need: git, and the GitHub CLI (gh) signed in with:  gh auth login
# Usage:  bash publish.sh            (repository name: anamika-santosh-wedding)
#         bash publish.sh my-name    (your own repository name)
set -euo pipefail

REPO_NAME="${1:-anamika-santosh-wedding}"
cd "$(dirname "$0")"

command -v git >/dev/null 2>&1 || { echo "Please install git first: https://git-scm.com/downloads"; exit 1; }
command -v gh  >/dev/null 2>&1 || { echo "Please install the GitHub CLI first: https://cli.github.com"; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "Please sign in first by running:  gh auth login"; exit 1; }

OWNER="$(gh api user --jq .login)"
echo "Publishing as GitHub user: $OWNER"

[ -d .git ] || git init -q -b main
git add -A
git -c user.name="${GIT_AUTHOR_NAME:-$OWNER}" \
    -c user.email="${GIT_AUTHOR_EMAIL:-$OWNER@users.noreply.github.com}" \
    commit -q -m "Wedding invitation" || echo "Nothing new to save."

if ! gh repo view "$OWNER/$REPO_NAME" >/dev/null 2>&1; then
  gh repo create "$OWNER/$REPO_NAME" --public --source=. --remote=origin
fi
git remote get-url origin >/dev/null 2>&1 || git remote add origin "https://github.com/$OWNER/$REPO_NAME.git"
git push -u origin main

# Turn on GitHub Pages and tell it to use the deploy workflow.
gh api -X POST "repos/$OWNER/$REPO_NAME/pages" -f build_type=workflow >/dev/null 2>&1 \
  || gh api -X PUT "repos/$OWNER/$REPO_NAME/pages" -f build_type=workflow >/dev/null 2>&1 \
  || echo "Could not switch on Pages automatically. Open Settings > Pages and set Source to GitHub Actions."

# Start the deploy (retry a few times while GitHub finishes registering the workflow).
for i in 1 2 3 4 5; do
  sleep 6
  if gh workflow run deploy.yml --repo "$OWNER/$REPO_NAME" >/dev/null 2>&1; then break; fi
done

echo
echo "Done. In 1 to 2 minutes your invitation will be live at:"
echo "  https://$OWNER.github.io/$REPO_NAME/"
echo "Open that link in Safari on your iPhone and tap the envelope."
