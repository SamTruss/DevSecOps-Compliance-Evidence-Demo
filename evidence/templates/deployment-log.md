# Evidence Template: Deployment Audit Log

## Metadata

| Field | Value |
|---|---|
| **Evidence Type** | Deployment Audit Trail |
| **Source** | GitHub Actions pipeline metadata |
| **Frequency** | Every deployment to main |
| **Output Format** | JSON |
| **Retention** | 90 days (GitHub Actions artifact) |

## Controls Addressed

| Framework | Control | Description |
|---|---|---|
| SOC 2 | CC7.2 | Timestamped record of deployments with actor attribution |
| ISO 27001:2022 | A.8.31 | Audit trail proving deployments follow the approved pipeline |

## What This Evidence Shows

A timestamped, immutable record of every deployment: what code was deployed, who triggered it, from which commit, and through which pipeline run.

## How to Read the Output

```json
{
  "event": "deployment",
  "environment": "production",
  "actor": "SamTruss",
  "commit_sha": "a1b2c3d4e5f6...",
  "run_id": "1234567890",
  "run_number": "42",
  "timestamp": "2026-05-12T14:32:00Z",
  "status": "success"
}
```

## Auditor Notes

- Verify that `commit_sha` matches the change approval evidence for the same deployment
- Confirm deployments only occur from the `main` branch (check `ref` field)
- Cross-reference `run_id` with GitHub Actions to verify pipeline integrity
- Check for any deployments outside normal change windows
