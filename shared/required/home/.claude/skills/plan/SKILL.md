---
name: plan
description: Analyze a requested change and produce an implementation plan without modifying project files.
---

# Planning

Analyze the requested change before implementation.

## Process

1. Understand the requested outcome.
2. Inspect relevant existing code.
3. Identify existing patterns and similar functionality.
4. Identify affected components.
5. Identify dependencies between components.
6. Identify database, API, configuration, UI, and compatibility implications where applicable.
7. Identify testing requirements.
8. Identify risks and unknowns.
9. Produce a concrete implementation plan.

## Rules

- Do not modify project files.
- Do not invent architecture that is not supported by the existing codebase.
- Prefer existing patterns.
- Call out assumptions explicitly.
- Identify questions that need answers before implementation.

## Output

### Summary

What needs to change.

### Relevant files

Files/components likely to be modified.

### Implementation steps

Ordered steps for making the change.

### Testing

Tests that should be added or updated.

### Risks

Potential compatibility, migration, or operational concerns.

### Open questions

Information that should be clarified before implementation.
