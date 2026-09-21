---
name: refactor
description: Safely refactor existing code while preserving externally observable behavior.
---

# Refactoring

The primary goal is to improve structure without unintentionally changing behavior.

## Process

1. Understand the existing behavior.
2. Identify the specific structural problem.
3. Inspect callers and dependencies.
4. Identify existing tests that protect the behavior.
5. Make small, incremental changes.
6. Run tests after meaningful steps.
7. Inspect the final diff for unintended changes.

## Rules

- Preserve externally observable behavior unless a behavior change is explicitly requested.
- Do not combine unrelated feature work with the refactor.
- Prefer small changes that can be independently verified.
- Do not introduce abstractions without a concrete benefit.
- Do not rename public APIs merely for style unless required.
- Do not change serialization, database schemas, API contracts, or configuration formats without explicitly considering compatibility.

## Verification

Verify:

- Existing tests pass.
- Relevant new tests exist where appropriate.
- Public behavior remains compatible.
- No unnecessary dependencies were introduced.
- The resulting design is actually simpler or more maintainable.

If the proposed refactor is likely to have a large impact, explain the scope before implementing it.
