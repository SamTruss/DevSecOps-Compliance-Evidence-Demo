# Evidence Template: Change Approval

## Metadata

| Field | Value |
|---|---|
| **Evidence Type** | Change Approval / PR Review Metadata |
| **Source** | GitHub Pull Request API |
| **Frequency** | Every PR merged to main |
| **Output Format** | JSON |
| **Retention** | 90 days (GitHub Actions artifact) |

## Controls Addressed

| Framework | Control | Description |
|---|---|---|
| SOC 2 | CC8.1 | Every change reviewed and approved by an authorised individual |
| ISO 27001:2022 | A.8.32 | Change management with reviewer identity and approval timestamp |

## What This Evidence Shows

Captures the approval chain for every code change merged to the main branch: who authored it, who reviewed it, when it was approved, and which PR it relates to.

## How to Read the Output

```json
{
  "pr_number": 12,
  "pr_title": "Fix SQL query parameterisation",
  "author": "developer-a",
  "merged_by": "reviewer-b",
  "approvals_required": 1,
  "head_sha": "a1b2c3d4e5f6...",
  "created_at": "2026-05-12T10:00:00Z",
  "captured_at": "2026-05-12T14:32:00Z"
}
```

## Auditor Notes

- Verify that `author` and `merged_by` are different individuals (separation of duties)
- Confirm `approvals_required` matches the branch protection policy (minimum 1)
- Cross-reference `head_sha` with the deployment log to confirm the reviewed code is what was deployed
