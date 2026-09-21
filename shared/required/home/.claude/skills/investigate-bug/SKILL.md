---
name: investigate-bug
description: Investigate an unclear bug or unexpected behavior and determine its likely root cause without immediately modifying production code.
---

# Investigate Bug

The goal is to understand the problem before proposing or implementing a fix.

## Process

1. Restate the observed behavior.
2. Determine the expected behavior.
3. Locate the relevant code path.
4. Trace inputs and outputs.
5. Inspect relevant logs, configuration, and data.
6. Inspect recent changes when relevant.
7. Identify possible causes.
8. Gather evidence for each cause.
9. Determine the most likely root cause.

## Do not

- Make speculative production changes simply to see what happens.
- Rewrite unrelated code.
- Assume the reported symptom identifies the root cause.
- Treat an unverified hypothesis as fact.

## Output

Provide:

### Observed behavior

What is actually happening.

### Expected behavior

What should happen.

### Relevant code path

The important components involved.

### Root cause

The evidence-supported cause, if established.

### Possible alternatives

Other plausible causes that remain unverified.

### Recommended fix

The smallest appropriate fix, if one can be identified.
