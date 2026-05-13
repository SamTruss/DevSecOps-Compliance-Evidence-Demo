# DevSecOps Compliance Evidence Demo

> A runnable reference implementation showing how security compliance evidence can be collected, generated, and audited directly from a CI/CD pipeline — no spreadsheets required.

## Why This Exists

Auditors don't care that you *say* you do security. They want **evidence**: timestamped, attributable, and repeatable. Most teams scramble before an audit to screenshot dashboards and dig through Slack threads.

This repo flips the model. Every pipeline run **automatically generates compliance evidence** mapped to common control frameworks (SOC 2 Type II, Cyber Essentials, ISO 27001 Annex A). The result is a living evidence pack that stays current with every commit.

## What It Demonstrates

| Pipeline Stage | Evidence Produced | Controls Addressed |
|---|---|---|
| Dependency scanning | SBOM + vulnerability report (JSON) | SOC 2 CC7.1, CE Malware Protection |
| SAST (static analysis) | Findings report with severity + CWE mapping | SOC 2 CC8.1, ISO A.8.28 |
| Secret detection | Scan results (pass/fail + redacted matches) | SOC 2 CC6.1, ISO A.8.15 |
| Container image scan | Image CVE report | SOC 2 CC7.1, CE Secure Configuration |
| Change approval gate | PR approval metadata + reviewer identity | SOC 2 CC8.1, ISO A.8.32 |
| Deployment audit trail | Timestamped deployment log with actor + SHA | SOC 2 CC7.2, ISO A.8.31 |
| Evidence packaging | Signed evidence bundle (SHA-256 manifest) | SOC 2 CC7.4, audit trail integrity |

## Repo Structure

```
.
├── .github/
│   └── workflows/
│       ├── ci-pipeline.yml          # Main CI with evidence collection
│       ├── evidence-package.yml     # Post-merge evidence bundling
│       └── scheduled-scan.yml       # Weekly dependency re-scan
├── app/
│   └── server.py                    # Minimal Flask app (intentional vulns for demo)
├── evidence/
│   ├── templates/                   # Evidence document templates
│   │   ├── dependency-scan.md
│   │   ├── sast-report.md
│   │   ├── change-approval.md
│   │   ├── deployment-log.md
│   │   └── evidence-manifest.md
│   └── examples/                    # Pre-generated example evidence
│       ├── 2026-05-12_dependency-scan.json
│       ├── 2026-05-12_sast-bandit.json
│       ├── 2026-05-12_secret-scan.json
│       ├── 2026-05-12_change-approval.json
│       ├── 2026-05-12_deployment-log.json
│       └── MANIFEST.sha256
├── scripts/
│   ├── generate-sbom.sh             # CycloneDX SBOM generation
│   ├── package-evidence.sh          # Bundle + hash evidence artifacts
│   └── validate-approval.sh         # Check PR approval before deploy
├── policies/
│   ├── change-management.md         # Change management policy
│   ├── vulnerability-management.md  # Vuln management policy
│   └── access-control.md            # Access control policy
├── control-mapping/
│   └── control-matrix.md            # Evidence → control framework mapping
├── docker/
│   └── Dockerfile                   # Demo container (for image scanning)
├── requirements.txt
├── .gitleaks.toml                   # Secret detection config
├── .bandit.yml                      # SAST config
├── SECURITY.md
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
├── LICENSE
└── README.md
```

## Quick Start

### Prerequisites

- GitHub account (Actions used for CI/CD)
- Python 3.11+
- Docker (optional, for container scanning stage)

### Run Locally

```bash
# Clone
git clone https://github.com/SamTruss/devsecops-compliance-evidence-demo.git
cd devsecops-compliance-evidence-demo

# Install dependencies
pip install -r requirements.txt

# Run SAST locally
bandit -r app/ -f json -o evidence/local_sast.json

# Run secret detection locally
gitleaks detect --source . --report-format json --report-path evidence/local_secrets.json

# Generate SBOM
bash scripts/generate-sbom.sh

# Package evidence
bash scripts/package-evidence.sh
```

### Run via GitHub Actions

Push to any branch or open a PR. The pipeline will:

1. Run dependency scanning (Safety + CycloneDX SBOM)
2. Run SAST (Bandit)
3. Run secret detection (Gitleaks)
4. Validate PR approval (on `main` branch merges)
5. Build and scan Docker image (Trivy)
6. Generate timestamped evidence artifacts
7. Upload evidence bundle as a workflow artifact

## Evidence Output

Each pipeline run produces a `/evidence/` bundle containing:

- **Individual reports**: JSON artifacts from each tool
- **Metadata**: Git SHA, actor, timestamp, branch, PR number
- **Manifest**: SHA-256 hashes of every evidence file for tamper detection
- **Control mapping**: Which framework controls each artifact satisfies

Example manifest:

```
# Evidence Manifest — 2026-05-12T14:32:00Z
# Pipeline Run: 1847 | Actor: SamTruss | SHA: a1b2c3d
sha256:e3b0c442...  2026-05-12_dependency-scan.json
sha256:d7a8fbb3...  2026-05-12_sast-bandit.json
sha256:9f86d081...  2026-05-12_secret-scan.json
sha256:4e07408b...  2026-05-12_change-approval.json
sha256:6b86b273...  2026-05-12_deployment-log.json
```

## Control Framework Mapping

See [`control-mapping/control-matrix.md`](control-mapping/control-matrix.md) for the full matrix. Summary:

| Framework | Controls Demonstrated |
|---|---|
| **SOC 2 Type II** | CC6.1, CC7.1, CC7.2, CC7.4, CC8.1 |
| **Cyber Essentials** | Malware Protection, Secure Configuration |
| **ISO 27001:2022** | A.8.9, A.8.15, A.8.28, A.8.31, A.8.32 |

## Intentional Vulnerabilities

The demo app (`app/server.py`) contains **deliberate** security issues so the scanning tools have something to find:

- Hardcoded credentials (secret detection)
- SQL injection sink (SAST)
- Outdated dependency with known CVE (dependency scan)
- `FROM python:3.11` base image without pinning (container scan)

> **Do not deploy this application.** It exists solely to generate realistic scan findings.

## Extending This

- **Add DAST**: Integrate OWASP ZAP as a post-deploy scan stage
- **Add IaC scanning**: Checkov or tfsec for Terraform/CloudFormation
- **Integrate with GRC tools**: Export evidence to Drata, Vanta, or a SharePoint evidence library
- **Add SLA tracking**: Measure time-to-remediation from finding to fix

## Related

- [NIST SP 800-218 (SSDF)](https://csrc.nist.gov/publications/detail/sp/800-218/final) — Secure Software Development Framework
- [SOC 2 Trust Services Criteria](https://www.aicpa-cima.com/resources/landing/system-and-organization-controls-soc-suite-of-services) — AICPA TSC reference
- [CycloneDX SBOM Specification](https://cyclonedx.org/) — SBOM standard used here

## License

MIT — see [LICENSE](LICENSE).

## Author

**Sam Truss** — Security Analyst | MSP Security Operations | PhD Researcher (Agentic AI & Cyber Security)

- [GitHub](https://github.com/SamTruss)
- [LinkedIn](https://www.linkedin.com/in/samtruss)
