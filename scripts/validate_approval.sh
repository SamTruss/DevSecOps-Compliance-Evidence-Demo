#!/usr/bin/env bash
# validate-approval.sh — Verify that a PR was approved before merge
# Used as a deployment gate in the CI pipeline.
set -euo pipefail

# In GitHub Actions, these are set automatically.
# For local testing, pass them as arguments or environment variables.
PR_NUMBER="${1:-${PR_NUMBER:-}}"
GITHUB_TOKEN="${GITHUB_TOKEN:-}"
REPO="${GITHUB_REPOSITORY:-SamTruss/DevSecOps-Compliance-Evidence-Demo}"

if [ -z "$PR_NUMBER" ]; then
    echo "[!] No PR number provided."
    echo "    Usage: $0 <pr-number>"
    echo "    Or set PR_NUMBER environment variable."
    exit 1
fi

if [ -z "$GITHUB_TOKEN" ]; then
    echo "[!] GITHUB_TOKEN not set. Cannot query GitHub API."
    echo "    In Actions, this is provided automatically via github.token."
    exit 1
fi

echo "[*] Validating approval for PR #$PR_NUMBER in $REPO..."

# Fetch PR reviews from GitHub API
REVIEWS=$(curl -s \
    -H "Authorization: token $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/$REPO/pulls/$PR_NUMBER/reviews")

# Count approved reviews
APPROVED_COUNT=$(echo "$REVIEWS" | python3 -c "
import json, sys
reviews = json.load(sys.stdin)
approved = [r for r in reviews if r.get('state') == 'APPROVED']
print(len(approved))
")

echo "    Approved reviews: $APPROVED_COUNT"

if [ "$APPROVED_COUNT" -ge 1 ]; then
    echo "[+] PASS: PR #$PR_NUMBER has at least 1 approval."

    # Extract reviewer details for evidence
    echo "$REVIEWS" | python3 -c "
import json, sys
reviews = json.load(sys.stdin)
for r in reviews:
    if r.get('state') == 'APPROVED':
        print(f'    Reviewer: {r[\"user\"][\"login\"]} at {r[\"submitted_at\"]}')
"
    exit 0
else
    echo "[!] FAIL: PR #$PR_NUMBER has no approvals."
    echo "    Change management policy requires at least 1 approval before merge."
    exit 1
fi
