# Change Management Policy

**Effective Date:** 2026-05-01
**Owner:** Engineering Lead
**Review Cycle:** Annual
**Classification:** Internal

> *This is a fictional policy for demonstration purposes. Adapt it to your organisation's context before use.*

## 1. Purpose

All changes to production systems, infrastructure, and application code must follow a controlled process that ensures review, approval, and auditability.

## 2. Scope

This policy applies to:

- Application source code (all repositories)
- Infrastructure-as-Code (Terraform, CloudFormation, Ansible)
- CI/CD pipeline configuration
- Production environment configuration
- Database schema changes

## 3. Change Types

| Type | Description | Approval Required |
|---|---|---|
| Standard | Routine, low-risk, pre-approved change types | Peer review (1 approver) |
| Normal | Non-routine changes requiring assessment | Peer review + Team Lead |
| Emergency | Critical fix for active incident | Retrospective review within 24 hours |

## 4. Process

### 4.1 Initiation

All changes are initiated via a Pull Request (PR) in the relevant repository. The PR must include:

- Description of the change and its purpose
- Risk assessment (what could go wrong)
- Rollback plan
- Testing evidence (local test output, CI results)

### 4.2 Review and Approval

- **Minimum one approval** required before merge to `main`
- Reviewer must not be the PR author
- CI pipeline must pass (all scanning stages green)
- PR approval metadata is captured as compliance evidence

### 4.3 Deployment

- Deployments occur only from the `main` branch
- Each deployment generates an audit trail entry (actor, SHA, timestamp)
- Failed deployments trigger automatic rollback and incident logging

### 4.4 Emergency Changes

- May bypass pre-merge review if an active incident requires immediate remediation
- Must be documented within 24 hours via a retrospective PR with full review
- Emergency change frequency is tracked and reported monthly

## 5. Evidence

The CI/CD pipeline automatically collects:

- PR approval metadata (reviewer, timestamp, PR number)
- Deployment logs (actor, commit SHA, environment, timestamp)
- All scan results associated with the merged code

Evidence is bundled into a SHA-256 signed manifest and retained as a workflow artifact.

## 6. Non-Compliance

Unapproved changes to `main` are flagged by branch protection rules and the `validate-approval.sh` script. Bypasses are logged and escalated to the Engineering Lead for review.
