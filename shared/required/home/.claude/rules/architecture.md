# Architecture Rules

## General

- Understand the existing architecture before making structural changes.
- Prefer extending existing architectural patterns over introducing a competing pattern.
- Keep responsibilities separated. UI, business logic, data access, and infrastructure should not become unnecessarily coupled.
- Keep dependencies flowing toward stable/core business logic rather than allowing infrastructure concerns to spread throughout the application.
- Prefer small, well-defined interfaces over large interfaces with unrelated responsibilities.
- Avoid introducing abstractions solely for theoretical future requirements.
- Do not perform broad architectural refactoring as part of a focused feature or bug fix unless it is necessary for the requested change.

## Application layers

Where the project uses layered architecture, generally keep these responsibilities separate:

- UI / presentation: user interaction and presentation concerns.
- Application/business logic: use cases, workflows, and business rules.
- Domain: core business concepts and rules where the project has a domain layer.
- Infrastructure: databases, filesystem, HTTP clients, external services, operating-system APIs, and other external concerns.

Business logic should not unnecessarily depend directly on UI frameworks, database implementations, filesystem details, or other infrastructure concerns.

## .NET

- Follow the project's existing dependency-injection approach.
- Prefer constructor injection for required dependencies.
- Avoid service locator patterns.
- Keep database access and external service calls behind appropriate boundaries when the architecture calls for them.
- Do not introduce a full framework or architectural pattern solely because it is fashionable; use the simplest approach that fits the existing system.
- For WinForms applications, keep substantial business logic outside Forms and event handlers.
- For scheduled tasks, keep scheduling/orchestration separate from the business operation being performed so the operation can be tested independently.

## Node.js / TypeScript

- Keep HTTP/framework-specific code at the application boundary where practical.
- Keep business logic independent of Express/Fastify/other web framework details when the project structure supports this.
- Separate external integrations from core application logic.
- Avoid allowing request/response objects to spread throughout business logic.
- Keep configuration/environment access centralized rather than reading environment variables throughout the application.

## Frontend

- Keep reusable UI components separate from business/domain logic where practical.
- Avoid putting API, persistence, or unrelated business logic directly into presentation components.
- Keep shared UI behavior in appropriate reusable components/utilities rather than duplicating it across pages.

## Data access

- Keep database-specific implementation details out of business logic where practical.
- Avoid spreading SQL/ORM-specific behavior throughout unrelated application code.
- Be explicit about transaction boundaries.
- Avoid hidden database/network calls from functions that appear to be simple in-memory operations.

## External systems

- Treat HTTP APIs, databases, filesystem operations, queues, and OS services as external boundaries.
- Handle failures at appropriate boundaries and preserve useful diagnostic information.
- Avoid making external dependencies implicit.
- Prefer interfaces or other appropriate boundaries when they materially improve testability or separation of concerns.

## Scheduled/background work

- Make scheduled operations safe to retry when practical.
- Avoid overlapping executions when the operation cannot safely run concurrently.
- Make failures observable through the project's existing logging/monitoring mechanisms.
- Separate scheduling concerns from the actual work being performed.
- Do not assume a scheduled task will always have an interactive user, desktop session, or writable working directory.
