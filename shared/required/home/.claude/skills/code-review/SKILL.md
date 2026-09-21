---
name: code-review
description: Review code changes for correctness, bugs, maintainability, architecture, security, and testing. Use when reviewing a PR, diff, or completed implementation.
---

# Code Review

Review the requested changes systematically.

## Process

1. Inspect the relevant files and understand their surrounding code.
2. Inspect the git diff when reviewing existing changes.
3. Identify the intended behavior of the change.
4. Look for correctness issues and regressions.
5. Check error handling and edge cases.
6. Check whether the implementation follows existing project architecture.
7. Check for unnecessary complexity or duplication.
8. Check relevant tests.
9. Check for obvious security or data-handling problems.
10. Only then summarize the findings.

## Priorities

Prioritize findings in this order:

1. Bugs that can cause incorrect behavior or data loss.
2. Security issues.
3. Reliability and error-handling problems.
4. Breaking changes and compatibility problems.
5. Architectural problems that materially affect maintainability.
6. Missing or inadequate tests.
7. Readability and maintainability concerns.
8. Minor style issues.

Do not focus on stylistic preferences when they do not materially affect the code.

## Review behavior

- Do not criticize code merely because you would personally implement it differently.
- Respect established project conventions.
- Distinguish definite problems from potential concerns.
- Explain why each significant issue matters.
- Suggest a concrete fix when practical.
- Do not request broad refactoring unrelated to the change.

## Output

Summarize:

- Critical issues
- Important issues
- Minor issues
- Testing gaps
- Positive observations when useful

If there are no significant issues, say so clearly and identify any limitations in what was reviewed.
