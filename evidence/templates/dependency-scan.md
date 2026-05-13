# Evidence Template: Dependency Vulnerability Scan

## Metadata

| Field | Value |
|---|---|
| **Evidence Type** | Dependency Vulnerability Scan |
| **Tool** | Safety + CycloneDX SBOM |
| **Frequency** | Every PR + weekly scheduled scan |
| **Output Format** | JSON |
| **Retention** | 90 days (GitHub Actions artifact) |

## Controls Addressed

| Framework | Control | Description |
|---|---|---|
| SOC 2 | CC7.1 | Detection and monitoring of vulnerabilities in third-party components |
| Cyber Essentials | Malware Protection | Identification of components with known exploit chains |
| ISO 27001:2022 | A.8.9 | Software component inventory and risk assessment |

## What This Evidence Shows

1. **SBOM (Software Bill of Materials)**: Complete inventory of all third-party dependencies, their versions, and licence information in CycloneDX JSON format.
2. **Vulnerability report**: List of known CVEs affecting project dependencies, with severity ratings and remediation guidance.

## How to Read the Output

The Safety JSON output contains an array of vulnerability objects:

```json
{
  "package": "requests",
  "installed_version": "2.28.0",
  "vulnerability_id": "CVE-2023-32681",
  "severity": "MODERATE",
  "description": "Unintended leak of Proxy-Authorization header..."
}
```

## Auditor Notes

- Compare scan dates against the vulnerability management SLA (see `policies/vulnerability-management.md`)
- Verify that critical/high findings have corresponding remediation PRs
- Cross-reference SBOM against the deployed version to confirm scan covers production code
