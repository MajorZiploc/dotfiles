# Coding Rules

## General

- Prefer clear, readable code over clever or overly concise code.
- Follow existing project conventions before introducing new conventions.
- Keep changes focused on the requested task. Avoid unrelated refactoring.
- Prefer simple solutions over unnecessary abstractions.
- Do not duplicate logic when a well-scoped existing utility or service already provides the needed functionality.
- Keep functions and methods reasonably small and focused on one responsibility.
- Use descriptive names. Avoid abbreviations unless they are already established in the project.
- Prefer explicit behavior over implicit or surprising behavior.
- Handle errors deliberately. Do not silently swallow exceptions or errors.
- Do not add error handling that obscures the actual failure or makes debugging harder.
- Avoid magic numbers and strings when a named constant or configuration value would improve clarity.
- Remove dead code when it is directly related to the change, but do not perform broad cleanup unrelated to the task.
- Do not add dependencies unless they provide meaningful value and there is no reasonable existing solution.

## TypeScript / JavaScript

- Prefer TypeScript over JavaScript for new application code when the project supports it.
- Use strict typing. Avoid `any` unless there is a specific and documented reason.
- Prefer `async`/`await` for asynchronous code.
- Handle rejected promises and asynchronous errors explicitly.
- Follow the project's existing module and import conventions.
- Avoid unnecessary type assertions. Prefer fixing the underlying type definition.
- Do not use non-null assertions (`!`) unless the invariant is clear and justified.
- Keep browser/UI code separate from business logic where practical.

## C#

- Follow the project's configured .NET/C# version and existing style conventions.
- Use nullable reference types when enabled by the project.
- Prefer dependency injection when the application architecture already uses it.
- Use `async`/`await` for naturally asynchronous operations.
- Pass `CancellationToken` through asynchronous operations when the surrounding architecture supports cancellation.
- Avoid unnecessary `.Result`, `.Wait()`, or blocking asynchronous operations.
- Dispose `IDisposable` / `IAsyncDisposable` resources appropriately.
- Do not catch exceptions unless the code can meaningfully handle, translate, log, or recover from them.
- Preserve exception context when rethrowing or translating exceptions.

## F#

- Prefer immutable data and pure functions where practical.
- Make illegal states difficult to represent.
- Use pattern matching rather than deeply nested conditionals when it improves clarity.
- Follow the project's existing F# module and type conventions.
- Avoid introducing object-oriented abstractions when a simpler functional design fits the existing architecture.

## HTML / CSS

- Prefer semantic HTML.
- Keep presentation concerns in CSS rather than inline styles unless there is a specific reason.
- Follow the project's existing CSS organization and naming conventions.
- Preserve accessibility when modifying UI.
- Do not remove labels, keyboard navigation, ARIA information, or other accessibility behavior without understanding its purpose.
- Avoid introducing global CSS rules when a scoped rule is sufficient.

## Configuration and secrets

- Never hardcode passwords, API keys, tokens, connection strings containing credentials, or other secrets.
- Use the project's existing configuration and secret-management mechanisms.
- Do not commit local secrets or generated credentials.
- Do not modify production configuration merely to make local development work.
