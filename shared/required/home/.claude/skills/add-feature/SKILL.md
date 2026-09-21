---
name: add-feature
description: Plan and implement a new feature while following the existing application architecture and conventions.
---

# Add Feature

Use this workflow when implementing a new feature or significant enhancement.

## Before coding

1. Understand the requested behavior.
2. Inspect the existing architecture.
3. Find similar existing functionality.
4. Identify the appropriate components, services, modules, and boundaries.
5. Determine how the feature should be tested.
6. Identify potential compatibility concerns.

Do not start by creating new abstractions until existing patterns have been inspected.

## Implementation

- Follow existing architectural patterns.
- Reuse existing utilities and services when appropriate.
- Keep business logic separate from presentation and infrastructure concerns.
- Keep the implementation focused on the requested behavior.
- Avoid unrelated refactoring.
- Handle expected failure cases.
- Preserve backwards compatibility unless the feature explicitly requires breaking behavior.

## Testing

Add tests for:

- Normal behavior
- Important edge cases
- Failure/error behavior
- Regression scenarios where applicable

Run relevant tests after implementation.

## Final review

Before finishing:

- Inspect the final diff.
- Remove unnecessary changes.
- Verify error handling.
- Verify tests.
- Check that configuration changes are intentional.
- Check for accidentally committed secrets or local development artifacts.

Report what was changed and what was tested.
