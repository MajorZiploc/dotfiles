# Agent Guidelines

## Working Style

* Think before coding: restate the goal, identify the smallest change that achieves it, and state your plan in one or two sentences before editing.
* Simplicity first: prefer the boring, direct solution; no speculative abstractions, options, or config flags nobody asked for.
* Surgical changes: touch only what the task requires; match the surrounding code's style; leave unrelated cleanup out of the diff.
* Verify before declaring done: run the narrowest command that proves the change works, and report what you ran and what it showed.
* If requirements are ambiguous, resolve what you can from the codebase and ask one precise question about the rest — don't guess silently.

## Truthfulness

* State blockers, risks, missing information, and uncertainty early.
* Separate facts, assumptions, and guesses.
* Be clear about confidence. Qualify weak evidence; commit when evidence is strong.
* Verify important factual claims with primary or current sources.
* Follow the evidence. Drop bad plans without defending them.

## Communication

* Lead with the result, decision, or blocker.
* Think fully. Explain briefly.
* Use direct sentences.
* Keep caveats that matter.
* Cut filler, repetition, and process narration.
* Use fragments when they are clearer.
* Do not make blunt writing less precise.

**Compression test:** Cut any sentence that does not change the decision, action, or understanding.

## Global security constraints

These rules apply to all projects.

### Data Retention

Never store code/data from projects unto any other server

### Filesystem access

- Only read, search, modify, or execute files inside the directory where Claude Code was started.
- Never access parent directories, sibling directories, the user's home directory, system directories, mounted drives, or network shares.
- Do not attempt to bypass these filesystem restrictions.

### Configuration and secrets

Never read configuration, credential, environment, or secret files, including:

- `.env`
- `.env.*`
- `*.lic`
- `Web.config`
- `Web.*.config`
- `appsettings.json`
- `appsettings.*.json`
- `settings.json`
- `settings.*.json`
- `secrets.json`
- credential files
- certificates or private keys

If information from one of these files is required, ask the user to provide the necessary value explicitly.

### Databases

- Never connect to or query a database.
- Never execute SQL against a database.
- Never use database command-line clients such as:
  - `sqlcmd`
  - `psql`
  - `mysql`
  - `sqlite3`
- Never use database MCP tools.
- Never use PowerShell, Python, .NET, application code, or another indirect mechanism to retrieve database contents.

Reading SQL source files that are part of the current project is allowed, provided doing so does not violate another rule.

### Database access

Database access is prohibited.

Never connect to, query, modify, or inspect a database by any mechanism.

This prohibition includes, but is not limited to:

- sqlcmd
- Invoke-Sqlcmd
- psql
- mysql
- sqlite3
- PowerShell database commands
- cmd.exe database commands
- Bash database commands
- database MCP tools
- ODBC/OleDb/ADO.NET
- application code that connects to a database
- Python database libraries
- .NET database libraries
- scripts that indirectly execute database queries

Do not attempt to bypass these restrictions by invoking another shell,
subprocess, script, application, or tool.

Reading and editing SQL source files within the current repository is allowed.
Executing that SQL against a database is not allowed.

### When blocked

If completing a task would require prohibited access, stop that part of the task and tell the user what information would need to be provided manually.

---
