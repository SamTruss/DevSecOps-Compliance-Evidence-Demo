# Security Policy

## Reporting a Vulnerability

This repository is a **demonstration project** containing intentional vulnerabilities for educational purposes. The application code in `app/` is deliberately insecure and should never be deployed.

If you discover a security issue in the **pipeline logic, evidence generation scripts, or supporting tooling** (i.e., not the intentionally vulnerable demo app), please report it responsibly:

1. **Do not** open a public issue
2. Email: [security contact — replace before publishing]
3. Include: description, reproduction steps, and potential impact
4. Expected response time: 72 hours

## Scope

| In Scope | Out of Scope |
|---|---|
| GitHub Actions workflows | `app/server.py` (intentionally vulnerable) |
| Evidence generation scripts | Example evidence JSON files |
| Secret detection configuration | Third-party tool vulnerabilities |
| SBOM generation logic | |

## Supported Versions

| Version | Supported |
|---|---|
| `main` branch | Yes |
| All other branches | No |

## Disclosure Policy

We follow coordinated disclosure. Confirmed issues in pipeline/tooling code will be patched and credited within 30 days.
