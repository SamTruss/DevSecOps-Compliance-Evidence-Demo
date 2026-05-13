# Access Control Policy

**Effective Date:** 2026-05-01
**Owner:** Security Lead
**Review Cycle:** Annual
**Classification:** Internal

> *This is a fictional policy for demonstration purposes. Adapt it to your organisation's context before use.*

## 1. Purpose

Define how access to source code repositories, CI/CD pipelines, deployment environments, and evidence stores is granted, reviewed, and revoked.

## 2. Principles

- **Least privilege**: Users receive the minimum access required for their role
- **Separation of duties**: Code authors cannot approve their own changes
- **Need to know**: Access to production secrets and evidence stores is restricted to authorised personnel

## 3. Repository Access

| Role | Permissions | Granted By |
|---|---|---|
| Developer | Read + Write (feature branches) | Engineering Lead |
| Reviewer | Read + Write + Approve PRs | Engineering Lead |
| Admin | Full repository administration | CTO / Security Lead |

### Branch Protection (main)

- Require at least 1 approving review
- Require status checks to pass (CI pipeline)
- Require signed commits (recommended)
- Disallow force pushes
- Disallow branch deletion

## 4. CI/CD Pipeline Access

| Resource | Who Can Access | How |
|---|---|---|
| GitHub Actions secrets | Repository Admins only | GitHub encrypted secrets |
| Deployment credentials | Pipeline service account | OIDC federation (no long-lived keys) |
| Workflow logs | All repository members | Read-only via Actions UI |

## 5. Evidence Store Access

- Evidence artifacts are uploaded as GitHub Actions workflow artifacts
- Retention period: 90 days (configurable)
- Download access: Repository members with read permissions
- Integrity: SHA-256 manifest generated at bundle time

## 6. Access Reviews

- **Quarterly**: Repository collaborator list reviewed by Engineering Lead
- **On role change**: Access adjusted within 1 business day
- **On departure**: Access revoked within 24 hours

## 7. Secret Management

- No secrets committed to source code (enforced by Gitleaks)
- Pipeline secrets stored in GitHub encrypted secrets or a vault
- Secrets rotated on a defined schedule (90 days for service accounts, 180 days for API keys)
- Rotation evidence logged
