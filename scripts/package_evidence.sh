#!/usr/bin/env bash
# package-evidence.sh — Bundle evidence artifacts and generate SHA-256 manifest
set -euo pipefail

EVIDENCE_DIR="${EVIDENCE_DIR:-evidence/output}"

if [ ! -d "$EVIDENCE_DIR" ]; then
    echo "[!] Evidence directory not found: $EVIDENCE_DIR"
    echo "    Run the CI pipeline first, or set EVIDENCE_DIR."
    exit 1
fi

TIMESTAMP=$(date -u +%Y-%m-%dT%H:%M:%SZ)
COMMIT_SHA="${GITHUB_SHA:-$(git rev-parse HEAD 2>/dev/null || echo 'local')}"
ACTOR="${GITHUB_ACTOR:-$(whoami)}"
RUN_NUMBER="${GITHUB_RUN_NUMBER:-local}"

echo "[*] Packaging evidence artifacts..."
echo "    Directory: $EVIDENCE_DIR"
echo "    Timestamp: $TIMESTAMP"
echo "    Commit:    $COMMIT_SHA"
echo "    Actor:     $ACTOR"

# Count evidence files
FILE_COUNT=$(find "$EVIDENCE_DIR" -name "*.json" -type f | wc -l)
echo "    Files:     $FILE_COUNT JSON artifact(s)"

if [ "$FILE_COUNT" -eq 0 ]; then
    echo "[!] No evidence files found. Nothing to package."
    exit 1
fi

# Generate SHA-256 manifest
MANIFEST="$EVIDENCE_DIR/MANIFEST.sha256"

{
    echo "# Evidence Manifest — $TIMESTAMP"
    echo "# Pipeline Run: $RUN_NUMBER | Actor: $ACTOR | SHA: $COMMIT_SHA"
    echo "#"
    echo "# To verify: cd $EVIDENCE_DIR && sha256sum -c MANIFEST.sha256"
    echo ""
} > "$MANIFEST"

find "$EVIDENCE_DIR" -name "*.json" -type f | sort | while read -r file; do
    sha256sum "$file" >> "$MANIFEST"
done

echo ""
echo "[+] Manifest written to $MANIFEST"
echo ""
cat "$MANIFEST"
echo ""
echo "[+] Evidence packaging complete."
