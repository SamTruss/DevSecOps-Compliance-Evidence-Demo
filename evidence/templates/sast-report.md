# Evidence Template: SAST Report (Static Analysis)

## Metadata

| Field | Value |
|---|---|
| **Evidence Type** | Static Application Security Testing |
| **Tool** | Bandit |
| **Frequency** | Every PR |
| **Output Format** | JSON |
| **Retention** | 90 days (GitHub Actions artifact) |

## Controls Addressed

| Framework | Control | Description |
|---|---|---|
| SOC 2 | CC8.1 | Code analysed for security defects before merge |
| ISO 27001:2022 | A.8.28 | Automated enforcement of secure coding standards |
| ISO 27001:2022 | A.8.29 | Security testing integrated into development lifecycle |

## What This Evidence Shows

Bandit scans Python source code for common security issues including SQL injection, command injection, hardcoded credentials, weak cryptography, and insecure function usage. Each finding includes a CWE mapping and severity rating.

## How to Read the Output

```json
{
  "issue_severity": "HIGH",
  "issue_confidence": "HIGH",
  "issue_cwe": {"id": 89, "link": "https://cwe.mitre.org/data/definitions/89.html"},
  "issue_text": "Possible SQL injection vector through string-based query construction.",
  "filename": "app/server.py",
  "line_number": 37
}
```

## Auditor Notes

- Verify that HIGH/CRITICAL findings are either remediated or have a documented risk acceptance
- Check that SAST ran on the same commit SHA as the deployed artifact
- Confirm the scan was not bypassed (status check required in branch protection)
