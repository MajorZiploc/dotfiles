# Global security constraints

These rules apply to all projects.

## Filesystem access

- Only read, search, modify, or execute files inside the directory where Claude Code was started.
- Never access parent directories, sibling directories, the user's home directory, system directories, mounted drives, or network shares.
- Do not attempt to bypass these filesystem restrictions.

## Configuration and secrets

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

## Databases

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

## Database access

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

## When blocked

If completing a task would require prohibited access, stop that part of the task and tell the user what information would need to be provided manually.
