# Testing Rules

## General

- Add or update tests when behavior changes.
- Prefer testing observable behavior rather than implementation details.
- Keep tests deterministic and independent from one another.
- Do not weaken or delete a test merely to make a change pass.
- When fixing a bug, prefer adding a regression test when practical.
- Run the smallest relevant test set first, then broader tests when appropriate.
- Do not claim a change is tested unless the relevant tests were actually run.
- If tests cannot be run, state why rather than implying they passed.

## Test quality

- Tests should clearly communicate what behavior they verify.
- Keep individual tests focused on one logical behavior.
- Avoid unnecessary setup that makes tests difficult to understand.
- Avoid excessive mocking. Mock external boundaries rather than internal implementation details.
- Prefer real implementations for simple in-process components when doing so makes tests more meaningful and reliable.
- Tests should not depend on execution order.

## Unit tests

- Unit tests should be fast and isolated.
- Avoid filesystem, network, database, or UI dependencies in unit tests unless they are specifically part of what is being tested.
- Test important edge cases, error paths, and boundary conditions rather than only the happy path.

## Integration tests

- Use integration tests for important interactions between components that cannot be meaningfully verified with unit tests.
- Keep external dependencies controlled and reproducible where practical.
- Clearly distinguish integration tests from unit tests according to the project's existing test organization.

## Web applications

- Test important API behavior independently from frontend presentation where practical.
- Test validation and error responses, not just successful requests.
- For important UI behavior, test user-visible behavior rather than framework implementation details.

## WinForms

- Keep business logic testable independently of forms and controls.
- Avoid putting substantial business logic directly inside event handlers.
- Prefer testing the underlying logic separately from UI interaction.
