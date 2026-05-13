# Control Framework Mapping Matrix

This document maps each evidence artifact produced by the pipeline to the specific controls it satisfies across SOC 2 Type II, Cyber Essentials / CE+, and ISO 27001:2022.

## Dependency Scanning → SBOM + Vulnerability Report

| Framework | Control ID | Control Name | How This Evidence Satisfies It |
|---|---|---|---|
| SOC 2 | CC7.1 | Detection of Changes | Automated detection of known vulnerabilities in third-party dependencies on every build |
| Cyber Essentials | Malware Protection | — | Identifies components with known exploit chains; supports patching decisions |
| ISO 27001:2022 | A.8.9 | Configuration Management | Inventories all software components (SBOM) and their known risk status |

## SAST (Bandit) → Static Analysis Findings Report

| Framework | Control ID | Control Name | How This Evidence Satisfies It |
|---|---|---|---|
| SOC 2 | CC8.1 | Change Management | Code is analysed for security defects before merge; findings are timestamped and attributable |
| ISO 27001:2022 | A.8.28 | Secure Coding | Automated enforcement of secure coding standards with CWE-mapped findings |
| ISO 27001:2022 | A.8.29 | Security Testing in Development and Acceptance | SAST runs as a mandatory pre-merge gate |

## Secret Detection (Gitleaks) → Scan Results

| Framework | Control ID | Control Name | How This Evidence Satisfies It |
|---|---|---|---|
| SOC 2 | CC6.1 | Logical Access Controls | Detects credentials committed to source code; prevents secret leakage into version history |
| ISO 27001:2022 | A.8.15 | Logging | Produces auditable record of secret scan pass/fail per commit |

## Container Image Scan (Trivy) → Image CVE Report

| Framework | Control ID | Control Name | How This Evidence Satisfies It |
|---|---|---|---|
| SOC 2 | CC7.1 | Detection of Changes | Identifies vulnerabilities in base images and OS packages at build time |
| Cyber Essentials | Secure Configuration | — | Ensures container images meet a known-good baseline before deployment |

## Change Approval Gate → PR Approval Metadata

| Framework | Control ID | Control Name | How This Evidence Satisfies It |
|---|---|---|---|
| SOC 2 | CC8.1 | Change Management | Proves every change to `main` was reviewed and approved by an authorised individual |
| ISO 27001:2022 | A.8.32 | Change Management | Captures reviewer identity, approval timestamp, and associated PR number |

## Deployment Audit Trail → Deployment Log

| Framework | Control ID | Control Name | How This Evidence Satisfies It |
|---|---|---|---|
| SOC 2 | CC7.2 | Monitoring of System Components | Timestamped record of what was deployed, by whom, and from which commit |
| ISO 27001:2022 | A.8.31 | Separation of Development, Testing and Production | Audit trail proves deployments follow the approved pipeline path |

## Evidence Manifest → SHA-256 Hash Bundle

| Framework | Control ID | Control Name | How This Evidence Satisfies It |
|---|---|---|---|
| SOC 2 | CC7.4 | Response to Identified Anomalies | Integrity verification — any tampering with evidence files is detectable via hash mismatch |

## Summary Matrix (Quick Reference)

| Evidence Artifact | SOC 2 | Cyber Essentials | ISO 27001:2022 |
|---|---|---|---|
| Dependency scan + SBOM | CC7.1 | Malware Protection | A.8.9 |
| SAST report | CC8.1 | — | A.8.28, A.8.29 |
| Secret detection | CC6.1 | — | A.8.15 |
| Container image scan | CC7.1 | Secure Configuration | — |
| Change approval | CC8.1 | — | A.8.32 |
| Deployment log | CC7.2 | — | A.8.31 |
| Evidence manifest | CC7.4 | — | — |
