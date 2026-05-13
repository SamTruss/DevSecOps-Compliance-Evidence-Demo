# Evidence Template: Evidence Manifest (SHA-256)

## Metadata

| Field | Value |
|---|---|
| **Evidence Type** | Integrity Manifest |
| **Tool** | sha256sum (coreutils) |
| **Frequency** | Generated with every evidence bundle |
| **Output Format** | Plain text (sha256sum format) |
| **Retention** | 90 days (GitHub Actions artifact) |

## Controls Addressed

| Framework | Control | Description |
|---|---|---|
| SOC 2 | CC7.4 | Tamper detection — any modification to evidence files is detectable |

## What This Evidence Shows

A cryptographic manifest of every evidence artifact in the bundle. If any file is modified after the manifest is generated, the SHA-256 hash will no longer match.

## How to Verify

```bash
cd evidence/output
sha256sum -c MANIFEST.sha256
```

Expected output (all files pass):
```
./dependency-scan.json: OK
./sast-bandit.json: OK
./secret-scan.json: OK
./change-approval.json: OK
./deployment-log.json: OK
```

## Auditor Notes

- Run the verification command above to confirm evidence integrity
- The manifest header includes the pipeline run number, actor, and commit SHA for traceability
- Any `FAILED` result indicates the evidence file was modified after generation
