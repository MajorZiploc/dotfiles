---
name: dependency-update
description: Safely evaluate and update NuGet, npm, or other project dependencies.
---

# Dependency Update

Treat dependency changes as potentially significant changes.

## Process

1. Identify the dependency and current version.
2. Determine why the update is needed.
3. Inspect the project's existing dependency conventions.
4. Check compatibility with the project's runtime and framework versions.
5. Inspect relevant changelog/release information when available.
6. Identify breaking changes or migration requirements.
7. Update the dependency.
8. Update lockfiles or related generated dependency files as appropriate.
9. Build the affected projects.
10. Run relevant tests.

## Rules

- Do not update unrelated dependencies unless explicitly requested.
- Do not blindly upgrade to the newest major version.
- Treat major-version upgrades as potentially breaking changes.
- Do not bypass dependency security or compatibility checks.
- Preserve reproducible builds.
- Do not manually edit generated lockfiles when the package manager should generate them.

## Final report

Report:

- Previous version
- New version
- Reason for update
- Compatibility concerns
- Tests/builds performed
- Any required follow-up
