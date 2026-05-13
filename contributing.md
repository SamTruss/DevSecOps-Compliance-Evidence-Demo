# Contributing

Thanks for your interest in improving this project. Contributions that extend the evidence collection model or add new control framework mappings are especially welcome.

## How to Contribute

1. **Fork** the repository
2. **Create a feature branch** from `main` (`git checkout -b feature/add-dast-stage`)
3. **Make your changes** with clear, descriptive commits
4. **Test locally** — run the scanning tools and verify evidence output
5. **Open a Pull Request** against `main`

## What We're Looking For

- New pipeline stages (DAST, IaC scanning, licence compliance)
- Additional control framework mappings (PCI DSS, HIPAA, NIST 800-53)
- Evidence template improvements
- Documentation fixes and clarifications
- Script hardening and portability improvements

## Guidelines

- **One concern per PR.** Don't mix a new feature with a documentation fix.
- **Describe the "why."** PR descriptions should explain what evidence gap or control mapping the change addresses.
- **Keep evidence realistic.** Example evidence should look like what a real tool would produce — don't fabricate implausible output.
- **Don't fix the intentional vulnerabilities** in `app/server.py` unless you're replacing them with a different intentional vulnerability that better demonstrates a scanning tool.

## Code Style

- Shell scripts: use `set -euo pipefail`, quote variables, use `shellcheck`
- Python: follow PEP 8, use type hints where practical
- YAML: 2-space indent, explicit `on:` triggers in workflows
- Markdown: one sentence per line for clean diffs

## Questions?

Open a discussion or issue. No question is too basic.
