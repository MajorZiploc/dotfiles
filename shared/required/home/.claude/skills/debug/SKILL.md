---
name: debug
description: Systematically investigate and fix bugs in the application. Use when the user reports incorrect, unexpected, or failing behavior.
---

# Debugging

Investigate the underlying cause before changing code.

## Process

1. Reproduce or clearly understand the reported behavior.
2. Identify the expected behavior.
3. Trace the relevant execution path.
4. Inspect recent changes when useful.
5. Form one or more concrete hypotheses.
6. Gather evidence to confirm or eliminate each hypothesis.
7. Identify the root cause.
8. Make the smallest appropriate fix.
9. Add or update a regression test when practical.
10. Run relevant tests or verification.
11. Check for obvious regressions caused by the fix.

## Important rules

- Do not immediately rewrite code based on the symptom alone.
- Do not make speculative changes without evidence.
- Prefer fixing the root cause rather than masking the symptom.
- Avoid unrelated cleanup while debugging.
- Preserve existing behavior outside the affected area.
- If the cause cannot be established, clearly distinguish facts from hypotheses.

## Logging and diagnostics

Use existing logging and diagnostic mechanisms before introducing new ones.

Temporary diagnostic logging may be added when useful, but remove it afterward unless it provides legitimate ongoing value.

## Output

Before making a substantial change, summarize:

- Observed behavior
- Expected behavior
- Likely root cause
- Evidence

After the fix, summarize:

- Root cause
- Change made
- Tests/verification performed
- Any remaining uncertainty
