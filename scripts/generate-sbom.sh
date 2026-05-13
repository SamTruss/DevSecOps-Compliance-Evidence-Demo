#!/usr/bin/env bash
# generate-sbom.sh — Generate a CycloneDX SBOM from requirements.txt
set -euo pipefail

EVIDENCE_DIR="${EVIDENCE_DIR:-evidence/output}"
mkdir -p "$EVIDENCE_DIR"

echo "[*] Generating CycloneDX SBOM from requirements.txt..."

if ! command -v cyclonedx-py &>/dev/null; then
    echo "[!] cyclonedx-bom not installed. Run: pip install cyclonedx-bom"
    exit 1
fi

cat requirements.txt | cyclonedx-py requirements - \
    -o "$EVIDENCE_DIR/sbom.json" \
    --of JSON

echo "[+] SBOM written to $EVIDENCE_DIR/sbom.json"
echo "[+] Component count: $(python3 -c "
import json, sys
with open('$EVIDENCE_DIR/sbom.json') as f:
    data = json.load(f)
print(len(data.get('components', [])))
")"
